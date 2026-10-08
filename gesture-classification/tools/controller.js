autowatch=0;inlets=1;outlets=4;
var owner=this.patcher,ready=false,uiReady=false,backend=null,clockTask=null,mode='left',running=false,runEpoch=0;
var banks={left:Gesture.bank(),right:Gesture.bank(),both:Gesture.bank()},frames={left:null,right:null},frameTimes={left:0,right:0},frameSeq=0;
var hold=120,cooldown=350,radius=0.18,epochs=500,pulse=120,temporal=new Gesture.Temporal(hold,cooldown),recording=null,trainer=null,trainingBank=null;
var mappings=[null,null,null,null,null,null],mapIDs=[0,0,0,0,0,0],actions=['toggle','toggle','toggle','toggle','toggle','toggle'],owned={},lastQuery=0,lastRecordSeq=-1;
var note='Record each gesture and Other, then Train',candidate='other',distance=null,models=[],modelSelection='',sequence=0,stored='',colors={},pendingExport=null,pendingImport=false;
function now(){return new Date().getTime();}
function say(s){note=s;}
function bank(){return banks[mode];}
function one(api,p){var a=api.get(p);return a instanceof Array?a[0]:a;}
function api(id){var a=new LiveAPI(null,'id '+id);if(!Number(a.id))throw Error('Mapped button was removed');return a;}
function parameter(id){
    var a=api(id);if(a.type!=='DeviceParameter')throw Error('Map a Live device parameter button');
    var lo=Number(one(a,'min')),hi=Number(one(a,'max')),q=Number(one(a,'is_quantized'));
    if(!isFinite(lo)||!isFinite(hi)||hi<=lo)throw Error('Mapped parameter has no usable range');
    if(q&&Math.abs(hi-lo-1)>1e-9||!q&&(Math.abs(lo)>1e-9||Math.abs(hi-1)>1e-9))throw Error('Map a two-state button (or a plug-in 0–1 switch)');
    var name=String(one(a,'name'));return {id:Number(id),lo:lo,hi:hi,name:name,api:a};
}
function write(p,v){var a=api(p.id);if(a.type!=='DeviceParameter'||!Number(one(a,'is_enabled')))throw Error('Button is unavailable or controlled elsewhere');if(Number(one(a,'min'))!==p.lo||Number(one(a,'max'))!==p.hi)throw Error('Button range changed; remap');a.set('value',v);}
function release(id){
    var o=owned[id];if(!o)return;delete owned[id];
    try{if(Math.abs(Number(one(api(o.p.id),'value'))-o.p.hi)<1e-7)write(o.p,o.p.lo);}catch(e){say('Release failed: '+e.message);}
}
function releaseSlot(slot){for(var id in owned)if(owned[id].slot===slot)release(id);}
function releaseAll(){for(var id in owned)release(id);}
function invalidate(){runEpoch++;if(backend)backend.invalidate();if(temporal.confirmed)actionExit(temporal.confirmed);temporal.reset();candidate='other';distance=null;lastQuery=0;releaseAll();}
function stop(){running=false;invalidate();}
function cancelTrain(){if(backend)backend.cancel();trainer=null;trainingBank=null;}
function stopRecord(){if(recording){recording=null;persist();}}
function fresh(time){
    var l=frames.left,r=frames.right;
    if(mode==='left'){if(!l||time-frameTimes.left>300)throw Error('Waiting for fresh GLeft');return l.slice();}
    if(mode==='right'){if(!r||time-frameTimes.right>300)throw Error('Waiting for fresh GRight');return r.slice();}
    if(!l||!r||time-frameTimes.left>300||time-frameTimes.right>300||Math.abs(frameTimes.left-frameTimes.right)>80)throw Error('Both hands need fresh synchronized frames');return l.concat(r);
}
function frame(hand,args){
    try{frames[hand]=Gesture.vector(args,5);frameTimes[hand]=now();frameSeq++;if((mode==='both'||mode===hand))processFrame(frameTimes[hand]);}catch(e){frameTimes[hand]=0;if(running){stop();say('Run stopped: '+e.message);}else say('Ignored invalid '+hand+' frame');}
}
function left(){frame('left',arrayfromargs(arguments));}function right(){frame('right',arrayfromargs(arguments));}
function processFrame(time){
    var x;try{x=fresh(time);}catch(e){return;}
    if(recording&&time>=recording.next&&frameSeq!==lastRecordSeq){
        var b=bank(),count=0;for(var i=0;i<b.samples.length;i++)if(b.samples[i].label===recording.label)count++;
        if(time>=recording.end||count>=400){stopRecord();say(count>=400?'400 examples for this class reached':'Recording complete · repeat from a different pose');}
        else{b.samples.push({x:x,label:recording.label,trial:recording.trial});b.model=null;b.loss=null;recording.next=time+50;lastRecordSeq=frameSeq;}
    }
    if(running&&time-lastQuery>=20){
        try{backend.predict(bank().model,x,{epoch:runEpoch,mode:mode,time:time});lastQuery=time;}catch(e){stop();say(e.message);}
    }
}
function mapped(slot){
    var a=arrayfromargs(arguments),i=Number(a.shift()),id=0;if(i<0||i>5||i!==Math.floor(i))return;
    for(var k=0;k<a.length;k++)if(a[k]!=='id'&&Number(a[k])>0){id=Number(a[k]);break;}
    if(ready&&id!==mapIDs[i])stop();releaseSlot(i);mapIDs[i]=id;mappings[i]=null;
    if(id&&ready)try{mappings[i]=parameter(id);say(Gesture.names[i]+' → '+mappings[i].name);}catch(e){say(e.message);}
    emit();
}
function actionEnter(label,time){
    var i=Gesture.labels.indexOf(label);if(i<0||i>5)return;
    outlet(1,'enter',mode,label,i+1);var p=mappings[i];if(!p)return;
    try{
        p=parameter(p.id);mappings[i]=p;var value=Number(one(p.api,'value')),type=actions[i];
        // A later action for the same target supersedes an earlier temporary hold.
        if(owned[p.id])delete owned[p.id];
        if(type==='toggle')write(p,value>(p.lo+p.hi)/2?p.lo:p.hi);
        else if(type==='off')write(p,p.lo);
        else{write(p,p.hi);if(type==='pulse'||type==='gate')owned[p.id]={slot:i,p:p,type:type,due:type==='pulse'?time+pulse:Infinity};}
    }catch(e){mappings[i]=null;say('Mapping: '+e.message);}
}
function actionExit(label){var i=Gesture.labels.indexOf(label);if(i>=0&&i<6)for(var id in owned)if(owned[id].slot===i&&owned[id].type==='gate')release(id);if(label&&label!=='other')outlet(1,'exit',mode,label,i+1);}
function prediction(label,x,tag){
    if(!running||tag.epoch!==runEpoch||tag.mode!==mode||now()-tag.time>300)return;
    try{fresh(now());}catch(e){invalidate();say(e.message);return;}
    var b=bank(),idx=Gesture.labels.indexOf(label);distance=Gesture.distance(x,b.samples,label);
    if(distance>radius||idx<6&&!b.enabled[idx])label='other';candidate=label;
    var event=temporal.feed(label,tag.time);if(event.exit)actionExit(event.exit);if(event.enter)actionEnter(event.enter,now());
}
function startRecord(label){
    if(Gesture.labels.indexOf(label)<0)throw Error('Unknown gesture');if(trainer||backend&&backend.job)throw Error('Cancel training and wait before recording');
    stop();stopRecord();fresh(now());recording={label:label,trial:'trial-'+now()+'-'+Math.floor(Math.random()*1e6),next:now(),end:now()+2000};lastRecordSeq=-1;say('Recording '+Gesture.names[Gesture.labels.indexOf(label)]+' · hold for 2 seconds');
}
function train(){
    stop();stopRecord();backend.check();var b=bank(),counts=countSamples(),a=b.samples.filter(function(s){return s.label==='other'||b.enabled[Gesture.labels.indexOf(s.label)];});
    var active=0;for(var i=0;i<6;i++)if(b.enabled[i]){active++;if(counts[i]<20)throw Error('Record at least 20 examples of '+Gesture.names[i]+' or disable it');}
    if(!active)throw Error('Enable at least one gesture');if(counts[6]<20)throw Error('Record at least 20 Other / transition examples');
    trainingBank=b;try{trainer=backend.start(a,Gesture.dim(mode),epochs);}catch(e){trainingBank=null;throw e;}say('Native FluCoMa training');
}
function trained(job){if(trainer!==job||job.cancelled||trainingBank!==bank())return;trainingBank.model=Gesture.copy(job.best);trainingBank.loss=job.bestLoss;trainer=null;trainingBank=null;say('Trained · test unfamiliar poses before enabling actions');persist();emit();}
function nativeError(s){stop();cancelTrain();say(s);emit();}
function nativeinput(){if(backend)backend.receive('input',arrayfromargs(arguments));}function nativelabels(){if(backend)backend.receive('labels',arrayfromargs(arguments));}function nativetrain(){if(backend)backend.receive('train',arrayfromargs(arguments));}function nativeinfer(){if(backend)backend.receive('infer',arrayfromargs(arguments));}
function countSamples(){var c=[0,0,0,0,0,0,0],a=bank().samples;for(var i=0;i<a.length;i++)c[Gesture.labels.indexOf(a[i].label)]++;return c;}
function tick(){
    var t=now();if(backend)backend.watch(t);
    for(var id in owned)if(owned[id].due<=t)release(id);
    if(recording&&t>=recording.end){stopRecord();say('Recording complete · repeat with small variations');}
    if(running)try{fresh(t);}catch(e){if(temporal.confirmed||candidate!=='other')invalidate();say(e.message);}
    if(trainer)say('FluCoMa training '+trainer.epoch+' / '+trainer.epochs+(Gesture.number(trainer.loss)?' · training RMSE '+trainer.loss.toFixed(4):''));emit();
}
function chunks(s){var a=[];for(var i=0;i<s.length;i+=4096)a.push(s.substring(i,i+4096));return a.length?a:[''];}
function persist(){stored=encodeURIComponent(JSON.stringify({version:1,mode:mode,banks:banks,models:models,modelSelection:modelSelection,hold:hold,cooldown:cooldown,radius:radius,epochs:epochs,pulse:pulse,actions:actions}));var a=chunks(stored);if(a.length===1)outlet(2,a[0]);else outlet.apply(this,[2,'list'].concat(a));}
function validSettings(d){
    var keys=['hold','cooldown','radius','epochs','pulse'],ranges=[[40,1000],[0,3000],[0.01,1],[50,3000],[40,1000]];
    for(var i=0;i<keys.length;i++)if(!Gesture.number(d[keys[i]])||d[keys[i]]<ranges[i][0]||d[keys[i]]>ranges[i][1])throw Error('Invalid '+keys[i]+' setting');
    if(!(d.actions instanceof Array)||d.actions.length!==6||d.actions.some(function(v){return ['toggle','pulse','gate','on','off'].indexOf(v)<0;}))throw Error('Invalid button actions');
}
function restore(){
    var encoded=arrayfromargs(arguments).join('');if(!encoded||encoded===stored)return;
    try{var d=JSON.parse(decodeURIComponent(encoded));if(d.version!==1)throw Error('Unsupported saved state');Gesture.dim(d.mode);validSettings(d);
        if(!d.banks)throw Error('Missing hand banks');for(var i=0;i<3;i++){var m=['left','right','both'][i];Gesture.validateBank(d.banks[m],Gesture.dim(m));}
        if(!(d.models instanceof Array)||d.models.length>64)throw Error('Invalid model library');var seen={};for(i=0;i<d.models.length;i++){Gesture.record(d.models[i]);if(seen[d.models[i].id])throw Error('Duplicate model ID');seen[d.models[i].id]=true;}
        stop();stopRecord();cancelTrain();banks=Gesture.copy(d.banks);models=Gesture.copy(d.models);mode=d.mode;hold=d.hold;cooldown=d.cooldown;radius=d.radius;epochs=d.epochs;pulse=d.pulse;actions=d.actions.slice();temporal=new Gesture.Temporal(hold,cooldown);modelSelection=seen[d.modelSelection]?d.modelSelection:'';stored=encoded;say('Restored · Run is off');emit();
    }catch(e){say('Saved state: '+e.message);}
}
function findModel(id){for(var i=0;i<models.length;i++)if(models[i].id===id)return models[i];throw Error('Choose a saved model');}
function saveModel(name){
    name=String(name||'').trim();if(!name||name.length>80)throw Error('Enter a name (1–80 characters)');if(models.length>=64)throw Error('64 saved models reached');
    var r=Gesture.record({format:'glove-gesture-model',version:1,id:'gesture-'+now()+'-'+Math.floor(Math.random()*1e9),name:name,savedAt:new Date().toISOString(),mode:mode,bank:Gesture.copy(bank())});models.push(r);modelSelection=r.id;persist();say('Model saved · save the Live Set or export JSON');
}
function directory(){var p=owner.filepath||'',i=p.lastIndexOf('/');return i<0?'':p.substring(0,i+1);}
function loadbang(){outlet(0,'readfile',directory()+'gesture_ui.html');}
function bang(){
    try{var self=new LiveAPI(null,'this_device');if(!Number(self.id))throw Error('Load the AMXD in Ableton Live');ready=true;
        for(var i=0;i<6;i++)if(mapIDs[i])try{mappings[i]=parameter(mapIDs[i]);}catch(e){mappings[i]=null;}
        if(!backend){backend=new GestureNative.Bridge(owner,String(jsarguments[1]),{prediction:prediction,trained:trained,error:nativeError,status:emit});backend.init();}
        if(clockTask)clockTask.cancel();clockTask=new Task(tick,this);clockTask.interval=25;clockTask.repeat();emit();
    }catch(e){ready=false;say(e.message);emit();}
}
function theme(name,r,g,b,a){if(['live_lcd_bg','live_control_text_bg','live_control_fg','live_lcd_control_fg','live_lcd_control_fg_zombie'].indexOf(String(name))<0)return;var v=[r,g,b,a];if(v.every(Gesture.number))colors[String(name)]=v;}
function command(encoded){
    try{var c=JSON.parse(decodeURIComponent(String(encoded)));
        if(c.op==='hello'){uiReady=true;emit();return;}
        if(c.op==='help'){outlet(3,'help');return;}
        if(c.op==='stop'){stop();cancelTrain();stopRecord();say('Stopped · temporary button holds released');emit();return;}
        if(c.op==='mode'){Gesture.dim(c.value);stop();cancelTrain();stopRecord();mode=c.value;say('Changed hand bank · Run is off');persist();}
        else if(c.op==='pickModel'){findModel(c.id);modelSelection=c.id;persist();}
        else if(c.op==='import'){pendingImport=true;outlet(3,'import');}
        else if(c.op==='export'){pendingExport=Gesture.copy(Gesture.record(findModel(c.id)));outlet(3,'export');}
        else if(c.op==='loadModel'){var r=Gesture.record(findModel(c.id));if(r.mode!==mode)throw Error('Choose '+r.mode+' mode first');stop();cancelTrain();stopRecord();banks[mode]=Gesture.copy(r.bank);modelSelection=r.id;persist();say('Loaded '+r.name+' · Run is off');}
        else if(c.op==='deleteModel'){findModel(c.id);models=models.filter(function(m){return m.id!==c.id;});if(modelSelection===c.id)modelSelection='';persist();}
        else{
            if(!ready)throw Error('Load this device in Ableton Live');
            if(c.op==='run'){if(running){stop();say('Run off');}else{if(recording||trainer||backend.job)throw Error('Finish recording/training first');backend.check();Gesture.model(bank().model,Gesture.dim(mode));fresh(now());stop();running=true;say('Classifying · hold a gesture to trigger its button');processFrame(now());}}
            else if(c.op==='record'){startRecord(c.label);}
            else if(c.op==='train'){if(trainer){cancelTrain();say('Training cancelled; previous completed model retained');}else train();}
            else if(c.op==='saveModel'){if(recording||trainer)throw Error('Finish recording/training first');saveModel(c.name);}
            else if(c.op==='action'){var i=Number(c.index);if(i<0||i>5||i!==Math.floor(i)||['toggle','pulse','gate','on','off'].indexOf(c.value)<0)throw Error('Invalid button action');stop();actions[i]=c.value;persist();}
            else if(c.op==='setting'){if(['hold','cooldown','radius','epochs','pulse'].indexOf(c.key)<0)throw Error('Unknown setting');var d={hold:hold,cooldown:cooldown,radius:radius,epochs:epochs,pulse:pulse,actions:actions};d[c.key]=Number(c.value);validSettings(d);stop();hold=d.hold;cooldown=d.cooldown;radius=d.radius;epochs=Math.floor(d.epochs);pulse=d.pulse;temporal=new Gesture.Temporal(hold,cooldown);persist();}
            else if(c.op==='enabled'||c.op==='clear'){
                if(recording||trainer||backend.job)throw Error('Stop recording/training first');var label=String(c.label),idx=Gesture.labels.indexOf(label);if(idx<0)throw Error('Invalid gesture');stop();
                if(c.op==='enabled'){if(idx===6)throw Error('Other class is always enabled');bank().enabled[idx]=!!c.value;}else bank().samples=bank().samples.filter(function(s){return s.label!==label;});bank().model=null;bank().loss=null;persist();
            }else throw Error('Unknown command');
        }
    }catch(e){say(e.message);}emit();
}
function dialogcancel(kind){if(kind==='import')pendingImport=false;else pendingExport=null;say('File dialog cancelled');emit();}
function filePath(args){var path=args.join(' ');if(!path||path.indexOf('\0')>=0)throw Error('Invalid file path');return path;}
function readmodel(){
    if(!pendingImport)return;pendingImport=false;
    try{var f=new File(filePath(arrayfromargs(arguments)),'read'),text='';if(!f.isopen)throw Error('Cannot open model JSON');try{if(f.eof>8*1024*1024)throw Error('Model file is too large');while(f.position<f.eof)text+=f.readstring(Math.min(4096,f.eof-f.position));}finally{f.close();}
        var r=Gesture.record(JSON.parse(text));if(models.length>=64)throw Error('64 saved models reached');r=Gesture.copy(r);r.id='gesture-'+now()+'-'+Math.floor(Math.random()*1e9);models.push(r);modelSelection=r.id;persist();say('Imported '+r.name+' · choose its hand mode and Load');
    }catch(e){say('Import: '+e.message);}emit();
}
function writemodel(){
    if(!pendingExport)return;var r=pendingExport;pendingExport=null;
    try{var path=filePath(arrayfromargs(arguments));if(!/\.json$/i.test(path))path+='.json';var f=new File(path,'write');if(!f.isopen)throw Error('Cannot write model JSON');try{f.eof=0;var s=JSON.stringify(r,null,2);for(var i=0;i<s.length;i+=4096)f.writestring(s.substring(i,i+4096));}finally{f.close();}say('Exported '+r.name);}catch(e){say('Export: '+e.message);}emit();
}
function emit(){
    if(!uiReady)return;var state={mode:mode,ready:ready,engineReady:!!(backend&&backend.available&&!backend.fault),running:running,training:!!trainer,recording:recording?recording.label:null,counts:countSamples(),enabled:bank().enabled,trained:!!bank().model,loss:bank().loss,hold:hold,cooldown:cooldown,radius:radius,epochs:epochs,pulse:pulse,actions:actions,note:note,candidate:candidate,confirmed:temporal.confirmed,distance:distance,left:frames.left,right:frames.right,leftFresh:!!frames.left&&now()-frameTimes.left<=300,rightFresh:!!frames.right&&now()-frameTimes.right<=300,colors:colors,targets:mappings.map(function(p){return p?p.name:'';}),models:models.map(function(r){return {id:r.id,name:r.name,mode:r.mode};}),modelSelection:modelSelection};
    var a=chunks(encodeURIComponent(JSON.stringify(state))),seq=++sequence;for(var i=0;i<a.length;i++)outlet(0,'statepacket',seq,i,a.length,a[i]);
}
function notifydeleted(){stop();if(clockTask)clockTask.cancel();cancelTrain();if(backend)backend.dispose();}
