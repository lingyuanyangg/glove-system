const N=require('./neural_core.js'),fs=require('fs'),path=require('path'),assert=require('assert');
const checks=[];function test(name,fn){fn();checks.push({name,pass:true});}
const legacy=JSON.parse(fs.readFileSync(path.join(__dirname,'../Glove_Neural_Scope/gloveRegressor10.json')));
test('Original model imports all layers and ten paired examples',()=>{const b=N.legacy(legacy,5,10);assert.equal(b.samples.length,10);assert.deepEqual(b.model.layers.map(l=>[l.rows,l.cols,l.activation]),[[5,3,3],[3,3,3],[3,10,0]]);});
test('Original neural output agrees with independently accumulated tanh/linear layers',()=>{
 const b=N.legacy(legacy,5,10);for(const s of b.samples){let a=s.x;for(const l of b.model.layers)a=l.biases.map((bias,j)=>{const z=bias+a.reduce((v,x,i)=>v+x*l.weights[i][j],0);return l.activation===3?Math.tanh(z):z;});const y=N.predict(b.model,s.x);a.forEach((v,j)=>assert(Math.abs(Math.max(0,Math.min(1,v))-y[j])<1e-12));}
});
test('Five-input legacy model cannot silently receive ten inputs or different outputs',()=>{assert.throws(()=>N.legacy(legacy,10,10),/requires/);assert.throws(()=>N.legacy(legacy,5,11),/requires/);});
test('Input validation rejects incomplete, string and non-finite values and clips range',()=>{assert.throws(()=>N.vector([0,0],5));assert.throws(()=>N.vector([0,0,'0',0,0],5));assert.throws(()=>N.vector([0,0,NaN,0,0],5));assert.deepEqual(N.vector([-1,0,.5,1,2],5),[0,0,.5,1,1]);});
test('Invalid weight dimensions and unsupported activations are rejected',()=>{const b=N.legacy(legacy,5,10);b.model.layers[0].weights[0].pop();assert.throws(()=>N.validate(b.model,5,10));const c=N.legacy(legacy,5,10);c.model.layers[0].activation=9;assert.throws(()=>N.validate(c.model,5,10));});
test('Adam backprop learns the supplied ten-example regression dataset',()=>{
 const b=N.legacy(legacy,5,10),t=new N.Trainer(b.samples,5,10,800);while(!t.advance()){}assert(t.loss<.035,'RMSE '+t.loss);N.validate(t.model,5,10);assert(Number.isFinite(t.loss));checks.push({name:'Original data training RMSE',value:t.loss,pass:true});
});
test('Ten-input model learns a nonlinear two-hand mapping',()=>{
 const r=()=>{},samples=[];for(let i=0;i<30;i++){const x=Array.from({length:10},(_,j)=>((i*13+j*17)%101)/100);samples.push({x,y:[x[0]*x[5],.5+.35*Math.sin(x[1]*2-x[8])]});}
 const t=new N.Trainer(samples,10,2,800);while(!t.advance()){}assert(t.loss<.025,'RMSE '+t.loss);N.validate(t.model,10,2);checks.push({name:'Two-hand data training RMSE',value:t.loss,pass:true});
});
test('Training needs two examples; serialized weights predict identically',()=>{assert.throws(()=>new N.Trainer([{x:[0,0,0,0,0],y:[0]}],5,1,800));const m=N.legacy(legacy,5,10).model,x=[.1,.2,.3,.4,.5];assert.deepEqual(N.predict(m,x),N.predict(JSON.parse(JSON.stringify(m)),x));});
fs.mkdirSync(path.join(__dirname,'../validation'),{recursive:true});fs.writeFileSync(path.join(__dirname,'../validation/neural.json'),JSON.stringify({kind:'Executed shipped pure ES5 neural core in Node',checks},null,2));console.log(checks.length+' neural checks passed');
