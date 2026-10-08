// Exercise the actual shipped ES5 engine with Max API and clock stubs.
const vm=require('vm'), fs=require('fs'), path=require('path'), assert=require('assert');
const root=path.resolve(__dirname,'..');
let now=10000, outputs=[];
const context={Date:{now:()=>now},isFinite,Math,
    arrayfromargs:a=>Array.prototype.slice.call(a),
    outlet:(i,...args)=>outputs.push([i,...args]),
    Task:function(){this.cancel=()=>{};this.repeat=()=>{};}};
vm.createContext(context);vm.runInContext(fs.readFileSync(path.join(root,'glove_dual_engine.js'),'utf8'),context);
const c=context;
function latest(h){return outputs.filter(a=>a[0]===h).slice(-1)[0]?.[1];}
function close(a,b,tol=1e-8){assert(Math.abs(a-b)<tol,`${a} != ${b}`);}
let count=0;
function test(name,fn){fn();count++;console.log('PASS '+name);}
function reset(){outputs=[];c.reset();c.start();c.enabled(1);c.smooth(30);c.deadband(.003);}
test('legacy raw calibration, first frame immediate and five values',()=>{
 reset();c.rawleft(90,99,99,99,125);assert.equal(latest(0).length,5);latest(0).forEach(x=>close(x,.5));
});
test('right hand independent; clipping and normalized input',()=>{
 c.normright(-1,.2,.4,.6,2);assert.deepEqual(Array.from(latest(1)),[0,.2,.4,.6,1]);
 latest(0).forEach(x=>close(x,.5));
});
test('malformed packets do not change targets or refresh connection status',()=>{
 const before=c.hands[0].received;now+=12;
 c.rawleft(100,100);c.normleft(0,0,NaN,0,0);c.normleft(0,0,'0.2',0,0);c.normleft(0,0,Infinity,0,0);
 assert.equal(c.hands[0].received,before);c.hands[0].target.forEach(x=>close(x,.5));
 assert.equal(outputs.filter(a=>a[1]==='invalid').length,4);
});
test('deadband rejects tiny alternating jitter around accepted target',()=>{
 reset();c.normleft(.5,.5,.5,.5,.5);const emitted=outputs.filter(x=>x[0]===0).length;
 for(let i=0;i<100;i++){now+=10;c.normleft(.5+(i%2?.002:-.002),.5,.5,.5,.5);c.tick();}
 assert.equal(outputs.filter(x=>x[0]===0).length,emitted);
});
test('smooth step is monotone; time constant independent of scheduler interval',()=>{
 reset();c.normleft(0,0,0,0,0);c.normleft(1,1,1,1,1);now+=30;c.tick();
 close(latest(0)[0],1-Math.exp(-1));
 let previous=latest(0)[0];for(let i=0;i<30;i++){now+=10;c.tick();assert(latest(0)[0]>=previous);previous=latest(0)[0];}
 assert(previous>.9999);
 reset();c.normleft(0,0,0,0,0);c.normleft(1,1,1,1,1);for(let i=0;i<3;i++){now+=10;c.tick();}
 close(latest(0)[0],1-Math.exp(-1));
});
test('held target still converges; exact endpoint and no constant packet chatter',()=>{
 now+=500;c.tick();assert.equal(latest(0)[0],1);const emitted=outputs.length;
 for(let i=0;i<40;i++){now+=10;c.tick();}assert.equal(outputs.length,emitted);
});
test('stale hand holds last value, live packet restores status',()=>{
 const before=latest(0);now+=1200;c.tick();assert.equal(c.hands[0].status,'HOLD');assert.strictEqual(latest(0),before);
 c.normleft(1,1,1,1,1);assert.equal(c.hands[0].status,'LIVE');
});
test('bypass disables both filters and zero time bypasses only smoothing',()=>{
 reset();c.normleft(.5,.5,.5,.5,.5);c.enabled(0);c.normleft(.501,.501,.501,.501,.501);close(latest(0)[0],.501);
 c.enabled(1);c.smooth(0);c.normleft(.7,.7,.7,.7,.7);close(latest(0)[0],.7);
 c.normleft(.701,.701,.701,.701,.701);close(latest(0)[0],.7);
});
test('manual tests clamp values and update only selected channel',()=>{
 reset();c.smooth(0);c.manualright(4,2);assert.deepEqual(Array.from(latest(1)),[0,0,0,0,1]);assert.equal(c.hands[1].status,'TEST');
 c.manualright(9,.5);assert.deepEqual(Array.from(latest(1)),[0,0,0,0,1]);
});
test('flush repeats current frame without modifying it',()=>{
 const before=Array.from(latest(1));c.flush();assert.deepEqual(Array.from(latest(1)),before);
});
test('stationary real frames keep learning buses fresh without UI/OSC chatter',()=>{
 reset();c.normleft(.5,.5,.5,.5,.5);c.normright(.5,.5,.5,.5,.5);now+=10;c.tick();
 const monitors=outputs.filter(x=>x[0]<2).length;outputs=[];
 for(let i=0;i<100;i++){now+=20;c.normleft(.5,.5,.5,.5,.5);c.normright(.5,.5,.5,.5,.5);c.tick();}
 assert.equal(monitors,2);assert.equal(outputs.filter(x=>x[0]<2).length,0);
 assert.equal(outputs.filter(x=>x[0]===3).length,100);assert.equal(outputs.filter(x=>x[0]===4).length,100);
 outputs.filter(x=>x[0]>=3&&x[0]<5).forEach(x=>assert.deepEqual(Array.from(x[1]),[.5,.5,.5,.5,.5]));
 outputs=[];now+=20;c.tick();c.flush();assert.equal(outputs.filter(x=>x[0]>=3&&x[0]<5).length,0);
});
test('malformed, cancelled and overdue frames never refresh the learning buses',()=>{
 reset();c.normleft(.5,.5,.5,.5,.5);now+=101;c.tick();assert.equal(outputs.filter(x=>x[0]===3).length,0);
 outputs=[];c.normright(.5,.5,.5,.5,.5);c.lostright();now+=10;c.tick();assert.equal(outputs.filter(x=>x[0]===4).length,0);assert.equal(c.hands[1].status,'HOLD');
 c.normleft(.5,.5,NaN,.5,.5);now+=10;c.tick();assert.equal(outputs.filter(x=>x[0]===3).length,0);
});
test('optimized default reaches 95 percent within 25ms of a step',()=>{
 const oldNow=now;now=30000;outputs=[];
 const fast={...context,Task:function(){this.cancel=()=>{};this.repeat=()=>{};}};
 vm.createContext(fast);vm.runInContext(fs.readFileSync(path.join(root,'glove_dual_engine.js'),'utf8'),fast);
 assert.equal(fast.runner.interval,5);assert.equal(fast.tau,8);fast.start();
 fast.normleft(0,0,0,0,0);fast.normleft(1,1,1,1,1);
 let reached=0;for(let t=5;t<=30;t+=5){now=30000+t;fast.tick();if(!reached&&fast.hands[0].value[0]>=.95)reached=t;}
 assert.equal(reached,25);assert(fast.hands[0].value[0]>.97);now=oldNow;
});
test('drawing throttle never delays live mapping or the fresh learning bus',()=>{
 reset();c.smooth(0);c.normleft(0,0,0,0,0);outputs=[];
 now+=1;c.normleft(1,1,1,1,1);assert.equal(latest(0)[0],1);assert(!outputs.some(x=>x[0]===5));
 now+=5;c.tick();assert(outputs.some(x=>x[0]===3&&x[1][0]===1));assert(!outputs.some(x=>x[0]===5));
 now+=33;c.tick();assert(outputs.some(x=>x[0]===5&&x[1][0]===1));
});
test('200Hz control input paints only the latest value at about 30Hz',()=>{
 reset();c.smooth(0);c.deadband(0);c.normleft(0,0,0,0,0);outputs=[];
 for(let i=1;i<=500;i++){now+=5;c.normleft(i/500,i/500,i/500,i/500,i/500);c.tick();}
 assert.equal(outputs.filter(x=>x[0]===0).length,500);
 assert(outputs.filter(x=>x[0]===5).length<=Math.ceil(2500/33));
 now+=33;c.tick();assert.equal(outputs.filter(x=>x[0]===5).slice(-1)[0][1][0],1);
});
console.log(`${count} engine checks passed including low-latency control/UI regressions.`);
