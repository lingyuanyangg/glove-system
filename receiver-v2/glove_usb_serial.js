// Max classic js (ES5). Native serial handles the OS port; this code never writes
// bytes to Arduino. The protocol is L/R plus five degree values, ending with ';'.
autowatch = 1;
inlets = 1;
outlets = 7;
// 0 serial commands, 1 engine, 2 OSC input gate, 3 port menu, 4 status,
// 5/6 left/right input labels. All state is local to this device instance.
var inputMode = 0, selected = '', ports = [], opened = false, initialized = false;
var refreshing = false, refreshAt = 0, awaitingCheck = false, checkAt = 0;
var buffer = '', discard = true, lastByteAt = 0, times = [0,0];
var badFrames = 0, boardFault = '', portFault = '', lastStatus = '', lastUi = 0;
var runner = new Task(tick, this), scan = new Task(refresh, this);
runner.interval = 50;
function now() { return Date.now(); }
function args(a) { return arrayfromargs(a); }
function finite(v) { return typeof v === 'number' && isFinite(v); }
function resetParser() { buffer='';discard=true;lastByteAt=0;times=[0,0];badFrames=0;boardFault=''; }
function title() {
    outlet(5,'set',inputMode ? 'USB  /  L' : 'IN 7000  ·  /servos');
    outlet(6,'set',inputMode ? 'USB  /  R' : 'IN 6000  ·  /servos');
}
function status(force) {
    var time=now();if(!force&&time-lastUi<200)return;lastUi=time;
    var s='OSC · USB closed';
    if(inputMode) {
        if(portFault)s=portFault;
        else if(!opened)s=refreshing?'USB · scanning ports':'USB · closed';
        else if(boardFault)s='USB · Right init error';
        else {
            var live=[];for(var h=0;h<2;h++)if(times[h]&&time-times[h]<=1000)live.push(h?'R':'L');
            s=live.length?'USB · '+live.join(' / '):'USB · waiting for data';
            if(badFrames)s+=' · bad '+badFrames;
        }
    }
    if(s!==lastStatus||force){lastStatus=s;outlet(4,'set',s);}
}
function init() {
    if(initialized)return;initialized=true;
    opened=false;resetParser();outlet(0,'close');outlet(0,'poll',0);
    outlet(2,inputMode?0:1);title();status(true);
    runner.cancel();runner.repeat();scan.cancel();scan.schedule(100);
}
function loadbang() { init(); }
function mode(v) {
    v=Number(v);if(v!==0&&v!==1)return;
    if(inputMode!==v){closePort();inputMode=v;outlet(1,'reset');}
    outlet(2,inputMode?0:1);title();status(true);
}
function closePort() {
    var wasOpen=opened;opened=false;awaitingCheck=false;
    outlet(0,'poll',0);outlet(0,'close');resetParser();portFault='';
    if(wasOpen)outlet(1,'reset');
}
function disconnect(v) { if(v===0)return;closePort();status(true); }
function refresh(v) {
    if(v===0)return;
    if(awaitingCheck){portFault='USB · wait for port check';status(true);return;}
    refreshing=true;refreshAt=now();
    outlet(0,'refresh');outlet(0,'print');status(true);
}
function fillMenu() {
    outlet(3,'clear');outlet(3,'append','Choose USB port');
    var index=0;for(var i=0;i<ports.length;i++) {
        outlet(3,'append',ports[i]);if(ports[i]===selected)index=i+1;
    }
    outlet(3,'set',index);
}
function chooseport(index) {
    index=Number(index);if(!finite(index)||index!==Math.floor(index)||index<0||index>ports.length)return;
    var next=index?ports[index-1]:'';
    if(next!==selected){closePort();selected=next;notifyclients();}
    status(true);
}
function getvalueof() { return selected||'none'; }
function setvalueof(v) {
    var next=String(v||'');if(next==='none')next='';
    if(/[\r\n\x00]/.test(next))return;
    if(next!==selected){closePort();selected=next;}
    fillMenu();status(true); // Restore only the port NAME; never open on recall.
}
function connect(v) {
    if(v===0)return;
    mode(1);this.patcher.getnamed('input_mode').message('set',1);
    if(refreshing){portFault='USB · wait for port list';status(true);return;}
    if(!selected||ports.indexOf(selected)<0){portFault='USB · select available port';status(true);return;}
    closePort();outlet(1,'reset');opened=true;
    outlet(0,'baud',115200);outlet(0,'databits',8);outlet(0,'stopbits',1);
    outlet(0,'parity',0);outlet(0,'xonxoff',0);
    // A port selection failure may revert to the previous name. Check the name
    // before accepting bytes; status only says streaming after a VALID frame.
    awaitingCheck=true;checkAt=now();outlet(0,'port',selected);outlet(0,'open');outlet(0,'getport');
    if(opened)outlet(0,'poll',5);
    status(true);
}
function samePort(a,b) {
    a=String(a);b=String(b);
    if(/^[a-z]$/.test(a)&&ports[a.charCodeAt(0)-97]===b)return true;
    return a.replace(/^\/dev\//,'')===b.replace(/^\/dev\//,'');
}
function serialinfo() {
    var a=args(arguments),kind=String(a.shift()||'');
    if(kind==='port') {
        if(refreshing) {
            ports=[];for(var i=0;i<a.length;i++) {
                var name=String(a[i]);if(name&&name!=='none'&&ports.indexOf(name)<0)ports.push(name);
            }
            refreshing=false;portFault='';fillMenu();
            if(opened&&ports.indexOf(selected)<0){closePort();portFault='USB · port disappeared';}
        } else if(awaitingCheck) {
            awaitingCheck=false;
            if(a.length!==1||!samePort(a[0],selected)){closePort();portFault='USB · port open failed';}
            else portFault='';
        }
    } else if(kind==='read'||kind==='write') {
        // Byte counters are not glove data or an acknowledgement of validity.
        return;
    } else if(kind==='error'||kind==='closed'||kind==='close') {
        closePort();portFault='USB · serial error / closed';
    } else if(kind) {
        // Unknown host status is not treated as a successful connection.
        post('Glove USB serial: '+kind+' '+a.join(' ')+'\n');
    }
    status(true);
}
function parseFrame(text) {
    var f=text.replace(/^\s+|\s+$/g,'').split(',');
    if(f.length!==6||(f[0]!=='L'&&f[0]!=='R'))return null;
    var v=[];
    for(var i=1;i<6;i++) {
        var s=f[i].replace(/^\s+|\s+$/g,'');
        if(!/^[+]?(?:\d+(?:\.\d*)?|\.\d+)$/.test(s))return null;
        var n=Number(s);if(!finite(n)||n<0||n>180)return null;v.push(n);
    }
    return {hand:f[0]==='L'?0:1,values:v};
}
function complete(text) {
    text=text.replace(/^\s+|\s+$/g,'');
    if(text==='')return;
    if(text.charAt(0)==='#') {
        if(text==='#ERROR,RIGHT_SERIAL_INIT') {boardFault=text;times[1]=0;outlet(1,'lostright');}
        status(false);return;
    }
    var frame=parseFrame(text);
    if(!frame){badFrames++;status(false);return;}
    times[frame.hand]=now();portFault='';if(frame.hand===1)boardFault='';
    outlet(1,[frame.hand===0?'rawleft':'rawright'].concat(frame.values));
    status(false);
}
function byte(v) {
    if(!inputMode||!opened||awaitingCheck)return;
    if(!finite(v)||v!==Math.floor(v)||v<0||v>255){buffer='';discard=true;badFrames++;return;}
    var time=now();
    if(buffer&&lastByteAt&&time-lastByteAt>250){buffer='';discard=true;badFrames++;}
    lastByteAt=time;
    if(v===59){if(!discard)complete(buffer);buffer='';discard=false;return;}
    if(v===10||v===13) {
        // A missing terminator cannot splice two newline-delimited packets.
        if(buffer){badFrames++;buffer='';}discard=false;return;
    }
    if(discard)return;
    if((v===9||v===32)&&!buffer)return;
    if((v<32&&v!==9)||v>126||buffer.length>=160){buffer='';discard=true;badFrames++;return;}
    buffer+=String.fromCharCode(v);
}
function msg_int(v) { byte(v); }
function list() { var a=args(arguments);for(var i=0;i<a.length;i++)byte(a[i]); }
function tick() {
    if(refreshing&&now()-refreshAt>1000){refreshing=false;portFault='USB · port list unavailable';}
    if(awaitingCheck&&now()-checkAt>2000){closePort();portFault='USB · port check timeout';}
    if(buffer&&lastByteAt&&now()-lastByteAt>250){buffer='';discard=true;badFrames++;}
    status(false);
}
function notifydeleted() { runner.cancel();scan.cancel();outlet(0,'poll',0);outlet(0,'close'); }
