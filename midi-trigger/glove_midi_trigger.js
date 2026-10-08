// Glove MIDI Trigger: physical GLeft/GRight frames only; ES5 for Max's js.
autowatch = 1;
inlets = 2;
outlets = 3; // complete MIDI packets, UI messages, persisted calibration reference
var globals = {sensitivity:100, threshold:0.25, reference:50, length:120, gap:40, channel:1, root:0, scale:1, vmin:20, vmax:127, markov:0};
var names = ['Pinky','Ring','Middle','Index','Thumb'];
var scales = [[0,1,2,3,4,5,6,7,8,9,10,11],[0,2,4,5,7,9,11],[0,2,3,5,7,8,10],
    [0,2,3,5,7,9,10],[0,1,3,5,7,8,10],[0,2,4,6,7,9,11],[0,2,4,5,7,9,10],
    [0,1,3,5,6,8,10],[0,2,4,7,9],[0,3,5,7,10],[0,3,5,6,7,10],[0,2,4,6,8,10]];
var ownerPatcher=this.patcher, restoring=true;
var fingers=[], hands=[], voices={}, enabled=1, calibrating=null, uiLast=-1000, uiCache={}, timer=null;
var thruStatus=0, thruNeed=0, thruData=[], sysex=null;
function now(){return Date.now();}
function clip(v,a,b){return Math.max(a,Math.min(b,v));}
function valid(v){return typeof v==='number' && isFinite(v);}
function freshState(){return {ready:false, armed:false, x:0, v:0, a:0, seenV:false,
    bendPeak:0,markovNote:null,
    peak:0, pending:0, lastHit:-10000, active:null, due:0, pressure:0, lastPressure:-1000, event:'--'};}
for(var j=0;j<10;j++)fingers.push({config:{on:1,mode:0,pitchmode:0,note:60+j,low:48,high:84},state:freshState()});
for(var h=0;h<2;h++)hands.push({last:-10000, sample:-10000, live:false});
function midi(status,a,b){var p=[status,a];if(b!==undefined)p.push(b);outlet(0,p);}
function ui(){var a=arrayfromargs(arguments), key=String(a[0]);if(key==='status'||key==='finger')key+=':'+a[1];var text=a.join('|');if(uiCache[key]!==text){uiCache[key]=text;outlet(1,a);}}
function release(i){
    var s=fingers[i].state;if(s.active===null)return;
    var key=String(s.active),group=voices[key];s.active=null;s.due=0;
    if(group){delete group[i];var count=0;for(var k in group)if(group.hasOwnProperty(k)&&k!=='pressure')count++;
        if(!count){midi(0x80+globals.channel-1,Number(key),0);delete voices[key];}
        else pressure(Number(key),true);}
}
function pressure(note,force){
    var group=voices[String(note)];if(!group)return;var max=0,old=group.pressure;
    for(var k in group)if(group.hasOwnProperty(k)&&k!=='pressure')max=Math.max(max,fingers[Number(k)].state.pressure);
    if(force||old!==max){midi(0xA0+globals.channel-1,note,max);group.pressure=max;}
}
function resetFinger(i){release(i);fingers[i].state=freshState();}
function panic(){for(var i=0;i<10;i++)resetFinger(i);voices={};ui('notice','Notes released. Lift fingers to re-arm.');}
function start(){restoring=true;uiCache={};panic();hands=[{last:-10000,sample:-10000,live:false},{last:-10000,sample:-10000,live:false}];
    calibrating=null;if(timer)timer.cancel();timer=new Task(tick,this);timer.interval=5;timer.repeat();report(true);}
function stop(){panic();calibrating=null;if(timer)timer.cancel();timer=null;}
function notifydeleted(){stop();}
function device(v){enabled=v?1:0;panic();calibrating=null;}
function config(i,key,v){
    if(!valid(i)||i<0||i>=10||Math.floor(i)!==i||!valid(v))return;
    var bounds={on:[0,1],mode:[0,1],pitchmode:[0,2],note:[0,127],low:[0,127],high:[0,127]};
    if(!bounds[key])return;v=Math.round(clip(v,bounds[key][0],bounds[key][1]));
    if(fingers[i].config[key]!==v){resetFinger(i);fingers[i].config[key]=v;}
}
function setting(key,v){
    var bounds={sensitivity:[10,400],threshold:[0.05,0.95],reference:[0.1,10000],length:[10,2000],gap:[20,2000],channel:[1,16],root:[0,11],scale:[0,11],vmin:[1,127],vmax:[1,127],markov:[0,5]};
    if(!bounds[key]||!valid(v))return;v=clip(v,bounds[key][0],bounds[key][1]);
    if(['channel','root','scale','vmin','vmax','markov'].indexOf(key)>=0)v=Math.round(v);
    if(globals[key]!==v){panic();globals[key]=v;}
}
// Read native On parameter state without a bang, which would toggle it.
function named(id){if(!ownerPatcher)return null;try{return ownerPatcher.getnamed(id);}catch(e){return null;}}
function fieldID(i,key){return (i<5?'Left':'Right')+'_'+names[i%5]+'_'+key;}
function finishinit(){
    for(var i=0;i<10;i++){
        var obj=named(fieldID(i,'on'));
        if(obj&&typeof obj.getvalueof==='function'){
            var value=obj.getvalueof();if(value instanceof Array)value=value[0];config(i,'on',Number(value));
        }
    }
    restoring=false;
}
function candidates(c){var out=[],set=scales[globals.scale];for(var n=c.low;n<=c.high;n++)if(set.indexOf((n-globals.root+120)%12)>=0)out.push(n);return out;}
// Presets define transition weights over the currently eligible MIDI notes.
// Each finger keeps its own previous note; every row is normalized when sampled.
var markovPresets=['Stepwise','Upward','Downward','Leaps','Tonic Pull','Balanced'];
function markovWeights(list,previous,preset){
    var row=[],from=0,best=1000;
    if(previous===null||previous===undefined){for(var i=0;i<list.length;i++)row.push(1);return row;}
    for(var i=0;i<list.length;i++){var distance=Math.abs(list[i]-previous);if(distance<best){best=distance;from=i;}}
    for(var i=0;i<list.length;i++){
        var d=i-from,a=Math.abs(d),w=1;
        if(preset===0)w=a===0?1:a===1?8:a===2?2:0.15/a;
        else if(preset===1)w=d===1?10:d===2?4:d===0?0.5:0.15/(a+1);
        else if(preset===2)w=d===-1?10:d===-2?4:d===0?0.5:0.15/(a+1);
        else if(preset===3)w=a===3||a===4?8:a>=5?4:a===2?1:0.2;
        else if(preset===4){var pc=(list[i]-globals.root+120)%12;w=(pc===0?10:pc===7?6:pc===3||pc===4?4:1)/(1+0.15*Math.abs(list[i]-previous));}
        else w=a===0?0.7:1/(1+0.08*a);
        if(preset===1&&from===list.length-1&&i===0)w=10;
        if(preset===2&&from===0&&i===list.length-1)w=10;
        row.push(w);
    }
    return row;
}
function markovChoose(c,state,list){
    var row=markovWeights(list,state?state.markovNote:null,globals.markov),total=0;
    for(var i=0;i<row.length;i++)total+=row[i];var draw=Math.random()*total,n=list[list.length-1];
    for(var i=0;i<row.length;i++){draw-=row[i];if(draw<0){n=list[i];break;}}
    if(state)state.markovNote=n;return n;
}
function choose(c,state){
    if(!c.pitchmode)return c.note;var list=candidates(c);if(!list.length)return null;
    return c.pitchmode===2?markovChoose(c,state,list):list[Math.floor(Math.random()*list.length)];
}
function velocity(strength){return Math.round(clip(globals.vmin+clip(strength,0,1)*(globals.vmax-globals.vmin),1,127));}
function trigger(i,strength,hold,t){
    var f=fingers[i],s=f.state,note=choose(f.config,s);
    if(note===null){s.event='No notes';ui('notice','No scale notes in '+names[i%5]+' range. Adjust Low / High.');return false;}
    release(i);var vel=velocity(strength);s.active=note;s.pressure=vel;s.lastPressure=t;
    var key=String(note),group=voices[key];
    if(!group){group={};voices[key]=group;group[i]=true;midi(0x90+globals.channel-1,note,vel);}
    else {group[i]=true;pressure(note,true);} // shared pitch: one voice until final owner releases
    s.due=hold?0:t+globals.length;s.event=note+' / '+vel;return true;
}
function receive(h,args){
    var a=arrayfromargs(args);if(a.length!==5)return;
    for(var i=0;i<5;i++)if(!valid(a[i])||a[i]<0||a[i]>1)return;
    var t=now(),hand=hands[h],dt=t-hand.sample;
    hand.last=t;hand.live=true;
    if(dt<5)return; // coalesce arrivals; keep previous sample time and values
    var reset=dt>100;hand.sample=t;
    for(i=0;i<5;i++){
        var f=fingers[h*5+i],s=f.state,c=f.config,x=a[i];
        if(reset||!s.ready){release(h*5+i);s=freshState();f.state=s;s.ready=true;s.x=x;s.bendPeak=x;s.armed=x<0.45;continue;}
        var seconds=dt/1000,alpha=1-Math.exp(-dt/20),beta=1-Math.exp(-dt/30);
        var rawV=(x-s.x)/seconds,previousV=s.v; s.v+=alpha*(rawV-s.v);
        s.a+=beta*((s.v-previousV)/seconds-s.a);s.seenV=true;
        s.x=x;var flexing=rawV>0.2&&s.v>previousV,mag=flexing?Math.max(0,s.a):0,score=mag/globals.reference*globals.sensitivity/100;
        if(calibrating&&c.on){var slot=calibrating.peaks[h*5+i];if(mag>slot.max)slot.max=mag;
            if(t-slot.since>=120){if(slot.max>0.5)calibrating.samples.push(slot.max);slot.max=0;slot.since=t;}}
        if(!enabled||!c.on||calibrating||restoring)continue;
        if(c.mode===1){
            if(x<0.45){release(h*5+i);s.armed=true;}
            else if(x>0.5&&s.armed&&s.active===null){trigger(h*5+i,(x-0.5)/0.5,true,t);s.armed=false;}
            if(s.active!==null&&t-s.lastPressure>=25){var v=velocity((x-0.5)/0.5);s.lastPressure=t;
                if(v!==s.pressure){s.pressure=v;pressure(s.active,false);s.event=s.active+' / '+v;}}
        }else{
            // Piano-like downstroke: increasing curl + positive acceleration only.
            // A real return stroke re-arms immediately; stopping never re-arms.
            s.bendPeak=Math.max(s.bendPeak,x);
            if(rawV<0&&s.bendPeak-x>=0.02){s.armed=true;s.bendPeak=x;}
            if(s.pending){if(flexing)s.peak=Math.max(s.peak,score);}
            else if(flexing&&score>=globals.threshold&&s.armed&&t-s.lastHit>=globals.gap){
                s.armed=false;s.pending=t+15;s.peak=score;
            }
        }
    }
}
function left(){receive(0,arguments);}
function right(){receive(1,arguments);}
function calibrate(){
    if(calibrating){calibrating=null;panic();ui('notice','Calibration cancelled. Previous reference kept.');return;}
    panic();var t=now(),peaks=[];for(var i=0;i<10;i++)peaks.push({max:0,since:t});
    calibrating={end:t+8000,samples:[],peaks:peaks};ui('notice','Calibrating 8 s: make typical strikes with enabled fingers.');
}
function finishCalibration(){
    var a=calibrating.samples;for(var i=0;i<10;i++)if(calibrating.peaks[i].max>0.5)a.push(calibrating.peaks[i].max);
    a.sort(function(x,y){return x-y;});calibrating=null;panic();
    if(a.length<8){ui('notice','Too little motion. Reference unchanged; repeat calibration.');return;}
    globals.reference=clip(a[Math.floor((a.length-1)*0.95)],0.1,10000);
    outlet(2,['reference',globals.reference]);ui('notice','Calibrated. Return to neutral; Sens boosts trigger strength.');
}
function tick(){var t=now();
    for(var h=0;h<2;h++)if(hands[h].live&&t-hands[h].last>250){
        hands[h].live=false;hands[h].sample=-10000;for(var k=0;k<5;k++)resetFinger(h*5+k);}
    for(var i=0;i<10;i++){var s=fingers[i].state;
        if(s.pending&&t>=s.pending){var strength=clip((s.peak-globals.threshold)/(1-globals.threshold),0,1);
            trigger(i,strength,false,t);s.pending=0;s.lastHit=t;}
        if(s.due&&t>=s.due)release(i);}
    if(calibrating&&t>=calibrating.end)finishCalibration();report(false);
}
function report(force){var t=now();if(!force&&t-uiLast<40)return;uiLast=t;
    ui('status',0,hands[0].live?'LIVE':'WAIT');ui('status',1,hands[1].live?'LIVE':'WAIT');
    for(var i=0;i<10;i++)ui('finger',i,names[i%5]+(fingers[i].state.active!==null?' *':''));
    if(calibrating)ui('notice','Calibrating '+Math.ceil((calibrating.end-t)/1000)+' s: make typical strikes.');
}
// Reconstruct complete incoming messages, so inserted generated packets cannot break running status.
function msg_int(v){if(inlet!==1||!valid(v))return;v=Math.floor(v);if(v<0||v>255)return;
    if(v>=248){outlet(0,[v]);return;}
    if(sysex){if(v===247){sysex.push(v);outlet(0,sysex);sysex=null;return;}
        if(v<128){if(sysex.length<65535)sysex.push(v);else sysex=null;return;}sysex=null;}
    if(v>=128){thruData=[];thruStatus=v;
        if(v===240){sysex=[v];thruStatus=0;return;}
        if(v>=240){thruNeed=(v===241||v===243)?1:(v===242?2:0);if(!thruNeed){outlet(0,[v]);thruStatus=0;}return;}
        thruNeed=(v>>4===12||v>>4===13)?1:2;return;}
    if(!thruStatus||!thruNeed)return;thruData.push(v);
    if(thruData.length===thruNeed){outlet(0,[thruStatus].concat(thruData));thruData=[];if(thruStatus>=240)thruStatus=0;}
}
