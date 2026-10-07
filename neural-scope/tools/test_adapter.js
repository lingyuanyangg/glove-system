const fs=require('fs'),vm=require('vm'),path=require('path'),assert=require('assert');
const checks=[];
function fixture(){
 const db={
  1:{type:'Track',name:'Main',devices:[10,20,30],view:3},2:{type:'Song.View',selected_track:1},3:{type:'Track.View',selected_device:20},
  10:{type:'Device',name:'Glove Neural Scope',canonical_parent:1,parameters:[],can_have_chains:0},
  20:{type:'Device',name:'Filter',canonical_parent:1,parameters:[21,22],can_have_chains:0},
  21:{type:'DeviceParameter',name:'Device On',min:0,max:1,value:1,is_quantized:1,is_enabled:1},
  22:{type:'DeviceParameter',name:'Frequency',min:20,max:20000,value:1000,is_quantized:0,is_enabled:1},
  30:{type:'Device',name:'Rack',canonical_parent:1,parameters:[31],can_have_chains:1,chains:[40]},
  31:{type:'DeviceParameter',name:'Device On',min:0,max:1,value:1,is_quantized:1,is_enabled:1},
  40:{type:'Chain',name:'Chain A',canonical_parent:30,devices:[50]},
  50:{type:'Device',name:'Synth',canonical_parent:40,parameters:[51,52],can_have_chains:0},
  51:{type:'DeviceParameter',name:'Device On',min:0,max:1,value:1,is_quantized:1,is_enabled:1},
  52:{type:'DeviceParameter',name:'Mode',min:0,max:3,value:2,is_quantized:1,is_enabled:1},
  100:{type:'Track',name:'Other',devices:[110],view:103},103:{type:'Track.View',selected_device:110},
  110:{type:'Device',name:'Other FX',canonical_parent:100,parameters:[111,112],can_have_chains:0},
  111:{type:'DeviceParameter',name:'Device On',min:0,max:1,value:1,is_quantized:1,is_enabled:1},
  112:{type:'DeviceParameter',name:'Gain',min:0,max:1,value:.3,is_quantized:0,is_enabled:1}
 };
 const out=[],tasks=[],channels={},calls={construct:0};
 function LiveAPI(cb,p){calls.construct++;this.id=p==='this_device'?10:p==='live_set view'?2:Number(p.split(' ')[1]);this.type=(db[this.id]||{}).type;this.unquotedpath=this.id===1?'live_set tracks 0':this.id===100?'live_set tracks 1':'id '+this.id;}
 LiveAPI.prototype.get=function(prop){const d=db[this.id];if(!d||!(prop in d))throw Error('Unknown '+prop);const x=d[prop];return Array.isArray(x)?x.flatMap(id=>['id',id]):['canonical_parent','view','selected_device','selected_track'].includes(prop)?['id',x]:[x];};
 LiveAPI.prototype.set=function(prop,v){if(!db[this.id].is_enabled)throw Error('Disabled');db[this.id][prop]=v;};
 LiveAPI.prototype.call=function(fn,v){assert.equal(fn,'str_for_value');return[String(v)+' units'];};
 function Task(fn){this.fn=fn;this.repeat=()=>tasks.push(this);this.cancel=()=>{this.cancelled=true;};}
 const remotePatch={getnamed:name=>{const n=name.split('-')[1],channel=channels[n]||(channels[n]={id:0,value:0,smoothing:0});return {message:(op,v)=>{
  if(name.startsWith('sender')){if(channel.id&&db[channel.id])db[channel.id].is_enabled=1;channel.id=v;if(v){if(!db[v]||!db[v].is_enabled)throw Error('Unavailable remote');db[v].is_enabled=0;}}
  else if(op==='float')channel.value=v;else if(op==='smoothing')channel.smoothing=v;
 }};}};
 const files={},fileCalls=[];
 function File(filename,access){this.path=filename;this.content=access==='read'?(files[filename]||''):'';this.isopen=access==='write'||Object.prototype.hasOwnProperty.call(files,filename);this.position=0;this.eof=this.content.length;fileCalls.push(this);this.readstring=n=>{const part=this.content.slice(this.position,this.position+n);this.position+=part.length;return part;};this.writestring=part=>{this.content+=part;this.position+=part.length;};this.close=()=>{if(access==='write')files[filename]=this.content;this.isopen=false;};}
 const c={LiveAPI,Task,File,outlet:(...a)=>out.push(a),arrayfromargs:a=>Array.from(a),patcher:{filepath:'/portable/Glove Neural Scope.amxd',getnamed:()=>({subpatcher:()=>remotePatch})},module:undefined};
 vm.createContext(c);vm.runInContext(fs.readFileSync(path.join(__dirname,'../Glove_Neural_Scope/neural_scope_control.js'),'utf8'),c);
 const get=LiveAPI.prototype.get;LiveAPI.prototype.get=function(prop){return vm.runInContext('('+JSON.stringify(get.call(this,prop))+')',c);};
 const send=m=>c.command(encodeURIComponent(JSON.stringify({device:c.selected,revision:c.revision,...m})));
 const state=()=>{const packets=out.filter(a=>a[1]==='statepacket'),seq=packets.at(-1)[2];return JSON.parse(decodeURIComponent(packets.filter(a=>a[2]===seq).sort((a,b)=>a[3]-b[3]).map(a=>a[5]).join('')));};
 c.loadbang();send({op:'hello'});c.bang();return{c,db,out,tasks,channels,calls,files,fileCalls,send,state};
}
function test(name,fn){fn();checks.push({name,pass:true});}
function twoExamples(f,mode='left'){
 f.send({op:'mode',value:mode});const set=v=>{f.c.left(v,v,v,v,v);f.c.right(v,v,v,v,v);};
 set(0);f.db[22].value=20;f.send({op:'capture'});set(1);f.db[22].value=20000;f.send({op:'capture'});f.send({op:'train'});let guard=0;while(f.c.trainer&&guard++<10000)f.c.trainChunk();assert(!f.c.trainer);assert(f.state().trained);
}
test('Portable UI load, track discovery, self exclusion and selected-device follow',()=>{const f=fixture();assert.equal(f.out[0][2],'/portable/neural_scope_ui.html');assert(f.state().ready);assert.equal(f.state().selected,'20');assert.deepEqual(f.state().devices.map(d=>d.name),['Filter','Rack','Rack / Chain A / Synth']);assert.equal(f.state().rows[0].scope,false);});
test('Left/Right/Both route 5/5/10 dimensions in original finger order',()=>{const f=fixture();f.c.left(.1,.2,.3,.4,.5);f.c.right(.6,.7,.8,.9,1);assert.deepEqual(Array.from(f.c.input()),[.1,.2,.3,.4,.5]);f.send({op:'mode',value:'right'});assert.deepEqual(Array.from(f.c.input()),[.6,.7,.8,.9,1]);f.send({op:'mode',value:'both'});assert.deepEqual(Array.from(f.c.input()),[.1,.2,.3,.4,.5,.6,.7,.8,.9,1]);});
test('Both mode waits for both hands and rejects malformed replacement frames',()=>{const f=fixture();f.send({op:'mode',value:'both'});f.c.left(.2,.2,.2,.2,.2);f.send({op:'capture'});assert.equal(f.state().samples,0);assert.match(f.state().note,/Both mode/);f.c.right(.3,.3,.3,.3,.3);f.c.right(0,0,NaN,0,0);assert.deepEqual(Array.from(f.c.input()).slice(5),[.3,.3,.3,.3,.3]);});
test('Capture normalizes real Live ranges and ignores custom clamp scaling',()=>{const f=fixture();f.c.left(.3,.3,.3,.3,.3);f.send({op:'edit',id:'22',field:'min',value:200});f.db[22].value=10010;f.send({op:'capture'});assert.equal(f.c.bank().samples[0].y[0],.5);assert.equal(f.c.bank().samples[0].x[0],.3);f.send({op:'capture'});assert.equal(f.state().samples,1);assert.match(f.state().note,/already captured/);});
test('Actual adapter training completes; Run drives native units and Stop releases',()=>{const f=fixture();twoExamples(f);f.c.left(1,1,1,1,1);f.send({op:'run'});assert(f.state().running);assert.equal(f.db[22].is_enabled,0);assert(f.channels[0].value>19000);assert.equal(f.channels[0].smoothing,30);f.send({op:'stop'});assert.equal(f.db[22].is_enabled,1);assert.equal(f.state().running,false);});
test('Output clamps and quantized targets respect chosen valid bounds',()=>{const f=fixture();twoExamples(f);f.send({op:'edit',id:'22',field:'max',value:5000});f.send({op:'run'});assert.equal(f.channels[0].value,5000);f.send({op:'stop'});f.send({op:'select',id:'50'});f.send({op:'edit',id:'52',field:'min',value:.2});f.send({op:'edit',id:'52',field:'max',value:.8});assert.match(f.state().note,/valid discrete/);assert.equal(f.state().rows[1].max,3);});
test('Input modes retain separate training banks, and switching mode releases mappings',()=>{const f=fixture();twoExamples(f);f.send({op:'run'});f.send({op:'mode',value:'right'});assert.equal(f.db[22].is_enabled,1);assert.equal(f.state().samples,0);assert(!f.state().trained);f.send({op:'mode',value:'left'});assert.equal(f.state().samples,2);assert(f.state().trained);assert(!f.state().running);});
test('Changing scope keeps the previous model bank and prevents stale row events',()=>{const f=fixture();twoExamples(f);const old=f.c.revision;f.send({op:'scopeAll',value:'none'});assert.equal(f.state().outputs,0);assert.equal(f.state().samples,0);f.send({op:'capture',revision:old});assert.match(f.state().note,/changed/);f.send({op:'scope',id:'22',value:true});assert.equal(f.state().samples,2);assert(f.state().trained);});
test('Following a new device stops control; clicking the utility itself retains the target',()=>{const f=fixture();twoExamples(f);f.send({op:'run'});f.db[3].selected_device=50;f.c.tick();assert.equal(f.state().selected,'50');assert(!f.state().running);assert.equal(f.db[22].is_enabled,1);f.db[3].selected_device=10;f.c.tick();assert.equal(f.state().selected,'50');});
test('Manual target selection pins a same-track device and rejects another track',()=>{const f=fixture();f.send({op:'select',id:'50'});assert(!f.state().follow);f.db[3].selected_device=20;f.c.tick();assert.equal(f.state().selected,'50');f.send({op:'select',id:'110'});assert.equal(f.state().selected,'50');assert.match(f.state().note,/chosen track/);});
test('Selected track context follows current Live track and reuses cached API objects',()=>{const f=fixture();f.send({op:'trackMode',value:'selected'});f.db[2].selected_track=100;f.c.tick();assert.equal(f.state().selected,'110');assert.equal(f.state().trackName,'Other');f.c.left(.5,.5,.5,.5,.5);const before=f.calls.construct;for(let i=0;i<100;i++)f.c.contextTrack();assert.equal(f.calls.construct,before);});
test('Deleted or moved targets release all remotes before another prediction',()=>{const f=fixture();twoExamples(f);f.send({op:'run'});f.db[20].canonical_parent=100;f.c.left(.7,.7,.7,.7,.7);f.c.perform();assert(!f.state().running||!f.c.running);assert.equal(f.db[22].is_enabled,1);});
test('Deleted device is rejected by commands; changed parameter list refreshes safely',()=>{const f=fixture();f.db[1].devices=[10,30];f.c.left(.2,.2,.2,.2,.2);f.send({op:'capture'});assert.equal(f.state().selected,null);const g=fixture();g.db[20].parameters=[21];g.send({op:'capture'});assert.equal(g.state().rows.length,1);assert.match(g.state().note,/Parameter list/);});
test('Unavailable parameters cannot be scoped or captured',()=>{const f=fixture();f.db[22].is_enabled=0;f.send({op:'capture'});assert.equal(f.state().samples,0);f.send({op:'scope',id:'22',value:true});assert.match(f.state().note,/elsewhere/);});
test('Failure on a later output releases any earlier remote assignments',()=>{
 const f=fixture();f.db[23]={type:'DeviceParameter',name:'Resonance',min:0,max:1,value:.3,is_quantized:0,is_enabled:1};f.db[20].parameters.push(23);f.c.tick();twoExamples(f);f.db[23].is_enabled=0;f.send({op:'run'});assert(!f.c.running);assert.equal(f.db[22].is_enabled,1);assert.equal(Object.keys(f.c.remotes).length,0);
});
test('Samples and neural weights restore after ID changes, with Run always off',()=>{
 const first=fixture();twoExamples(first,'both');first.send({op:'smooth',value:75});const row=first.out.filter(a=>a[0]===2).at(-1),parts=row[1]==='list'?row.slice(2):[row[1]];
 const second=fixture();for(const id of [20,21,22]){second.db[id+200]=second.db[id];delete second.db[id];}second.db[1].devices=[10,220,30];second.db[3].selected_device=220;second.db[220].parameters=[221,222];second.c.restore(...parts);second.c.tick();assert.equal(second.state().selected,'220');assert.equal(second.state().samples,2);assert(second.state().trained);assert.equal(second.state().mode,'both');assert.equal(second.state().smoothing,75);assert(!second.state().running);
 second.c.left(1,1,1,1,1);second.c.right(1,1,1,1,1);second.send({op:'run'});assert(second.c.running);assert.equal(second.db[222].is_enabled,0);
});
test('Adding an example invalidates the current model; undo and clear affect only that bank',()=>{const f=fixture();twoExamples(f);f.c.left(.5,.5,.5,.5,.5);f.send({op:'capture'});assert(!f.state().trained);assert.equal(f.state().samples,3);f.send({op:'undoSample'});assert.equal(f.state().samples,2);f.send({op:'mode',value:'right'});f.c.right(.2,.2,.2,.2,.2);f.send({op:'capture'});f.send({op:'clear'});assert.equal(f.state().samples,0);f.send({op:'mode',value:'left'});assert.equal(f.state().samples,2);});
test('Deletion cancels scheduled work and releases remote channels',()=>{const f=fixture();twoExamples(f);f.send({op:'run'});f.c.notifydeleted();assert(f.tasks.slice(0,2).every(t=>t.cancelled));assert.equal(f.db[22].is_enabled,1);});
test('Large parameter tables and saved samples use bounded fragments and restore intact',()=>{
 const f=fixture();for(let i=0;i<300;i++){const id=1000+i;f.db[id]={type:'DeviceParameter',name:'参数 '+i+' "long name"',min:0,max:1,value:.3,is_quantized:0,is_enabled:1};f.db[20].parameters.push(id);}f.c.tick();assert.equal(f.state().rows.length,302);assert.equal(f.state().outputs,256);f.c.left(.1,.2,.3,.4,.5);f.send({op:'capture'});const payload=f.out.filter(a=>a[0]===2).at(-1);assert.equal(payload[1],'list');assert(payload.slice(2).every(s=>s.length<=4096));f.c.storedPayload='';f.c.restore(...payload.slice(2));f.c.tick();assert.equal(f.state().rows.length,302);assert.equal(f.state().samples,1);assert.equal(f.c.bank().samples[0].y.length,256);assert(f.out.filter(a=>a[1]==='statepacket').every(a=>a[5].length<=4096));
});
test('Live theme bridge accepts native colors and rejects unknown or malformed messages',()=>{const f=fixture();f.c.theme('live_lcd_bg',.9,.9,.9,1);f.c.theme('live_control_fg',.1,.1,.1,1);f.c.theme('unknown',1,0,0,1);f.c.theme('live_lcd_control_fg',NaN,0,0,1);f.c.emit();assert.deepEqual(f.state().colors,{live_lcd_bg:[.9,.9,.9,1],live_control_fg:[.1,.1,.1,1]});});
test('Named snapshots restore saved scope and bounds and release Run before loading',()=>{
 const f=fixture();twoExamples(f);f.send({op:'edit',id:'22',field:'max',value:5000});f.send({op:'saveModel',name:'Filter pose'});const id=f.state().modelSelection;
 assert.equal(f.state().models.length,1);f.send({op:'edit',id:'22',field:'max',value:20000});f.send({op:'run'});assert(f.c.running);f.send({op:'loadModel',id});assert(!f.c.running);assert.equal(f.db[22].is_enabled,1);assert.equal(f.state().rows[1].max,5000);assert.equal(f.state().samples,2);
 f.send({op:'scopeAll',value:'none'});assert.equal(f.state().outputs,0);assert(f.state().models[0].compatible);f.send({op:'loadModel',id});assert.equal(f.state().outputs,1);assert(f.state().trained);
});
test('Saved models are immutable and duplicate names receive independent identities',()=>{
 const f=fixture();twoExamples(f);f.send({op:'saveModel',name:'Same name'});const id=f.state().modelSelection,weights=JSON.stringify(f.c.modelLibrary[0]);f.c.left(.5,.5,.5,.5,.5);f.send({op:'capture'});assert(!f.state().trained);assert.equal(JSON.stringify(f.c.modelLibrary[0]),weights);f.send({op:'loadModel',id});assert.equal(f.state().samples,2);f.send({op:'saveModel',name:'Same name'});assert.equal(f.state().models.length,2);assert.notEqual(f.state().models[0].id,f.state().models[1].id);f.send({op:'saveModel',name:'   '});assert.equal(f.state().models.length,2);assert.match(f.state().note,/model name/);
});
test('Selector rejects wrong hand and target structure; unavailable outputs do not partially change scope',()=>{
 const f=fixture();twoExamples(f);f.send({op:'saveModel',name:'Left Filter'});const id=f.state().modelSelection;f.send({op:'mode',value:'right'});assert(!f.state().models[0].compatible);f.send({op:'loadModel',id});assert.match(f.state().note,/left input/);assert(!f.state().trained);f.send({op:'mode',value:'left'});f.send({op:'select',id:'50'});assert(!f.state().models[0].compatible);f.send({op:'loadModel',id});assert.match(f.state().note,/structure differs/);f.send({op:'select',id:'20'});f.send({op:'scopeAll',value:'none'});f.db[22].is_enabled=0;f.send({op:'loadModel',id});assert.match(f.state().note,/elsewhere/);assert.equal(f.state().outputs,0);
});
test('Named model library survives Set restore and new runtime parameter IDs',()=>{
 const first=fixture();twoExamples(first,'both');first.send({op:'saveModel',name:'Two hands'});const id=first.state().modelSelection;first.send({op:'scopeAll',value:'none'});const row=first.out.filter(a=>a[0]===2).at(-1),parts=row[1]==='list'?row.slice(2):[row[1]];
 const second=fixture();for(const old of [20,21,22]){second.db[old+200]=second.db[old];delete second.db[old];}second.db[1].devices=[10,220,30];second.db[3].selected_device=220;second.db[220].parameters=[221,222];second.c.restore(...parts);second.c.tick();assert.equal(second.state().models.length,1);assert.equal(second.state().modelSelection,id);assert(second.state().models[0].compatible);second.send({op:'loadModel',id});assert(second.state().trained);assert.equal(second.state().rows[1].id,'222');assert(!second.c.running);
});
test('Export and Import preserve weights, samples, Unicode name, scope and bounds across Sets',()=>{
 const first=fixture();twoExamples(first);first.send({op:'saveModel',name:'手套模型 / Filter'});const id=first.state().modelSelection;first.send({op:'exportModel',id});assert(first.out.some(a=>a[0]===3&&a[1]==='export'&&a[2]==='bang'));first.c.writemodel('/models/my model');const raw=first.files['/models/my model.json'];assert(raw);assert(!/[\u007f-\uffff]/.test(raw));assert(first.fileCalls.at(-1).isopen===false);
 const second=fixture();second.files['/models/my model.json']=raw;second.send({op:'importModel'});second.c.readmodel('/models/my model.json');assert(second.state().trained);assert.equal(second.state().models[0].name,'手套模型 / Filter');assert.equal(second.state().samples,2);assert.notEqual(second.state().modelSelection,id);assert.deepEqual(JSON.parse(JSON.stringify(second.c.bank().model)),JSON.parse(JSON.stringify(first.c.bank().model)));assert(!second.c.running);
});
test('Import stores an incompatible saved model for later selection without replacing the working bank',()=>{
 const f=fixture();twoExamples(f);f.send({op:'saveModel',name:'Left saved'});const raw=JSON.stringify(f.c.modelLibrary[0]);f.send({op:'mode',value:'right'});f.files['/left.json']=raw;f.send({op:'importModel'});f.c.readmodel('/left.json');assert.equal(f.state().models.length,2);assert(!f.state().trained);assert.match(f.state().note,/left input/);f.send({op:'mode',value:'left'});f.send({op:'loadModel',id:f.state().modelSelection});assert(f.state().trained);
});
test('Import rejects malformed models and invalid samples without altering the library',()=>{
 const f=fixture();twoExamples(f);f.send({op:'saveModel',name:'Valid'});const original=JSON.parse(JSON.stringify(f.c.modelLibrary[0]));
 for(const change of [r=>r.bank.model.layers[0].activation=99,r=>r.configs[0].min=-1,r=>r.bank.samples[0].x[0]='NaN',r=>r.bank.samples[0].y[0]=2,r=>r.configs[0].index=-1]){const r=JSON.parse(JSON.stringify(original));change(r);f.files['/invalid.json']=JSON.stringify(r);f.send({op:'importModel'});f.c.readmodel('/invalid.json');assert.equal(f.state().models.length,1);assert.match(f.state().note,/Import failed/);assert(!f.fileCalls.at(-1).isopen);}
 f.files['/invalid.json']='broken';f.send({op:'importModel'});f.c.readmodel('/invalid.json');assert.equal(f.state().models.length,1);
});
test('Dialog cancellation and target changes reject stale file callbacks',()=>{
 const f=fixture();twoExamples(f);f.send({op:'saveModel',name:'Saved'});const id=f.state().modelSelection;f.send({op:'exportModel',id});f.c.dialogcancel('export');assert.equal(f.c.pendingExport,null);f.c.writemodel('/cancelled.json');assert(!f.files['/cancelled.json']);f.send({op:'importModel'});f.c.dialogcancel('import');assert.equal(f.c.pendingImport,null);f.send({op:'importModel'});f.send({op:'mode',value:'right'});f.files['/saved.json']=JSON.stringify(f.c.modelLibrary[0]);f.c.readmodel('/saved.json');assert.match(f.state().note,/changed during/);assert.equal(f.state().models.length,1);
});
test('Deleting a named snapshot leaves the active bank; exporting works without a target',()=>{
 const f=fixture();twoExamples(f);f.send({op:'saveModel',name:'Saved'});const id=f.state().modelSelection;f.db[1].devices=[10];f.c.refresh();f.c.emit();assert.equal(f.state().selected,null);f.send({op:'exportModel',id});assert(f.c.pendingExport);f.c.writemodel('/no-target.json');assert(f.files['/no-target.json']);f.send({op:'deleteModel',id});assert.equal(f.state().models.length,0);assert.equal(f.c.sessions['20'].banks[Object.keys(f.c.sessions['20'].banks)[0]].samples.length,2);
});
test('Version-one Set state migrates without a preset or a model library',()=>{
 const first=fixture();twoExamples(first);const row=first.out.filter(a=>a[0]===2).at(-1),parts=row[1]==='list'?row.slice(2):[row[1]],saved=JSON.parse(decodeURIComponent(parts.join('')));saved.version=1;delete saved.models;delete saved.modelSelection;const second=fixture();second.c.restore(encodeURIComponent(JSON.stringify(saved)));second.c.tick();assert.equal(second.state().models.length,0);assert(second.state().trained);assert(!second.c.running);
});
test('User-selected Data Knot JSON imports only with a single hand and ten scoped outputs',()=>{
 const f=fixture();for(let i=0;i<9;i++){const id=60+i;f.db[id]={type:'DeviceParameter',name:'Output '+i,min:0,max:1,value:.2,is_quantized:0,is_enabled:1};f.db[20].parameters.push(id);}f.c.tick();f.send({op:'scopeAll',value:'ten'});
 const doc={fits:{input_regressor:{layers:[{rows:5,cols:10,activation:0,biases:Array(10).fill(.3),weights:Array.from({length:5},()=>Array(10).fill(0))}]}},data:{datasets:{input:{data:{a:[0,0,0,0,0],b:[1,1,1,1,1]}},output:{data:{a:Array(10).fill(.3),b:Array(10).fill(.3)}}}}};f.files['/custom.json']=JSON.stringify(doc);f.send({op:'importModel'});f.c.readmodel('/custom.json');assert(f.state().trained);assert.equal(f.state().samples,2);f.send({op:'mode',value:'both'});f.send({op:'importModel'});f.c.readmodel('/custom.json');assert.match(f.state().note,/Left\/Right/);assert.equal(f.state().models.length,1);
});
test('Large named model snapshot uses bounded Blob/UI chunks and round-trips through JSON',()=>{
 const f=fixture();for(let i=0;i<255;i++){const id=1000+i;f.db[id]={type:'DeviceParameter',name:'参数 '+i,min:0,max:1,value:.3,is_quantized:0,is_enabled:1};f.db[20].parameters.push(id);}f.c.tick();f.c.left(.1,.2,.3,.4,.5);f.send({op:'capture'});
 f.c.bank().model=f.c.GloveNeural.copy({layers:[{rows:5,cols:256,activation:0,biases:Array(256).fill(.3),weights:Array.from({length:5},()=>Array(256).fill(0))}]});f.send({op:'saveModel',name:'Large model'});const id=f.state().modelSelection;assert.equal(f.state().models[0].outputs,256);assert(!('bank' in f.state().models[0]));const payload=f.out.filter(a=>a[0]===2).at(-1);assert.equal(payload[1],'list');assert(payload.slice(2).every(s=>s.length<=4096));f.c.storedPayload='';f.c.restore(...payload.slice(2));f.c.tick();assert.equal(f.state().models.length,1);f.send({op:'loadModel',id});assert.equal(f.c.bank().samples[0].y.length,256);f.send({op:'exportModel',id});f.c.writemodel('/large.json');assert(f.files['/large.json'].length>4096);assert.equal(JSON.parse(f.files['/large.json']).configs.length,256);
});
fs.mkdirSync(path.join(__dirname,'../validation'),{recursive:true});fs.writeFileSync(path.join(__dirname,'../validation/adapter.json'),JSON.stringify({kind:'Shipped Max adapter executed against a simulated Live Object Model',checks},null,2));console.log(checks.length+' adapter checks passed');
