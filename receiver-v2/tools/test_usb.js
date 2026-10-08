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
 send(left);assert.equal(c.times[0],0);c.serialinfo('port',port);assert(!c.awaitingCheck&&!c.portFault);assert(commands().some(x=>x[0]==='poll'&&x[1]===2));
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
test('a buffered burst forwards only the latest valid frame per hand',()=>{
 const b=rig();open(b);send('\n',b);b.logs.length=0;
 let burst='';for(let i=0;i<20;i++)burst+=`L,${i},99,99,99,125;\nR,${180-i},99,99,99,125;\n`;
 send(burst,b);
 const raw=b.logs.filter(x=>x[0]===1&&(x[1]==='rawleft'||x[1]==='rawright'));
 assert.equal(raw.length,2);assert.equal(raw.find(x=>x[1]==='rawleft')[2],19);assert.equal(raw.find(x=>x[1]==='rawright')[2],161);
});
test('a Right fault cancels an earlier Right frame in the same burst',()=>{
 const b=rig();open(b);send('\n'+right+'#ERROR,RIGHT_SERIAL_INIT;\n'+left,b);
 assert(!b.engine.hands[1].ready);assert.equal(b.engine.hands[1].status,'HOLD');assert(b.engine.hands[0].ready);
 send(right,b);assert(b.engine.hands[1].ready&&!b.c.boardFault);
});
// Walk the shipped native input graph using the documented object message rules.
// This models Max scheduling and grouping semantics, not the actual Max host.
function transport(r){
 const patch=JSON.parse(fs.readFileSync(path.join(root,'Glove_Receiver_Dual.maxpat'))).patcher;
 const boxes=new Map(patch.boxes.map(o=>[o.box.id,o.box])),deferred=[];
 let group=[],size=1,calls=0;
 function output(id,out,a){
  for(const link of patch.lines.map(x=>x.patchline).filter(x=>x.source[0]===id&&x.source[1]===out))
   receive(link.destination[0],link.destination[1],a);
 }
 function receive(id,inlet,a){
  if(id==='usb_controller'){
   calls++;if(a[0]==='serialinfo')r.c.serialinfo(...a.slice(1));else if(a.length===1)r.c.msg_int(a[0]);else r.c.list(...a);return;
  }
  const box=boxes.get(id);assert(box,'missing native transport object '+id);
  const text=box.text;
  if(text==='route read'){output(id,a[0]==='read'?0:1,a[0]==='read'?a.slice(1):a);}
  else if(text==='t i b'){output(id,1,['bang']);output(id,0,[a[0]]);}
  else if(text==='zlclear'){output(id,0,['zlclear']);}
  else if(text==='max 1'){output(id,0,[Math.max(1,a[0])]);}
  else if(text==='zl group 1 @zlmaxsize 2048'){
   if(inlet===1){size=a[0];assert(size<=2048);}
   else if(a[0]==='zlclear')group=[];
   else {group.push(...a);while(group.length>=size)output(id,0,group.splice(0,size));}
  }
  else if(text==='prepend serialinfo')output(id,0,['serialinfo',...a]);
  else if(text==='deferlow')deferred.push(()=>output(id,0,a));
  else throw Error('unsupported native transport object '+text);
 }
 return {
  read(bytes){output('serial',1,['read',bytes.length]);for(const v of bytes)output('serial',0,[v]);},
  info(...a){output('serial',1,a);},
  drain(){while(deferred.length)deferred.shift()();},
  get calls(){return calls;},get pending(){return deferred.length;}
 };
}
test('native graph groups each exact read without waiting for another USB poll',()=>{
 const b=rig();open(b);const t=transport(b);const bytes=Buffer.from('\n'+left+right);
 t.read(bytes);assert.equal(t.pending,1);assert(!b.engine.hands[0].ready);t.drain();
 assert.equal(t.calls,1);assert(b.engine.hands[0].ready&&b.engine.hands[1].ready);
 t.read(Buffer.from('L,90,'));t.drain();const before=b.c.times[0];time+=5;
 t.read(Buffer.from('99,99,99,125;\n'));t.drain();assert(b.c.times[0]>before);
});
test('zero-byte polls never enter JavaScript and deferred batches keep FIFO order',()=>{
 const b=rig();open(b);const t=transport(b);for(let i=0;i<1000;i++)t.read([]);assert.equal(t.calls,0);assert.equal(t.pending,0);
 t.read(Buffer.from('\nL,10,99,99,99,125;\n'));t.read(Buffer.from('L,170,99,99,99,125;\n'));
 assert.equal(t.pending,2);t.drain();assert.equal(b.engine.hands[0].target[0],170/180);
});
test('native port acknowledgements arrive before FIFO data and Close rejects queued bytes',()=>{
 const b=rig();scan(b);b.c.chooseport(1);b.c.connect(1);const t=transport(b);
 t.info('port',port);t.read(Buffer.from('\n'+left));t.drain();assert(b.engine.hands[0].ready&&!b.c.awaitingCheck);
 t.read(Buffer.from(right));b.c.disconnect(1);t.drain();assert(!b.engine.hands[1].ready&&!b.c.opened);
});
test('USB3 UART bad-frame and queue diagnostics coexist with live hands, without refreshing buses',()=>{
 const r=rig();open(r);send('\n'+right,r);sync(r);
 const before=r.c.times.slice(),received=r.engine.hands[1].received;
 r.engineOutputs.length=0;time+=200;
 send('#STATUS,USB3,L,400,10,0,56,R,800,15,3,992;\n',r);r.c.status(true);
 assert.deepEqual(Array.from(r.c.boardStatus),[400,10,800,15]);assert.deepEqual(Array.from(r.c.boardLink),[0,56,3,992]);
 assert(r.c.lastStatus.includes('UART bad 0 / 3')&&r.c.lastStatus.includes('queue peak 56 / 992'));
 assert.deepEqual(Array.from(r.c.times),Array.from(before));assert.equal(r.engine.hands[1].received,received);
 r.engine.tick();assert(!r.engineOutputs.some(v=>v[0]===3||v[0]===4));
 const validAt=r.c.boardStatusAt;send('#STATUS,USB3,L,400,10,no,56,R,800,15,3,992;\n',r);assert.equal(r.c.boardStatusAt,validAt);
 send('#STATUS,USB2,L,401,11,R,801,16;\n',r);assert.equal(r.c.boardLink,null);assert.deepEqual(Array.from(r.c.boardStatus),[401,11,801,16]);
});
test('right USB raw thumb keeps its scale into inspection, independently of normalization and Left',()=>{
 const r=rig();open(r);r.engine.enabled(0);send('\n'+left+'R,90,99,99,99,103;\n',r);sync(r);r.engine.calreport();
 assert.equal(r.engine.hands[1].target[4],.3);assert.equal(r.engine.hands[0].target[4],.5);
 assert(r.engineOutputs.some(v=>v[0]===2&&v[1]==='caldata'&&v[2]===1&&v[3]==='input4'&&v[4]==='103.0'));
});
test('input labels follow Swap L/R while serial frame tags and diagnostics retain physical slots',()=>{
 const r=rig();r.c.routeswap(1);assert(r.logs.some(v=>v[0]===5&&v[2].includes('6000')));
 assert(r.logs.some(v=>v[0]===6&&v[2].includes('7000')));open(r);r.c.routeswap(1);
 assert(r.logs.some(v=>v[0]===5&&v[2].includes('input R')));assert(r.logs.some(v=>v[0]===6&&v[2].includes('input L')));
 r.engine.enabled(0);r.engine.swaphands(1);send('\n'+left+right,r);sync(r);
 assert.equal(r.engine.hands[0].value[0],1);assert.equal(r.engine.hands[1].value[0],.5);
 send('#ERROR,RIGHT_SERIAL_INIT;\n',r);assert.equal(r.engine.hands[0].status,'HOLD');assert.equal(r.engine.hands[1].status,'LIVE');
});
console.log(`${count} USB controller/integration checks passed including native input graph, routing and raw diagnostics regressions.`);
