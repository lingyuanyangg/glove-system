// Feature validation, temporal recognition and native model serialization.
// FluCoMa performs all neural training and prediction.
var Gesture = (function () {
    var labels=['open','fist','index','v','middle','ok','other'];
    var names=['Open hand','Fist','Index','V sign','Middle','OK','Other'];
    function pair(left,right){if(labels.slice(0,6).indexOf(left)<0||labels.slice(0,6).indexOf(right)<0)throw Error('Choose two known gestures');return left+'__'+right;}
    function keys(mode){dim(mode);var a=[];if(mode==='both'){for(var i=0;i<6;i++)for(var j=0;j<6;j++)a.push(pair(labels[i],labels[j]));}else a=labels.slice(0,6);return a;}
    function parts(label){if(label==='other')return null;if(labels.slice(0,6).indexOf(label)>=0)return {left:label,right:label};var p=String(label).split('__');if(p.length!==2||pair(p[0],p[1])!==label)throw Error('Invalid combined label');return {left:p[0],right:p[1]};}
    function title(label,mode){if(label==='other')return 'Other / transition';var p=parts(label);return mode==='both'?'L '+names[labels.indexOf(p.left)]+' + R '+names[labels.indexOf(p.right)]:names[labels.indexOf(label)];}
    function slot(mode,label){var i=keys(mode).indexOf(label);if(i<0)throw Error('Unknown gesture in this hand mode');return (mode==='left'?0:mode==='right'?6:12)+i;}
    function copy(v){return JSON.parse(JSON.stringify(v));}
    function number(v){return typeof v==='number'&&isFinite(v);}
    function vector(v,n){
        if(!(v instanceof Array)||v.length!==n)throw Error('Expected '+n+' finger values');
        var a=[];for(var i=0;i<n;i++){if(!number(v[i])||v[i]<0||v[i]>1)throw Error('Finger values must be finite and normalized 0–1');a.push(v[i]);}return a;
    }
    function dim(mode){if(['left','right','both'].indexOf(mode)<0)throw Error('Invalid hand mode');return mode==='both'?10:5;}
    function model(m,n,expected){
        if(!m||!m.mlp||!(m.mlp.layers instanceof Array)||m.mlp.layers.length<1||m.mlp.layers.length>4||!m.labels||!(m.labels.labels instanceof Array))throw Error('Not a native FluCoMa classifier');
        var list=m.labels.labels,allowed=n===10?keys('both').concat(['other']):labels,seen={};if(list.length<2||list.length>allowed.length||m.labels.rows!==list.length)throw Error('Invalid classifier labels');
        for(var i=0;i<list.length;i++){if(allowed.indexOf(list[i])<0||seen[list[i]])throw Error('Unknown or duplicate classifier label');seen[list[i]]=true;}
        if(expected&&(expected.length!==list.length||expected.some(function(s){return !seen[s];})))throw Error('Classifier labels differ from the recorded classes');
        for(var k=0;k<m.mlp.layers.length;k++){
            var l=m.mlp.layers[k];if(l.rows!==n||l.cols<1||l.cols>64||l.cols!==Math.floor(l.cols)||[0,1,2,3].indexOf(l.activation)<0||!(l.weights instanceof Array)||l.weights.length!==n||!(l.biases instanceof Array)||l.biases.length!==l.cols)throw Error('Invalid classifier layer');
            for(i=0;i<n;i++){if(!(l.weights[i] instanceof Array)||l.weights[i].length!==l.cols)throw Error('Invalid weight shape');for(var j=0;j<l.cols;j++)if(!number(l.weights[i][j]))throw Error('Invalid weight');}
            for(j=0;j<l.cols;j++)if(!number(l.biases[j]))throw Error('Invalid bias');n=l.cols;
        }
        if(n!==list.length)throw Error('Classifier output dimensions differ');return m;
    }
    function samples(a,n){
        if(!(a instanceof Array)||a.length>(n===10?8000:2800))throw Error('Invalid sample bank');var allowed=n===10?keys('both').concat(['other']):labels;
        var counts={};for(var i=0;i<a.length;i++){
            var s=a[i];if(!s||allowed.indexOf(s.label)<0||typeof s.trial!=='string'||!s.trial||s.trial.length>100)throw Error('Invalid recorded example');
            vector(s.x,n);counts[s.label]=(counts[s.label]||0)+1;if(counts[s.label]>400)throw Error('400 examples per gesture reached');
        }return a;
    }
    function bank(mode){return {samples:[],model:null,loss:null,enabled:keys(mode||'left').map(function(){return false;})};}
    function validateBank(b,n){var list=keys(n===10?'both':'left');if(!b||!(b.enabled instanceof Array)||b.enabled.length!==list.length||b.enabled.some(function(v){return typeof v!=='boolean';}))throw Error('Invalid bank');samples(b.samples,n);if(b.model){var expected=list.filter(function(s,i){return b.enabled[i];}).concat(['other']);model(b.model,n,expected);for(var i=0;i<expected.length;i++){var count=0;for(var j=0;j<b.samples.length;j++)if(b.samples[j].label===expected[i])count++;if(count<20)throw Error('Saved classifier needs examples for every learned label');}}if(b.loss!==null&&(!number(b.loss)||b.loss<0))throw Error('Invalid training loss');return b;}
    function migrateBank(b,mode){var v=copy(b);if(mode==='both'){if(!v||!v.enabled||v.enabled.length!==6)throw Error('Invalid legacy combined bank');var flags=keys('both').map(function(){return false;});for(var i=0;i<6;i++)flags[i*6+i]=!!v.enabled[i];v.enabled=flags;for(i=0;i<v.samples.length;i++)if(v.samples[i].label!=='other')v.samples[i].label=pair(v.samples[i].label,v.samples[i].label);if(v.model)for(i=0;i<v.model.labels.labels.length;i++)if(v.model.labels.labels[i]!=='other')v.model.labels.labels[i]=pair(v.model.labels.labels[i],v.model.labels.labels[i]);}return validateBank(v,dim(mode));}
    function record(r){
        if(!r||r.format!=='glove-gesture-model'||[1,2].indexOf(r.version)<0||typeof r.id!=='string'||!r.id||typeof r.name!=='string'||!r.name.trim()||r.name.length>80||typeof r.savedAt!=='string'||!isFinite(Date.parse(r.savedAt)))throw Error('Invalid gesture model file');
        if(r.version===1){r=copy(r);r.bank=migrateBank(r.bank,r.mode);r.version=2;}
        var n=dim(r.mode);validateBank(r.bank,n);if(!r.bank.model||!r.bank.samples.length)throw Error('Model needs its training samples for distance rejection');return r;
    }
    function distance(x,a,label){
        var best=Infinity;for(var i=0;i<a.length;i++)if(a[i].label===label){var d=0;for(var j=0;j<x.length;j++)d+=Math.pow(x[j]-a[i].x[j],2);best=Math.min(best,Math.sqrt(d/x.length));}return best;
    }
    function Temporal(hold,cooldown){this.hold=hold;this.cooldown=cooldown;this.reset();}
    Temporal.prototype.reset=function(){this.candidate=null;this.since=0;this.confirmed=null;this.lastFire=-Infinity;this.lastTime=-Infinity;};
    Temporal.prototype.feed=function(label,now){
        var event={enter:null,exit:null};
        // A gap in observations must not count as a continuous held gesture.
        if(now-this.lastTime>300&&this.lastTime!==-Infinity){event.exit=this.confirmed;this.candidate=null;this.confirmed=null;}
        this.lastTime=now;
        if(label!==this.candidate){this.candidate=label;this.since=now;return event;}
        if(now-this.since<this.hold||label===this.confirmed)return event;
        if(label!=='other'&&now-this.lastFire<this.cooldown)return event;
        event.exit=this.confirmed;this.confirmed=label;
        if(label!=='other'){event.enter=label;this.lastFire=now;}return event;
    };
    return {labels:labels,names:names,pair:pair,keys:keys,parts:parts,title:title,slot:slot,migrateBank:migrateBank,copy:copy,number:number,vector:vector,dim:dim,model:model,samples:samples,bank:bank,validateBank:validateBank,record:record,distance:distance,Temporal:Temporal};
}());
if(typeof module!=='undefined')module.exports=Gesture;

// Per-instance native classifier lifecycle; deferred load acknowledgements are required.
var GestureNative=(function(){
    function Bridge(patcher,ns,callbacks){this.patcher=patcher;this.ns=String(ns);this.callbacks=callbacks;this.available=false;this.fault=null;this.disposed=false;this.job=null;this.pending=null;this.operation=null;this.loaded=null;this.generation=0;this.task=null;}
    Bridge.prototype.init=function(){
        this.train=this.patcher.getnamed('classifier-train');this.infer=this.patcher.getnamed('classifier-infer');this.x=this.patcher.getnamed('data-input');this.y=this.patcher.getnamed('data-labels');this.inputObject=this.patcher.getnamed('input-buffer');
        this.names={x:this.ns+'-gesture-x',y:this.ns+'-gesture-labels',input:this.ns+'-gesture-input'};
        this.buffer=new Buffer(this.names.input);this.xDict=new Dict(this.ns+'-gesture-x-dict');this.yDict=new Dict(this.ns+'-gesture-y-dict');this.modelDict=new Dict(this.ns+'-gesture-model-dict');
        this.probe=new Date().getTime()+3000;this.infer.message('cols');
    };
    Bridge.prototype.check=function(){if(this.fault)throw Error(this.fault);if(!this.available)throw Error('FluCoMa is not ready; install FluidCorpusManipulation and reload');};
    Bridge.prototype.fail=function(message){this.fault=message;this.available=false;this.pending=null;this.operation=null;this.job=null;if(this.task)this.task.cancel();this.task=null;this.callbacks.error(message);};
    Bridge.prototype.watch=function(now){if(this.disposed||this.fault)return;if(!this.available&&now>this.probe)this.fail('FluCoMa did not respond; check Max Console and reload');else if(this.job&&this.job.deadline&&now>this.job.deadline)this.fail('Native training timed out; check Max Console and reload');else if(this.operation&&now>this.operation.deadline)this.fail('Native inference timed out; check Max Console and reload');};
    Bridge.prototype.start=function(a,n,epochs){
        this.check();if(this.job)throw Error('Wait for the previous native training response');Gesture.samples(a,n);
        var x={cols:n,data:{}},y={cols:1,data:{}},classes=[];for(var i=0;i<a.length;i++){x.data[String(i)]=a[i].x;y.data[String(i)]=[a[i].label];if(classes.indexOf(a[i].label)<0)classes.push(a[i].label);}
        if(classes.length<2)throw Error('Record at least two classes');
        var job={epoch:0,epochs:epochs,n:n,classes:classes,loss:null,best:null,bestLoss:Infinity,chunk:Math.max(1,Math.min(10,Math.floor(32768/(a.length*classes.length*(n===10?32:8))))),stage:'datasets',xLoaded:false,yLoaded:false,cancelled:false,deadline:new Date().getTime()+10000};this.job=job;
        this.train.message('clear');this.train.message('hiddenlayers',n===10?32:8);this.train.message('activation',3);this.train.message('learnrate',0.01);this.train.message('momentum',0.9);this.train.message('batchsize',4);this.train.message('validation',0);
        this.xDict.parse(JSON.stringify(x));this.yDict.parse(JSON.stringify(y));this.x.message('load','dictionary',this.xDict.name);this.y.message('load','dictionary',this.yDict.name);return job;
    };
    Bridge.prototype.schedule=function(){var self=this,j=this.job;if(!j)return;if(j.cancelled){this.job=null;return;}j.stage='scheduled';j.deadline=0;this.task=new Task(function(){self.task=null;try{self.fit();}catch(e){self.fail(e.message);}},this);this.task.schedule(1);};
    Bridge.prototype.fit=function(){var j=this.job;if(!j||j.cancelled){this.job=null;return;}j.now=Math.min(j.chunk,j.epochs-j.epoch);j.stage='fit';j.deadline=new Date().getTime()+10000;this.train.message('maxiter',j.now);this.train.message('fit',this.names.x,this.names.y);};
    Bridge.prototype.cancel=function(){if(!this.job)return;this.job.cancelled=true;if(this.job.stage==='scheduled'){if(this.task)this.task.cancel();this.task=null;this.job=null;}};
    Bridge.prototype.invalidate=function(){this.generation++;this.pending=null;};
    Bridge.prototype.predict=function(m,x,tag){this.check();Gesture.model(m,x.length);this.pending={model:m,x:Gesture.vector(x,x.length),tag:tag,generation:this.generation};this.pump();};
    Bridge.prototype.pump=function(){if(this.disposed||this.fault||this.operation||!this.pending)return;var r=this.pending;this.pending=null;if(this.loaded!==r.model){this.operation={kind:'load',r:r,deadline:new Date().getTime()+3000};this.modelDict.parse(JSON.stringify(r.model));this.infer.message('load','dictionary',this.modelDict.name);}else this.query(r);};
    Bridge.prototype.query=function(r){if(r.generation!==this.generation){this.pump();return;}if(this.buffer.framecount()!==r.x.length)this.inputObject.message('sizeinsamps',r.x.length);if(this.buffer.framecount()!==r.x.length)throw Error('Native buffer did not resize');this.buffer.poke(1,0,r.x);this.operation={kind:'predictpoint',r:r,deadline:new Date().getTime()+3000};this.infer.message('predictpoint',this.names.input);};
    Bridge.prototype.receive=function(lane,args){
        if(this.disposed||this.fault||!args.length)return;
        try{var method=String(args[0]).toLowerCase(),j=this.job;
            if(lane==='infer'){
                if(method==='cols'){this.available=true;this.probe=0;this.callbacks.status();return;}
                var op=this.operation;if(!op||method!==op.kind)return;this.operation=null;
                if(method==='load'){this.loaded=op.r.model;if(op.r.generation===this.generation){var r=op.r;if(this.pending&&this.pending.model===r.model&&this.pending.generation===r.generation){r=this.pending;this.pending=null;}this.query(r);}}
                else if(op.r.generation===this.generation){var label=String(args[args.length-1]);if(op.r.model.labels.labels.indexOf(label)<0)throw Error('Native classifier returned an unknown label');this.callbacks.prediction(label,op.r.x,op.r.tag);}
                this.pump();return;
            }
            if(!j)return;
            if((lane==='input'||lane==='labels')&&method==='load'&&j.stage==='datasets'){if(lane==='input')j.xLoaded=true;else j.yLoaded=true;if(j.xLoaded&&j.yLoaded)this.schedule();return;}
            if(lane!=='train')return;
            if(method==='fit'&&j.stage==='fit'){if(j.cancelled){this.job=null;return;}var error=Number(args[args.length-1]);if(!isFinite(error)||error<0)throw Error('Invalid classifier loss');j.epoch+=j.now;j.loss=Math.sqrt(error/j.classes.length);j.stage='dump';j.deadline=new Date().getTime()+3000;this.train.message('dump');}
            else if(method==='dump'&&j.stage==='dump'){if(j.cancelled){this.job=null;return;}if(args[1]!=='dictionary'||typeof args[2]!=='string')throw Error('Expected native classifier dictionary');var d=new Dict(args[2]),m;try{m=JSON.parse(d.stringify());}finally{d.freepeer();}Gesture.model(m,j.n,j.classes);if(j.loss<j.bestLoss){j.best=Gesture.copy(m);j.bestLoss=j.loss;}if(j.epoch>=j.epochs||j.bestLoss<0.01){this.job=null;this.callbacks.trained(j);}else this.schedule();}
        }catch(e){this.fail(e.message);}
    };
    Bridge.prototype.dispose=function(){this.disposed=true;this.invalidate();this.cancel();if(this.task)this.task.cancel();var peers=[this.buffer,this.xDict,this.yDict,this.modelDict];for(var i=0;i<peers.length;i++)if(peers[i])try{peers[i].freepeer();}catch(e){}};
    return {Bridge:Bridge};
}());
if(typeof module!=='undefined')module.exports=GestureNative;

autowatch=0;inlets=1;outlets=4;
var owner=this.patcher,ready=false,uiReady=false,backend=null,clockTask=null,mode='left',running=false,runEpoch=0;
var banks={left:Gesture.bank('left'),right:Gesture.bank('right'),both:Gesture.bank('both')},frames={left:null,right:null},frameTimes={left:0,right:0},frameSeq=0;
var hold=120,cooldown=350,radius=0.18,epochs=500,pulse=120,temporal=new Gesture.Temporal(hold,cooldown),recording=null,trainer=null,trainingBank=null;
var mappings=[],mapIDs=[],actions=[],owned={},lastQuery=0,lastRecordSeq=-1,lastUi=0,selections={left:'open',right:'open'},learning=-1,mappingReady=false,mappingWeb=null,mapPool=null;
for(var mappingIndex=0;mappingIndex<48;mappingIndex++){mappings.push(null);mapIDs.push(0);actions.push('toggle');}
var note='Record each gesture and Other, then Train',candidate='other',distance=null,models=[],modelSelection='',sequence=0,stored='',colors={},pendingExport=null,pendingImport=false;
function now(){return new Date().getTime();}
function say(s){note=s;}
function bank(){return banks[mode];}
function selectedLabel(){return mode==='both'?Gesture.pair(selections.left,selections.right):selections[mode];}
function pool(){if(!mapPool)mapPool=owner.getnamed('mapping-pool').subpatcher();return mapPool;}
function mappingSurface(){if(!mappingWeb)mappingWeb=owner.getnamed('mapping-panel').subpatcher().getnamed('mapping-web');return mappingWeb;}
function cancelMapping(){if(learning>=0){pool().getnamed('learn-'+learning).message('cancel');learning=-1;}}
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
        if(time>=recording.end||count>=400||b.samples.length>=(mode==='both'?8000:2800)){stopRecord();say(count>=400?'400 examples for this class reached':'Recording complete · repeat from a different pose');}
        else{b.samples.push({x:x,label:recording.label,trial:recording.trial});b.model=null;b.loss=null;recording.next=time+50;lastRecordSeq=frameSeq;}
    }
    if(running&&time-lastQuery>=20){
        try{backend.predict(bank().model,x,{epoch:runEpoch,mode:mode,time:time});lastQuery=time;}catch(e){stop();say(e.message);}
    }
}
function mapped(slot){
    var a=arrayfromargs(arguments),i=Number(a.shift()),id=0;if(i<0||i>47||i!==Math.floor(i))return;
    for(var k=0;k<a.length;k++)if(a[k]!=='id'&&Number(a[k])>0){id=Number(a[k]);break;}
    if(ready&&id!==mapIDs[i])stop();releaseSlot(i);mapIDs[i]=id;mappings[i]=null;
    if(id&&ready)try{mappings[i]=parameter(id);}catch(e){say(e.message);}
    emit();
}
function learned(){var a=arrayfromargs(arguments),i=Number(a.shift()),id=0;for(var k=0;k<a.length;k++)if(a[k]!=='id'&&Number(a[k])>0){id=Number(a[k]);break;}if(i<0||i>47||i!==Math.floor(i)||!id)return;try{parameter(id);pool().getnamed('target-'+i).message('id',id);mapped(i,'id',id);say('Button mapped');}catch(e){say(e.message);}if(learning===i)learning=-1;emit();}
function learnstate(i,value){if(Number(value)===0&&learning===Number(i))learning=-1;emit();}
function actionEnter(label,time){
    if(label==='other')return;var i=Gesture.slot(mode,label),number=Gesture.keys(mode).indexOf(label)+1;
    outlet(1,'enter',mode,label,number);var p=mappings[i];if(!p)return;
    try{
        p=parameter(p.id);mappings[i]=p;var value=Number(one(p.api,'value')),type=actions[i];
        // A later action for the same target supersedes an earlier temporary hold.
        if(owned[p.id])delete owned[p.id];
        if(type==='toggle')write(p,value>(p.lo+p.hi)/2?p.lo:p.hi);
        else if(type==='off')write(p,p.lo);
        else{write(p,p.hi);if(type==='pulse'||type==='gate')owned[p.id]={slot:i,p:p,type:type,due:type==='pulse'?time+pulse:Infinity};}
    }catch(e){mappings[i]=null;say('Mapping: '+e.message);}
}
function actionExit(label){if(!label||label==='other')return;var i=Gesture.slot(mode,label);for(var id in owned)if(owned[id].slot===i&&owned[id].type==='gate')release(id);outlet(1,'exit',mode,label,Gesture.keys(mode).indexOf(label)+1);}
function prediction(label,x,tag){
    if(!running||tag.epoch!==runEpoch||tag.mode!==mode||now()-tag.time>300)return;
    try{fresh(now());}catch(e){invalidate();say(e.message);return;}
    var b=bank(),idx=Gesture.keys(mode).indexOf(label);distance=Gesture.distance(x,b.samples,label);
    if(distance>radius||label!=='other'&&(idx<0||!b.enabled[idx]))label='other';candidate=label;
    var event=temporal.feed(label,tag.time);if(event.exit)actionExit(event.exit);if(event.enter)actionEnter(event.enter,now());
}
function startRecord(label){
    if(label!=='other'&&Gesture.keys(mode).indexOf(label)<0)throw Error('Unknown gesture in this hand mode');if(trainer||backend&&backend.job)throw Error('Cancel training and wait before recording');
    stop();stopRecord();fresh(now());if(label!=='other')bank().enabled[Gesture.keys(mode).indexOf(label)]=true;recording={label:label,trial:'trial-'+now()+'-'+Math.floor(Math.random()*1e6),next:now(),end:now()+2000};lastRecordSeq=-1;say('Recording '+Gesture.title(label,mode)+' · hold for 2 seconds');
}
function train(){
    stop();stopRecord();backend.check();var b=bank(),list=Gesture.keys(mode),counts=countSamples(),a=b.samples.filter(function(s){return s.label==='other'||b.enabled[list.indexOf(s.label)];});
    var active=0;for(var i=0;i<list.length;i++)if(b.enabled[i]){active++;if(counts[i]<20)throw Error('Record at least 20 examples of '+Gesture.title(list[i],mode)+' or disable it');}
    if(!active)throw Error('Enable at least one gesture');if(counts[counts.length-1]<20)throw Error('Record at least 20 Other / transition examples');
    trainingBank=b;try{trainer=backend.start(a,Gesture.dim(mode),epochs);}catch(e){trainingBank=null;throw e;}say('Native FluCoMa training');
}
function trained(job){if(trainer!==job||job.cancelled||trainingBank!==bank())return;trainingBank.model=Gesture.copy(job.best);trainingBank.loss=job.bestLoss;trainer=null;trainingBank=null;say('Trained · test unfamiliar poses before enabling actions');persist();emit();}
function nativeError(s){stop();cancelTrain();say(s);emit();}
function nativeinput(){if(backend)backend.receive('input',arrayfromargs(arguments));}function nativelabels(){if(backend)backend.receive('labels',arrayfromargs(arguments));}function nativetrain(){if(backend)backend.receive('train',arrayfromargs(arguments));}function nativeinfer(){if(backend)backend.receive('infer',arrayfromargs(arguments));}
function countSamples(which){which=which||mode;var list=Gesture.keys(which).concat(['other']),c=list.map(function(){return 0;}),a=banks[which].samples;for(var i=0;i<a.length;i++)c[list.indexOf(a[i].label)]++;return c;}
function tick(){
    var t=now();if(backend)backend.watch(t);
    for(var id in owned)if(owned[id].due<=t)release(id);
    if(recording&&t>=recording.end){stopRecord();say('Recording complete · repeat with small variations');}
    if(running)try{fresh(t);}catch(e){if(temporal.confirmed||candidate!=='other')invalidate();say(e.message);}
    if(trainer)say('FluCoMa training '+trainer.epoch+' / '+trainer.epochs+(Gesture.number(trainer.loss)?' · training RMSE '+trainer.loss.toFixed(4):''));if(t-lastUi>=100){lastUi=t;emit();}
}
function chunks(s){var a=[];for(var i=0;i<s.length;i+=4096)a.push(s.substring(i,i+4096));return a.length?a:[''];}
function persist(){stored=encodeURIComponent(JSON.stringify({version:2,mode:mode,banks:banks,models:models,modelSelection:modelSelection,selections:selections,hold:hold,cooldown:cooldown,radius:radius,epochs:epochs,pulse:pulse,actions:actions}));var a=chunks(stored);if(a.length===1)outlet(2,a[0]);else outlet.apply(this,[2,'list'].concat(a));}
function validSettings(d){
    var keys=['hold','cooldown','radius','epochs','pulse'],ranges=[[40,1000],[0,3000],[0.01,1],[50,3000],[40,1000]];
    for(var i=0;i<keys.length;i++)if(!Gesture.number(d[keys[i]])||d[keys[i]]<ranges[i][0]||d[keys[i]]>ranges[i][1])throw Error('Invalid '+keys[i]+' setting');
    if(!(d.actions instanceof Array)||d.actions.length!==48||d.actions.some(function(v){return ['toggle','pulse','gate','on','off'].indexOf(v)<0;}))throw Error('Invalid button actions');
}
function restore(){
    var encoded=arrayfromargs(arguments).join('');if(!encoded||encoded===stored)return;
    try{var d=JSON.parse(decodeURIComponent(encoded));if([1,2].indexOf(d.version)<0)throw Error('Unsupported saved state');Gesture.dim(d.mode);
        if(d.version===1){if(!d.actions||d.actions.length!==6)throw Error('Invalid legacy actions');var old=d.actions;d.actions=[];for(var k=0;k<48;k++)d.actions.push(k<12?old[k%6]:old[Math.floor((k-12)/6)]);for(var key in d.banks)d.banks[key]=Gesture.migrateBank(d.banks[key],key);d.selections={left:'open',right:'open'};}validSettings(d);Gesture.pair(d.selections.left,d.selections.right);
        if(!d.banks)throw Error('Missing hand banks');for(var i=0;i<3;i++){var m=['left','right','both'][i];Gesture.validateBank(d.banks[m],Gesture.dim(m));}
        if(!(d.models instanceof Array)||d.models.length>64)throw Error('Invalid model library');var seen={};for(i=0;i<d.models.length;i++){d.models[i]=Gesture.record(d.models[i]);if(seen[d.models[i].id])throw Error('Duplicate model ID');seen[d.models[i].id]=true;}
        stop();stopRecord();cancelTrain();cancelMapping();banks=Gesture.copy(d.banks);models=Gesture.copy(d.models);mode=d.mode;hold=d.hold;cooldown=d.cooldown;radius=d.radius;epochs=d.epochs;pulse=d.pulse;actions=d.actions.slice();selections=Gesture.copy(d.selections);temporal=new Gesture.Temporal(hold,cooldown);modelSelection=seen[d.modelSelection]?d.modelSelection:'';stored=encoded;say('Restored · Run is off');emit();
    }catch(e){say('Saved state: '+e.message);}
}
function findModel(id){for(var i=0;i<models.length;i++)if(models[i].id===id)return models[i];throw Error('Choose a saved model');}
function saveModel(name){
    name=String(name||'').trim();if(!name||name.length>80)throw Error('Enter a name (1–80 characters)');if(models.length>=64)throw Error('64 saved models reached');
    var r=Gesture.record({format:'glove-gesture-model',version:2,id:'gesture-'+now()+'-'+Math.floor(Math.random()*1e9),name:name,savedAt:new Date().toISOString(),mode:mode,bank:Gesture.copy(bank())});models.push(r);modelSelection=r.id;persist();say('Model saved · save the Live Set or export JSON');
}
function directory(){var p=owner.filepath||'',i=p.lastIndexOf('/');return i<0?'':p.substring(0,i+1);}
function loadbang(){outlet(0,'readfile',directory()+'gesture_ui.html');try{mappingSurface().message('readfile',directory()+'gesture_mapping.html');}catch(e){}}
function bang(){
    try{var self=new LiveAPI(null,'this_device');if(!Number(self.id))throw Error('Load the AMXD in Ableton Live');ready=true;
        for(var i=0;i<48;i++){if(mapIDs[i])try{mappings[i]=parameter(mapIDs[i]);}catch(e){mappings[i]=null;}pool().getnamed('target-'+i).message('getid');}
        if(!backend){backend=new GestureNative.Bridge(owner,String(jsarguments[1]),{prediction:prediction,trained:trained,error:nativeError,status:emit});backend.init();}
        if(clockTask)clockTask.cancel();clockTask=new Task(tick,this);clockTask.interval=25;clockTask.repeat();emit();
    }catch(e){ready=false;say(e.message);emit();}
}
function theme(name,r,g,b,a){if(['live_lcd_bg','live_control_text_bg','live_control_fg','live_lcd_control_fg','live_lcd_control_fg_zombie'].indexOf(String(name))<0)return;var v=[r,g,b,a];if(v.every(Gesture.number))colors[String(name)]=v;}
function command(encoded){
    try{var c=JSON.parse(decodeURIComponent(String(encoded)));
        if(c.op==='hello'){if(c.surface==='mapping')mappingReady=true;else uiReady=true;emit();return;}
        if(c.op==='mapping'){outlet(3,'mapping');return;}
        if(c.op==='help'){outlet(3,'help');return;}
        if(c.op==='stop'){stop();cancelTrain();stopRecord();cancelMapping();say('Stopped · temporary button holds released');emit();return;}
        if(c.op==='mode'){Gesture.dim(c.value);stop();cancelTrain();stopRecord();cancelMapping();mode=c.value;say('Changed hand bank · Run is off');persist();}
        else if(c.op==='selectGesture'){if(recording||trainer||backend&&backend.job)throw Error('Finish recording/training first');if(['left','right'].indexOf(c.hand)<0||Gesture.labels.slice(0,6).indexOf(c.value)<0)throw Error('Choose a gesture');stop();selections[c.hand]=c.value;persist();}
        else if(c.op==='pickModel'){findModel(c.id);modelSelection=c.id;persist();}
        else if(c.op==='import'){pendingImport=true;outlet(3,'import');}
        else if(c.op==='export'){pendingExport=Gesture.copy(Gesture.record(findModel(c.id)));outlet(3,'export');}
        else if(c.op==='loadModel'){var r=Gesture.record(findModel(c.id));if(r.mode!==mode)throw Error('Choose '+r.mode+' mode first');stop();cancelTrain();stopRecord();banks[mode]=Gesture.copy(r.bank);modelSelection=r.id;persist();say('Loaded '+r.name+' · Run is off');}
        else if(c.op==='deleteModel'){findModel(c.id);models=models.filter(function(m){return m.id!==c.id;});if(modelSelection===c.id)modelSelection='';persist();}
        else{
            if(!ready)throw Error('Load this device in Ableton Live');
            if(c.op==='run'){if(running){stop();say('Run off');}else{if(recording||trainer||backend.job)throw Error('Finish recording/training first');backend.check();Gesture.model(bank().model,Gesture.dim(mode));fresh(now());stop();running=true;say('Classifying · hold a gesture to trigger its button');processFrame(now());}}
            else if(c.op==='record'){startRecord(c.label||selectedLabel());}
            else if(c.op==='train'){if(trainer){cancelTrain();say('Training cancelled; previous completed model retained');}else train();}
            else if(c.op==='saveModel'){if(recording||trainer)throw Error('Finish recording/training first');saveModel(c.name);}
            else if(c.op==='map'||c.op==='unmap'){var i=Number(c.index);if(i<0||i>47||i!==Math.floor(i))throw Error('Invalid mapping row');stop();cancelMapping();if(c.op==='map'){learning=i;pool().getnamed('learn-'+i).message('int',1);say('Click a two-state device button in Live');}else{pool().getnamed('learn-'+i).message('unmap');pool().getnamed('target-'+i).message('id',0);mapped(i,'id',0);}}
            else if(c.op==='action'){var i=Number(c.index);if(i<0||i>47||i!==Math.floor(i)||['toggle','pulse','gate','on','off'].indexOf(c.value)<0)throw Error('Invalid button action');stop();actions[i]=c.value;persist();}
            else if(c.op==='setting'){if(['hold','cooldown','radius','epochs','pulse'].indexOf(c.key)<0)throw Error('Unknown setting');var d={hold:hold,cooldown:cooldown,radius:radius,epochs:epochs,pulse:pulse,actions:actions};d[c.key]=Number(c.value);validSettings(d);stop();hold=d.hold;cooldown=d.cooldown;radius=d.radius;epochs=Math.floor(d.epochs);pulse=d.pulse;temporal=new Gesture.Temporal(hold,cooldown);persist();}
            else if(c.op==='enabled'||c.op==='clear'){
                if(recording||trainer||backend.job)throw Error('Stop recording/training first');var label=String(c.label||selectedLabel()),idx=Gesture.keys(mode).indexOf(label);if(idx<0&&label!=='other')throw Error('Invalid gesture');stop();
                if(c.op==='enabled'){if(label==='other')throw Error('Other class is always enabled');bank().enabled[idx]=!!c.value;}else bank().samples=bank().samples.filter(function(s){return s.label!==label;});bank().model=null;bank().loss=null;persist();
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
    if(!uiReady&&!mappingReady)return;var state={mode:mode,selections:selections,selectedLabel:selectedLabel(),classKeys:Gesture.keys(mode),learning:learning,ready:ready,engineReady:!!(backend&&backend.available&&!backend.fault),running:running,training:!!trainer,recording:recording?recording.label:null,counts:countSamples(),enabled:bank().enabled,trained:!!bank().model,loss:bank().loss,hold:hold,cooldown:cooldown,radius:radius,epochs:epochs,pulse:pulse,actions:actions,note:note,candidate:candidate,confirmed:temporal.confirmed,distance:distance,left:frames.left,right:frames.right,leftFresh:!!frames.left&&now()-frameTimes.left<=300,rightFresh:!!frames.right&&now()-frameTimes.right<=300,colors:colors,targets:mappings.map(function(p){return p?p.name:'';}),models:models.map(function(r){return {id:r.id,name:r.name,mode:r.mode};}),modelSelection:modelSelection};
    state.allCounts={left:countSamples('left'),right:countSamples('right'),both:countSamples('both')};state.allEnabled={left:banks.left.enabled,right:banks.right.enabled,both:banks.both.enabled};
    var a=chunks(encodeURIComponent(JSON.stringify(state))),seq=++sequence;for(var i=0;i<a.length;i++){if(uiReady)outlet(0,'statepacket',seq,i,a.length,a[i]);if(mappingReady)mappingSurface().message('statepacket',seq,i,a.length,a[i]);}
}
function notifydeleted(){stop();if(clockTask)clockTask.cancel();cancelTrain();cancelMapping();if(backend)backend.dispose();}
