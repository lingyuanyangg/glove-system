// Execute shipped controller; prove UI throttling cannot hold back mapping values.
const fs=require('fs'),path=require('path'),vm=require('vm'),assert=require('assert');
let now=1000,logs=[],tasks=[];
function Clock(){return {getTime:()=>now};}
const c={Date:Clock,isFinite,Task:function(fn,self){this.interval=0;this.repeat=()=>tasks.push(this);this.cancel=()=>this.cancelled=true;this.run=()=>fn.call(self);},
 arrayfromargs:a=>Array.from(a),outlet:(...a)=>logs.push(JSON.parse(JSON.stringify(a)))};
vm.createContext(c);vm.runInContext(fs.readFileSync(path.resolve(__dirname,'../glove_mapper.js'),'utf8'),c);
c.start();assert.equal(tasks[0].interval,33);logs=[];
c.left(0,.2,.4,.6,.9);c.right(.9,.6,.4,.2,0);
assert.deepEqual(logs.map(a=>a[0]),[0,1]); // Signals change before any UI tick.
for(let i=0;i<20;i++){now++;c.leftcontrol(i/20,.2,.4,.6,.9);}
assert.equal(logs.filter(a=>a[0]===2).length,0);
c.tick();assert.deepEqual(logs.find(a=>a[0]===2)[1],[.95,.2,.4,.6,.9]);
assert.deepEqual(logs.filter(a=>a[0]===4).map(a=>a.slice(1)),[['status',0,'LIVE'],['status',1,'LIVE']]);
logs=[];now+=33;c.tick();assert.equal(logs.length,0); // Idle UI does not repaint.
for(const bad of [[1,2,3],[0,0,0,0,NaN],[0,0,0,0,Infinity],[0,0,0,0,1.1],[0,0,0,0,'1']])c.right(...bad);
assert.equal(logs.length,0);
// Continuous control is not a freshness heartbeat; HOLD retains the last signal.
now+=1100;c.leftcontrol(.8,.2,.4,.6,.9);c.tick();
assert.equal(logs.filter(a=>a[0]===4&&a[3]==='HOLD').length,2);
logs=[];c.left(.8,.2,.4,.6,.9);c.tick();
assert.deepEqual(logs,[[4,'status',0,'LIVE']]); // Same stationary pose restores freshness without signal chatter.
c.notifydeleted();assert(tasks[0].cancelled);
console.log('PASS immediate dual-hand signals, latest-only monitors, idle drawing, invalid input, stationary freshness, HOLD, disposal.');
