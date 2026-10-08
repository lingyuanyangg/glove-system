// Interpret the shipped native p Scale graph, including Max's right-to-left unpack.
// This checks range arithmetic; it cannot exercise Live API or audio scheduling.
const fs=require('fs'),path=require('path'),assert=require('assert');
const root=path.resolve(__dirname,'..');
const patch=JSON.parse(fs.readFileSync(path.join(root,'Glove_Mapper.maxpat'))).patcher;
function model(mapper){
 const p=mapper.boxes.find(o=>o.box.text==='p Scale').box.patcher;
 const boxes=Object.fromEntries(p.boxes.map(o=>[o.box.id,o.box]));
 const edges=p.lines.map(l=>l.patchline),state={};
 for(const b of Object.values(boxes))if(b.maxclass==='newobj'){
  const [op,...args]=b.text.split(' ');state[b.id]={op,args:args.map(Number)};
  assert(['unpack','!-','clip~','/','pak','scale','+~','*~'].includes(op),b.text);
 }
 function send(id,value){for(const l of edges.filter(l=>l.source[0]===id&&l.source[1]===0).sort((a,b)=>(a.order||0)-(b.order||0)))input(l.destination[0],l.destination[1],value);}
 function emit(id,out,value){for(const l of edges.filter(l=>l.source[0]===id&&l.source[1]===out).sort((a,b)=>(a.order||0)-(b.order||0)))input(l.destination[0],l.destination[1],value);}
 function input(id,i,value){
  const b=boxes[id],s=state[id];if(b.maxclass==='inlet'){send(id,value);return;}
  if(b.maxclass==='outlet')return;
  if(s.op==='unpack'){for(let k=value.length-1;k>=0;k--)emit(id,k,value[k]);return;}
  if(s.op==='pak'){s.args[i]=value;send(id,s.args.slice());return;}
  if(s.op==='/'){assert.equal(i,0);send(id,value/s.args[0]);return;}
  if(s.op==='scale'){
   if(i>0){s.args[i-1]=value;return;}
   const [a,z,lo,hi]=s.args;send(id,lo+(value-a)/(z-a)*(hi-lo));return;
  }
  if(s.op==='!-'){if(i===1)s.args[0]=value;else send(id,s.args[0]-value);return;}
  if(['+~','*~'].includes(s.op)){assert.equal(i,1);s.args[0]=value;return;}
  throw Error('Unexpected control input '+id+' '+i);
 }
 const inlet=n=>Object.values(boxes).find(b=>b.maxclass==='inlet'&&b.index===n).id;
 function signal(id,value){const b=boxes[id];if(b.maxclass==='inlet')return value;
  const source=edges.find(l=>l.destination[0]===id&&l.destination[1]===0).source[0],v=signal(source,value);
  if(b.maxclass==='outlet')return v;const s=state[id];
  if(s.op==='clip~')return Math.max(s.args[0],Math.min(s.args[1],v));
  if(s.op==='*~')return v*s.args[0];if(s.op==='+~')return v+s.args[0];throw Error(id);
 }
 return {set:(min,max,range)=>{input(inlet(4),0,range);input(inlet(2),0,min);input(inlet(3),0,max);},
  value:v=>signal(Object.values(boxes).find(b=>b.maxclass==='outlet').id,v)};
}
let checks=0;
for(const hand of ['left','right'])for(const finger of ['pinky','ring','middle','index','thumb']){
 const name=hand+'_'+finger,m=patch.boxes.find(o=>o.box.id===name+'_map').box.patcher,scale=model(m);
 const near=(a,b)=>assert(Math.abs(a-b)<1e-8,`${name}: ${a} != ${b}`);
 scale.set(0,100,[-70,6]);near(scale.value(0),-70);near(scale.value(1),6);
 scale.set(20,80,[0,1]);near(scale.value(0),.2);near(scale.value(.9),.74);near(scale.value(1),.8);
 scale.set(80,20,[20,20000]);near(scale.value(0),16004);near(scale.value(.9),5214.8);near(scale.value(1),4016);
 near(scale.value(-1),16004);near(scale.value(2),4016);
 scale.set(50,50,[-70,6]);near(scale.value(0),-32);near(scale.value(1),-32);
 scale.set(20,80,[-70,6]);near(scale.value(.9),-13.76);
 checks++;console.log('PASS '+name+' native Min/Max, fist/headroom, inversion, clipping and target-range change');
}
console.log(`${checks} native mapping graph checks passed.`);
