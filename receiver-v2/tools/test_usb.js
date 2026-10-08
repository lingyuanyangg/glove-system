// Execute the actual shipped USB controller and engine with simulated Max peers.
const fs=require('fs'),path=require('path'),vm=require('vm'),assert=require('assert');
const root=path.resolve(__dirname,'..');let time=10000,count=0;
function rig(){
 const logs=[],engineOutputs=[],ui=[],saved=[];
 function Task(fn){this.fn=fn;this.cancel=()=>{};this.repeat=()=>{};this.schedule=()=>{};}
 const common={Date:{now:()=>time},isFinite,Math,Number,String,
   arrayfromargs:a=>Array.from(a),Task};
 const engine={...common,outlet:(i,...a)=>engineOutputs.push([i,...a])};
 vm.createContext(engine);vm.runInContext(fs.readFileSync(path.join(root,'glove_dual_engine.js'),'utf8'),engine);engine.start();
 const c={...common,post:()=>{},notifyclients:()=>saved.push(true),
   patcher:{getnamed:n=>({message:(...a)=>ui.push([n,...a])})},
   outlet:(i,...a)=>{
     if(a.length===1&&Array.isArray(a[0]))a=Array.from(a[0]);logs.push([i,...a]);
     if(i===1){const name=a.shift();engine[name](...a);}
   }};
 vm.createContext(c);vm.runInContext(fs.readFileSync(path.join(root,'glove_usb_serial.js'),'utf8'),c);
 c.init();return {c,engine,logs,engineOutputs,ui,saved};
}
const a=rig(),c=a.c;const port='cu.usbmodem101';
function test(name,fn){fn();count++;console.log('PASS '+name);}
function scan(r=a,names=[port,'cu.usbserial-A']){r.c.refresh();r.c.serialinfo('port',...names);}
function open(r=a){scan(r);r.c.chooseport(1);r.c.connect(1);r.c.serialinfo('port',port);}
function send(s,r=a){r.c.list(...Buffer.from(s,'ascii'));}
function sync(r=a){time+=10;r.engine.tick();}
const left='L,90.0,99.0,99.0,99.0,125.0;\n',right='R,180.0,160.0,150.0,149.0,134.5;\n';
function commands(r=a){return r.logs.filter(x=>x[0]===0).map(x=>x.slice(1));}
test('startup is closed, idle polling and OSC gates are enabled',()=>{
 assert.equal(c.opened,false);assert(commands().some(x=>x[0]==='close'));assert(commands().some(x=>x[0]==='poll'&&x[1]===0));assert(a.logs.some(x=>x[0]===2&&x[1]===1));
});
test('native port enumeration populates menu and keeps names, never indices',()=>{
 scan();assert.deepEqual(Array.from(c.ports),[port,'cu.usbserial-A']);assert(a.logs.some(x=>x[0]===3&&x[1]==='append'&&x[2]===port));c.chooseport(1);assert.equal(c.getvalueof(),port);assert(a.saved.length);
});
test('Open selects USB, closes OSC gates, configures 115200 8N1 and polls',()=>{
 c.connect(1);assert.equal(c.inputMode,1);assert(c.awaitingCheck);assert(a.ui.some(x=>x[0]==='input_mode'&&x[1]==='set'&&x[2]===1));
 assert(a.logs.some(x=>x[0]===2&&x[1]===0));assert(commands().some(x=>x[0]==='baud'&&x[1]===115200));assert(commands().some(x=>x[0]==='xonxoff'&&x[1]===0));
 c.refresh(1);assert(!c.refreshing&&c.awaitingCheck);
 send(left);assert.equal(c.times[0],0);c.serialinfo('port',port);assert(!c.awaitingCheck&&!c.portFault);assert(commands().some(x=>x[0]==='poll'&&x[1]===5));
});
test('initial partial frame is discarded; split packets and CRLF reassemble',()=>{
 send('junk;\r\nL,90.');send('0,99.0,99.0,99.0,125.0;\r\n');sync();
 assert(a.engineOutputs.some(x=>x[0]===3&&x[1].every(v=>Math.abs(v-.5)<1e-8)));
});
test('both hands route separately into existing calibration, maps and buses',()=>{
 send(right);sync();assert.equal(a.engine.hands[1].target[0],1);assert(Math.abs(a.engine.hands[1].target[4]-(134.5-70)/110)<1e-8);assert(a.engineOutputs.some(x=>x[0]===4));assert.equal(a.engine.hands[0].target[0],.5);
});
test('strict fields reject short, extra, nonfinite, exponent, negative and range errors',()=>{
 const t=c.times[0],before=c.badFrames;
 for(const s of ['L,1,2;','L,1,2,3,4,5,6;','L,NaN,1,2,3,4;','L,1e2,1,2,3,4;','L,-1,1,2,3,4;','L,181,1,2,3,4;','X,1,2,3,4,5;','L,,1,2,3,4;'])send(s);
 assert.equal(c.times[0],t);assert.equal(c.badFrames-before,8);
});
test('whitespace and decimal angles retain precision',()=>{
 send(' \tL, 90.1 ,99,99,99,125;\r\n');assert.equal(a.logs.filter(x=>x[0]===1&&x[1]==='rawleft').slice(-1)[0][2],90.1);
});
test('overflow drops the whole suffix and valid packets recover',()=>{
 const t=c.times[0];time+=20;send('L,'+'1'.repeat(200)+left);assert.equal(c.times[0],t);send(left);assert.equal(c.times[0],time);
});
test('whitespace overflow is bounded too',()=>{
 send('L,'+' '.repeat(300));assert(c.discard&&c.buffer.length===0);send(';');send(left);assert.equal(c.times[0],time);
});
test('invalid byte and binary input discard malformed frames',()=>{
 const t=c.times[0];time+=20;c.byte(999);send(left);assert.equal(c.times[0],t);send(left);c.byte(0);send(right);assert.notEqual(c.times[1],time);send(right);assert.equal(c.times[1],time);
});
test('missing terminators cannot merge newline-separated packets',()=>{
 const t=c.times[0];time+=20;send('L,90,99,99,99,125\n');assert.equal(c.times[0],t);send(left);assert.equal(c.times[0],time);
});
test('timed-out partial packets cannot masquerade as fresh frames',()=>{
 const t=c.times[0];send('L,90,99');time+=251;c.tick();send(',99,99,125;');assert.equal(c.times[0],t);send(left);assert.equal(c.times[0],time);
});
test('read/write counters never create glove data or refresh timestamps',()=>{
 const t=c.times[0];time+=20;c.serialinfo('read',100);c.serialinfo('write',10);assert.equal(c.times[0],t);
});
test('firmware Right initialization errors hold Right while Left continues',()=>{
 send('#ERROR,RIGHT_SERIAL_INIT;\n');assert(c.boardFault);assert.equal(a.engine.hands[1].status,'HOLD');assert(!a.engine.hands[1].pendingBus);
 send(left);assert.equal(c.times[0],time);c.status(true);assert(c.lastStatus.includes('Right init error'));send(right);assert(!c.boardFault);
});
test('stationary dual USB frames keep downstream consumers fresh for training',()=>{
 a.engineOutputs.length=0;
 for(let i=0;i<100;i++){time+=20;send(left+right);a.engine.tick();}
 const l=a.engineOutputs.filter(x=>x[0]===3),r=a.engineOutputs.filter(x=>x[0]===4);
 assert.equal(l.length,100);assert.equal(r.length,100);assert(l.every(x=>x[1].length===5));
 const n=a.engineOutputs.length;time+=30;a.engine.tick();assert.equal(a.engineOutputs.length,n);
});
test('loss reports no data and never fabricates heartbeat frames',()=>{
 time+=1200;c.tick();a.engine.tick();assert(c.lastStatus.includes('no live L/R'));assert.equal(a.engine.hands[0].status,'HOLD');
});
test('port refresh preserves an open selection after index reordering',()=>{
 scan(a,['cu.usbserial-A',port]);assert.equal(c.selected,port);assert(c.opened);assert(a.logs.some(x=>x[0]===3&&x[1]==='set'&&x[2]===2));
});
test('selecting a different port closes and requires explicit Open',()=>{
 c.chooseport(1);assert.equal(c.selected,'cu.usbserial-A');assert(!c.opened);assert.equal(a.engine.hands[0].status,'WAIT');
});
test('momentary control release does not close or scan again',()=>{
 open();const n=a.logs.length;c.connect(0);c.disconnect(0);c.refresh(0);assert.equal(a.logs.length,n);assert(c.opened);
});
test('unplug/removal closes polling, resets partial data and reports disappearance',()=>{
 scan(a,[]);assert(!c.opened);assert(c.lastStatus.includes('disappeared'));assert.equal(a.engine.hands[0].status,'WAIT');
});
test('opening without an available selection fails without touching a port',()=>{
 const n=commands().length;c.connect(1);assert.equal(commands().length,n);assert(c.lastStatus.includes('select available'));
});
test('native open fallback mismatch closes instead of accepting a wrong device',()=>{
 scan();c.chooseport(1);c.connect(1);c.serialinfo('port','cu.Bluetooth-Incoming-Port');assert(!c.opened);assert(c.lastStatus.includes('open failed'));
});
test('native getport names, /dev paths and documented alphabetic shortcuts match',()=>{
 assert(c.samePort('a',port));assert(c.samePort('/dev/'+port,port));assert(!c.samePort('b',port));
});
test('port acknowledgement and enumeration watchdogs report failures',()=>{
 c.connect(1);time+=2001;c.tick();assert(!c.opened&&c.lastStatus.includes('check timeout'));
 c.refresh();time+=1001;c.tick();assert(c.lastStatus.includes('list unavailable'));assert(!c.refreshing);
});
test('native serial error closes the connection',()=>{
 open();c.serialinfo('error','busy');assert(!c.opened&&c.lastStatus.includes('serial error'));
});
test('switching back to OSC stops USB and enables only OSC input',()=>{
 open();c.mode(0);assert(!c.opened);assert.equal(c.inputMode,0);assert(a.logs.some(x=>x[0]===2&&x[1]===1));const t=c.times[0];send(left);assert.equal(c.times[0],t);
});
test('saved-name recall is closed and two instances remain isolated',()=>{
 const b=rig();b.c.setvalueof(port);scan(b);assert.equal(b.c.getvalueof(),port);assert(!b.c.opened&&b.c.inputMode===0);assert.notStrictEqual(b.c.ports,c.ports);open(b);assert(b.c.opened&&!c.opened);b.c.disconnect(1);assert(!b.c.opened);
});
test('Close and disposal stop polling and release the native port',()=>{
 open();c.disconnect(1);assert(!c.opened);c.notifydeleted();assert.equal(commands().slice(-1)[0][0],'close');
});
test('native live.text button bangs open, refresh and close without numeric toggles',()=>{
 const b=rig();b.c.refresh('bang');b.c.serialinfo('port',port);b.c.chooseport(1);b.c.connect('bang');b.c.serialinfo('port',port);assert(b.c.opened);b.c.disconnect('bang');assert(!b.c.opened);
});
test('firmware diagnostics distinguish USB bytes from valid hand frames without making data',()=>{
 const b=rig();open(b);send('\n#STATUS,USB2,L,123,0,R,456,8;\n',b);b.c.status(true);
 assert(b.c.lastStatus.includes('board OK'));assert(b.c.lastStatus.includes('L 123 / R 456'));assert.equal(b.c.times[0],0);assert.equal(b.c.times[1],0);assert(!b.engine.hands[0].ready&&!b.engine.hands[1].ready);
 send('#STATUS,USB2,L,NaN,9,R,123,9;\n',b);assert.equal(b.c.boardStatus[0],123);
 time+=2001;b.c.status(true);assert(b.c.lastStatus.includes('status stale'));
 b.c.disconnect(1);assert.equal(b.c.rxBytes,0);assert.equal(b.c.boardStatus,null);
});
console.log(`${count} USB controller/integration checks passed; no Max or physical port test.`);
