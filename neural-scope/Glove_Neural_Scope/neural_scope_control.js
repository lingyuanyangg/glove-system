// Model validation and serialization only. All training/inference runs in native FluCoMa.
var GloveNeural = (function () {
    function copy(v) { return JSON.parse(JSON.stringify(v)); }
    function number(v) { return typeof v === 'number' && isFinite(v); }
    function clamp(v, lo, hi) { return Math.max(lo,Math.min(hi,v)); }
    function vector(a,n) {
        if (!a || a.length!==n) throw Error('Expected '+n+' numeric values');
        var out=[];for(var i=0;i<n;i++) {if(!number(a[i]))throw Error('Non-finite input');out.push(clamp(a[i],0,1));}return out;
    }
    function validate(model,nin,nout) {
        if(!model||!model.layers||model.layers.length<1||model.layers.length>8)throw Error('Invalid neural model');
        var n=nin;
        for(var k=0;k<model.layers.length;k++) {
            var l=model.layers[k];
            if(l.rows!==n||l.cols<1||l.cols>256||l.cols!==Math.floor(l.cols)||
                [0,1,2,3].indexOf(l.activation)<0||!l.biases||l.biases.length!==l.cols||!l.weights||l.weights.length!==l.rows)
                throw Error('Incompatible neural layer');
            for(var j=0;j<l.cols;j++)if(!number(l.biases[j]))throw Error('Invalid bias');
            for(var i=0;i<l.rows;i++) {
                if(!l.weights[i]||l.weights[i].length!==l.cols)throw Error('Invalid weight shape');
                for(j=0;j<l.cols;j++)if(!number(l.weights[i][j]))throw Error('Invalid weight');
            }
            n=l.cols;
        }
        if(n!==nout)throw Error('Model output count does not match scoped parameters');return model;
    }
    function fromDataKnot(doc,nin,nout) {
        if(nin!==5||nout!==10)throw Error('Data Knot import requires Left/Right input and exactly 10 scoped parameters');
        if(!doc||!doc.fits||!doc.fits.input_regressor)throw Error('Not a Data Knot regression file');
        var model=copy(validate(doc.fits.input_regressor,nin,nout)),samples=[],datasets=doc.data&&doc.data.datasets;
        if(datasets&&datasets.input&&datasets.output){
            var xs=datasets.input.data,ys=datasets.output.data;
            for(var key in xs)if(ys[key])samples.push({x:vector(xs[key],5),y:vector(ys[key],10)});
        }
        return {model:model,samples:samples,loss:null,origin:'Data Knot · imported by user'};
    }
    function fromFluCoMa(doc,nin,nout) {
        return {model:copy(validate(doc,nin,nout)),samples:[],loss:null,origin:'FluCoMa · imported by user'};
    }
    return {copy:copy,number:number,clamp:clamp,vector:vector,validate:validate,
        fromDataKnot:fromDataKnot,fromFluCoMa:fromFluCoMa};
}());
if(typeof module!=='undefined')module.exports=GloveNeural;

// Native FluCoMa message lifecycle. No neural math or optimiser runs in JavaScript.
var GloveFluCoMa = (function () {
    function Bridge(patcher, namespace, callbacks) {
        this.patcher=patcher;this.namespace=String(namespace);this.callbacks=callbacks;
        this.available=false;this.fault=null;this.disposed=false;this.job=null;this.generation=0;
        this.pending=null;this.operation=null;this.loadedModel=null;this.nextTask=null;this.probeDeadline=0;
        this.names={input:this.namespace+'-glove-input',output:this.namespace+'-glove-output',x:this.namespace+'-glove-x',y:this.namespace+'-glove-y'};
    }
    Bridge.prototype.initialize=function(){
        this.trainObject=this.patcher.getnamed('mlp-train');this.inferObject=this.patcher.getnamed('mlp-infer');
        this.xObject=this.patcher.getnamed('data-input');this.yObject=this.patcher.getnamed('data-output');
        this.inputObject=this.patcher.getnamed('native-input-buffer');this.outputObject=this.patcher.getnamed('native-output-buffer');
        this.inputBuffer=new Buffer(this.names.input);this.outputBuffer=new Buffer(this.names.output);
        this.xDict=new Dict(this.namespace+'-glove-x-dict');this.yDict=new Dict(this.namespace+'-glove-y-dict');this.modelDict=new Dict(this.namespace+'-glove-model-dict');
        this.probeDeadline=new Date().getTime()+3000;this.inferObject.message('cols');
    };
    Bridge.prototype.check=function(){if(this.fault)throw Error(this.fault);if(!this.available)throw Error('FluCoMa is not ready; install FluidCorpusManipulation in Max Package Manager');};
    Bridge.prototype.fail=function(message){
        this.fault=message;this.available=false;this.pending=null;this.operation=null;
        if(this.nextTask)this.nextTask.cancel();this.nextTask=null;this.job=null;
        this.callbacks.error(message);
    };
    Bridge.prototype.watch=function(){
        if(this.disposed||this.fault)return;var now=new Date().getTime();
        if(!this.available&&this.probeDeadline&&now>this.probeDeadline)this.fail('FluCoMa did not respond; check installation and the Max Console, then reload the device');
        else if(this.job&&this.job.deadline&&now>this.job.deadline)this.fail('FluCoMa training response timed out; check the Max Console and reload the device');
        else if(this.operation&&now>this.operation.deadline)this.fail('FluCoMa prediction response timed out; check the Max Console and reload the device');
    };
    Bridge.prototype.startTrain=function(samples,nin,nout,epochs){
        this.check();if(this.job)throw Error('Wait for the previous native training request to finish');
        if(samples.length<2||samples.length>512)throw Error('Capture 2–512 different poses before training');
        var x={cols:nin,data:{}},y={cols:nout,data:{}};
        for(var i=0;i<samples.length;i++){
            x.data[String(i)]=GloveNeural.vector(samples[i].x,nin);y.data[String(i)]=GloveNeural.vector(samples[i].y,nout);
            var xy=samples[i].x.concat(samples[i].y);for(var j=0;j<xy.length;j++)if(xy[j]<0||xy[j]>1)throw Error('Training examples must be normalized');
        }
        var job={epoch:0,epochs:epochs,nin:nin,nout:nout,samples:samples.length,loss:null,bestLoss:Infinity,best:null,
            chunk:Math.max(1,Math.min(10,Math.floor(32768/(samples.length*nout*16)))),stage:'datasets',xLoaded:false,yLoaded:false,cancelled:false,deadline:new Date().getTime()+10000};
        this.job=job;
        this.trainObject.message('clear');this.trainObject.message('hiddenlayers',16);this.trainObject.message('activation',3);this.trainObject.message('outputactivation',0);
        this.trainObject.message('learnrate',0.01);this.trainObject.message('momentum',0.9);this.trainObject.message('batchsize',1);this.trainObject.message('validation',0);
        this.xDict.parse(JSON.stringify(x));this.yDict.parse(JSON.stringify(y));
        this.xObject.message('load','dictionary',this.xDict.name);this.yObject.message('load','dictionary',this.yDict.name);
        return job;
    };
    Bridge.prototype.scheduleFit=function(){
        var self=this,job=this.job;if(!job)return;
        if(job.cancelled){this.job=null;return;}job.stage='scheduled';job.deadline=0;
        this.nextTask=new Task(function(){self.nextTask=null;try{self.fitChunk();}catch(e){self.fail(e.message);}},this);this.nextTask.schedule(1);
    };
    Bridge.prototype.fitChunk=function(){
        var job=this.job;if(!job)return;if(job.cancelled){this.job=null;return;}
        job.chunkNow=Math.min(job.chunk,job.epochs-job.epoch);job.stage='fit';job.deadline=new Date().getTime()+10000;
        this.trainObject.message('maxiter',job.chunkNow);this.trainObject.message('fit',this.names.x,this.names.y);
    };
    Bridge.prototype.cancelTrain=function(){
        var job=this.job;if(!job)return;job.cancelled=true;
        // Drain an outstanding native response before allowing a new job.
        if(job.stage==='scheduled'){if(this.nextTask)this.nextTask.cancel();this.nextTask=null;this.job=null;}
    };
    Bridge.prototype.invalidate=function(){this.generation++;this.pending=null;};
    Bridge.prototype.predict=function(model,x,nout,tag){
        this.check();GloveNeural.validate(model,x.length,nout);
        this.pending={model:model,x:GloveNeural.vector(x,x.length),nout:nout,tag:tag,generation:this.generation};this.pump();
    };
    Bridge.prototype.pump=function(){
        if(this.operation||!this.pending||this.disposed||this.fault)return;
        var request=this.pending;this.pending=null;
        if(this.loadedModel!==request.model){
            this.operation={kind:'load',request:request,deadline:new Date().getTime()+3000};
            this.modelDict.parse(JSON.stringify(request.model));this.inferObject.message('load','dictionary',this.modelDict.name);
        }else this.query(request);
    };
    Bridge.prototype.query=function(request){
        if(request.generation!==this.generation){this.pump();return;}
        if(this.inputBuffer.framecount()!==request.x.length)this.inputObject.message('sizeinsamps',request.x.length);
        if(this.outputBuffer.framecount()!==request.nout)this.outputObject.message('sizeinsamps',request.nout);
        if(this.inputBuffer.framecount()!==request.x.length||this.outputBuffer.framecount()!==request.nout)throw Error('Native glove buffers did not resize');
        this.inputBuffer.poke(1,0,request.x);this.operation={kind:'predictpoint',request:request,deadline:new Date().getTime()+3000};
        this.inferObject.message('predictpoint',this.names.input,this.names.output);
    };
    Bridge.prototype.receive=function(lane,args){
        if(this.disposed||this.fault||!args.length)return;
        try{
            var method=String(args[0]).toLowerCase(),job=this.job;
            if(lane==='infer'){
                if(method==='cols'){this.available=true;this.probeDeadline=0;this.callbacks.status();return;}
                var op=this.operation;if(!op||method!==op.kind)return;this.operation=null;
                if(method==='load'){
                    this.loadedModel=op.request.model;
                    if(op.request.generation===this.generation){
                        // A newer glove frame can replace the one waiting for load.
                        var request=op.request;if(this.pending&&this.pending.model===request.model&&this.pending.generation===request.generation){request=this.pending;this.pending=null;}
                        this.query(request);
                    }
                }else if(method==='predictpoint'&&op.request.generation===this.generation){
                    if(this.outputBuffer.framecount()!==op.request.nout)throw Error('FluCoMa output buffer has the wrong dimension');
                    var values=this.outputBuffer.peek(1,0,op.request.nout);if(typeof values==='number')values=[values];
                    values=GloveNeural.vector(values,op.request.nout);this.callbacks.prediction(values,op.request.tag);
                }
                this.pump();return;
            }
            if(!job)return;
            if((lane==='input'||lane==='output')&&method==='load'&&job.stage==='datasets'){
                if(lane==='input')job.xLoaded=true;else job.yLoaded=true;
                if(job.xLoaded&&job.yLoaded)this.scheduleFit();return;
            }
            if(lane!=='train')return;
            if(method==='fit'&&job.stage==='fit'){
                if(job.cancelled){this.job=null;return;}
                // Max prefixes fit results with both dataset names. Error is last.
                var error=Number(args[args.length-1]);if(!isFinite(error)||error<0)throw Error('FluCoMa returned an invalid fit error');
                job.epoch+=job.chunkNow;job.loss=Math.sqrt(error/job.nout);job.stage='dump';job.deadline=new Date().getTime()+3000;this.trainObject.message('dump');return;
            }
            if(method==='dump'&&job.stage==='dump'){
                if(job.cancelled){this.job=null;return;}
                if(String(args[1])!=='dictionary'||typeof args[2]!=='string')throw Error('Expected a native model dictionary');
                var dict=new Dict(args[2]),model;try{model=JSON.parse(dict.stringify());}finally{dict.freepeer();}
                GloveNeural.validate(model,job.nin,job.nout);
                if(job.loss<job.bestLoss){job.bestLoss=job.loss;job.best=GloveNeural.copy(model);}
                if(job.epoch>=job.epochs||job.bestLoss<0.001){this.job=null;this.callbacks.trained(job);}
                else this.scheduleFit();
            }
        }catch(e){this.fail(e.message);}
    };
    Bridge.prototype.dispose=function(){
        this.disposed=true;this.invalidate();this.cancelTrain();if(this.nextTask)this.nextTask.cancel();
        var peers=[this.xDict,this.yDict,this.modelDict,this.inputBuffer,this.outputBuffer];
        for(var i=0;i<peers.length;i++)if(peers[i])try{peers[i].freepeer();}catch(e){}
    };
    return {Bridge:Bridge};
}());
if(typeof module!=='undefined')module.exports=GloveFluCoMa;

autowatch=0;
inlets=1;
outlets=4;
var ownerPatcher=this.patcher,ready=false,uiReady=false,selfID=0,trackID=0;
var apiCache={},songView=null,devices=[],sessions={},savedSessions={},selected=null,sequence=0,revision=0;
var targetIDs=[],multiBanks={},savedTargets=[],autoTarget=true;
var mode='left',trackMode='this',follow=true,running=false,smoothing=30,epochs=800;
var inputLeft=null,inputRight=null,inputRevision=0,lastPredicted=-1;
var remotes={},remotePool=null,pollTask=null,trainer=null,trainingBank=null,backend=null,runEpoch=0;
var ticks=0,note='Choose a target device',storedPayload='',visibleIDs=[],deviceSignature='',lastUi=0;
var themeColors={};
var modelLibrary=[],modelSelection='',pendingExport=null,pendingImport=null,compatCache={},compatEpoch='';
function theme(name,r,g,b,a){
    if(['live_lcd_bg','live_control_text_bg','live_control_fg','live_lcd_control_fg','live_lcd_control_fg_zombie'].indexOf(String(name))<0)return;
    var values=[r,g,b,a];for(var i=0;i<4;i++)if(!GloveNeural.number(values[i]))return;
    themeColors[String(name)]=values.map(function(v){return GloveNeural.clamp(v,0,1);});
}
function api(id){var a=apiCache[id];if(!a)a=apiCache[id]=new LiveAPI(null,'id '+id);if(!Number(a.id))throw Error('Live object no longer available');return a;}
function one(a,p){var v=a.get(p);return v instanceof Array?v[0]:v;}
function ids(a,p){var v=a.get(p),out=[];if(!(v instanceof Array))v=[v];for(var i=0;i<v.length;i++)if(v[i]!=='id'&&Number(v[i])>0)out.push(String(v[i]));return out;}
function say(s){note=s;}
function containingTrack(id){
    var a=api(id),guard=0;while(a.type!=='Track'&&guard++<24){var parents=ids(a,'canonical_parent');if(!parents.length)break;a=api(parents[0]);}
    if(a.type!=='Track')throw Error('Cannot resolve device track');return Number(a.id);
}
function contextTrack(){
    if(trackMode==='this')return containingTrack(selfID);
    if(!songView)songView=new LiveAPI(null,'live_set view');var id=ids(songView,'selected_track')[0];
    if(!id||api(id).type!=='Track')throw Error('Select a Live track');return Number(id);
}
function discover(){
    var tid=contextTrack(),list=[],seen={};
    function walk(id,prefix,depth,key){
        if(depth>16)return;var children=ids(api(id),'devices');
        for(var i=0;i<children.length;i++){
            var did=children[i];if(seen[did])continue;seen[did]=true;if(Number(did)===selfID)continue;
            var d=api(did),name=String(one(d,'name')),path=key+'/device:'+i;
            list.push({id:did,name:prefix+name,key:path});
            if(Number(one(d,'can_have_chains'))){var chains=ids(d,'chains');for(var j=0;j<chains.length;j++)walk(chains[j],prefix+name+' / '+String(one(api(chains[j]),'name'))+' / ',depth+1,path+'/chain:'+j);}
        }
    }
    var track=api(tid),path=String(track.unquotedpath||track.path||('track:'+tid));
    walk(tid,'',0,path);return {track:tid,list:list};
}
function findDevice(id){for(var i=0;i<devices.length;i++)if(devices[i].id===String(id))return devices[i];return null;}
function current(){if(!selected||!sessions[selected])throw Error('Choose a target device');return sessions[selected];}
function scoped(){
    var out=[];for(var i=0;i<targetIDs.length;i++){var s=sessions[targetIDs[i]];if(s)out=out.concat(s.rows.filter(function(p){return p.scope;}));}return out;
}
function targets(){return targetIDs.map(function(id){return sessions[id];});}
function nativePath(id){var a=api(id);return String(a.unquotedpath||a.path||'');}
function targetStamp(){return targets().map(function(s){return s.path+'|'+s.signature+'|'+schema(s.rows.filter(function(p){return p.scope;}));}).join('||');}
function resolvePath(path){var a=new LiveAPI(null,String(path)),id=String(a.id);if(!Number(a.id)||Number(a.id)===selfID)throw Error('Saved target is missing');return id;}
function validateTopology(){
    if(!targetIDs.length)throw Error('Add at least one target device');
    var all=targets();for(var i=0;i<all.length;i++){
        var s=all[i];if(!s||s.missing)throw Error('A target is missing; restore it or remove it from Targets');
        if(nativePath(s.id)!==s.path)throw Error(s.name+' moved; remove and add it again');
        if(ids(api(s.id),'parameters').join(',')!==s.parameterIDs)throw Error(s.name+' parameter list changed; refresh and review Scope');
    }
}

function input(){
    if(mode==='left'){if(!inputLeft)throw Error('Waiting for GLeft; move the left hand once');return inputLeft.slice();}
    if(mode==='right'){if(!inputRight)throw Error('Waiting for GRight; move the right hand once');return inputRight.slice();}
    if(!inputLeft||!inputRight)throw Error('Both mode requires valid GLeft and GRight frames');return inputLeft.concat(inputRight);
}
function left(){try{inputLeft=GloveNeural.vector(arrayfromargs(arguments),5);inputRevision++;if(running&&mode!=='right')perform();}catch(e){say('Ignored invalid GLeft frame');}}
function right(){try{inputRight=GloveNeural.vector(arrayfromargs(arguments),5);inputRevision++;if(running&&mode!=='left')perform();}catch(e){say('Ignored invalid GRight frame');}}
function nin(){return mode==='both'?10:5;}
function schema(rows){return rows.map(function(p){return p.index+':'+p.name+':'+p.lo+':'+p.hi+':'+p.quantized;}).join('|');}
function bankKey(){return mode+'|'+(targetIDs.length===1?schema(scoped()):targetStamp());}

function bank(){
    if(!targetIDs.length)throw Error('Add a target device');
    var owner=targetIDs.length===1?sessions[targetIDs[0]].banks:multiBanks,k=bankKey();
    if(!owner[k])owner[k]={samples:[],model:null,loss:null,origin:'New training'};return owner[k];
}

function liveValue(id){return remotes[id]?remotes[id].output:Number(one(api(id),'value'));}
function enabled(id){if(remotes[id])return true;return !!Number(one(api(id),'is_enabled'));}
function readRows(id){
    var list=ids(api(id),'parameters'),rows=[];
    for(var i=0;i<list.length;i++){
        var a=api(list[i]),lo=Number(one(a,'min')),hi=Number(one(a,'max')),value=liveValue(list[i]);
        if(!isFinite(lo)||!isFinite(hi)||!isFinite(value))throw Error('Invalid Live parameter range');
        rows.push({id:list[i],index:i,name:String(one(a,'name')),lo:lo,hi:hi,min:lo,max:hi,
            value:value,quantized:!!Number(one(a,'is_quantized')),enabled:enabled(list[i]),scope:targetIDs.length===0&&i>0&&i<=256&&enabled(list[i]),deviceID:String(id),formatted:''});
    }
    return rows;
}
function loadTarget(id,descriptor){
    id=String(id);var d=descriptor||findDevice(id)||sessions[id];if(!d)throw Error('Target is not on the chosen track');
    var rows=readRows(id),signature=schema(rows),s=sessions[id],path=nativePath(id);
    if(!s||s.signature!==signature||s.missing){
        var prior=s;
        s={id:id,name:d.name,key:d.key||path,path:path,signature:signature,rows:rows,banks:{},track:containingTrack(id),missing:false};
        var saved=savedSessions[s.key];
        if(!saved)for(var k in savedSessions)if(savedSessions[k].path===path){saved=savedSessions[k];break;}
        if(saved&&saved.signature===signature&&saved.configs&&saved.configs.length===rows.length){
            for(var i=0;i<rows.length;i++){var c=saved.configs[i];if(c&&isFinite(c.min)&&isFinite(c.max)&&c.min>=rows[i].lo&&c.max<=rows[i].hi&&c.min<=c.max){rows[i].min=c.min;rows[i].max=c.max;rows[i].scope=!!c.scope;}}
            s.banks=saved.banks||{};
        }
        if(prior&&!prior.missing){
            s.banks=prior.banks;
            for(var n=0;n<rows.length;n++)for(var j=0;j<prior.rows.length;j++)if(rows[n].id===prior.rows[j].id&&schema([rows[n]])===schema([prior.rows[j]])){
                rows[n].scope=prior.rows[j].scope;rows[n].min=prior.rows[j].min;rows[n].max=prior.rows[j].max;break;
            }
        }
        sessions[id]=s;
    }else{
        for(var i=0;i<rows.length;i++){s.rows[i].enabled=rows[i].enabled;s.rows[i].value=rows[i].value;}
        s.name=d.name;s.key=d.key||s.key;s.path=path;s.track=containingTrack(id);s.missing=false;
    }
    s.trackName=String(one(api(s.track),'name'));s.parameterIDs=rows.map(function(p){return p.id;}).join(',');return s;
}
function addTarget(id){
    id=String(id);if(targetIDs.indexOf(id)>=0)return;
    if(targetIDs.length>=32)throw Error('At most 32 target devices');
    var s=sessions[id]||loadTarget(id);if(s.missing)throw Error('Target is missing');
    if(scoped().length+s.rows.filter(function(p){return p.scope;}).length>256)throw Error('256 outputs total; reduce this device Scope before adding');
    stopRun();cancelTraining();targetIDs.push(id);autoTarget=false;revision++;
}
function removeTarget(id){
    id=String(id);stopRun();cancelTraining();targetIDs=targetIDs.filter(function(x){return x!==id;});autoTarget=false;revision++;
}
function restoreTargetList(){
    var restored=[];
    for(var i=0;i<savedTargets.length;i++){
        var ref=savedTargets[i],id='missing:'+i;
        try{id=resolvePath(ref.path);var ss=loadTarget(id,{name:ref.name,key:ref.key});if(ss.signature!==ref.signature)throw Error('Target structure differs');}
        catch(e){id='missing:'+i;sessions[id]={id:id,originalName:ref.name,name:ref.name+' [missing / changed]',key:ref.key,path:ref.path,signature:ref.signature,rows:[],banks:{},missing:true};}
        if(restored.indexOf(id)>=0)throw Error('Duplicate saved target');restored.push(id);
    }
    targetIDs=restored;savedTargets=[];
}

function choose(id){
    id=String(id);if(id===selected)return;var s=loadTarget(id);selected=id;visibleIDs=[];revision++;
    if(autoTarget&&!targetIDs.length)addTarget(id);
    say(targetIDs.indexOf(id)>=0?'Editing target Scope':'Browsing device · Add to targets to include it');persist();
}

function refresh(){
    if(!ready)return;
    var result=discover();trackID=result.track;devices=result.list;
    deviceSignature=trackID+':'+devices.map(function(d){return d.id+':'+d.name+':'+d.key;}).join('|');
    if(savedTargets.length)restoreTargetList();
    if(selected&&!findDevice(selected)&&targetIDs.indexOf(selected)<0){selected=null;visibleIDs=[];revision++;}
    if(!devices.length)say('Add an instrument or effect to the browsing track');
}

function followSelection(){
    if(!follow)return;var view=ids(api(trackID),'view')[0];if(!view)return;
    var id=ids(api(view),'selected_device')[0];
    // Clicking this utility itself must not erase the last explicit target.
    if(!id||Number(id)===selfID)return;
    if(findDevice(id)&&id!==selected)choose(id);
}
function validateTarget(){
    if(!ready)throw Error('Load the AMXD in Ableton Live');
    validateTopology();
    if(selected&&sessions[selected]&&!sessions[selected].missing&&ids(api(selected),'parameters').join(',')!==sessions[selected].parameterIDs)
        throw Error('Parameter list changed; refresh and review Scope');
}

function pool(){
    if(remotePool)return remotePool;var p=ownerPatcher.getnamed('remote-pool').subpatcher();remotePool=[];
    for(var i=0;i<256;i++)remotePool.push({remote:p.getnamed('remote-'+i),sender:p.getnamed('sender-'+i),used:false});return remotePool;
}
function releaseAll(){for(var id in remotes){var r=remotes[id];try{r.sender.message('int',0);}catch(e){}r.used=false;}remotes={};}
function stopRun(){running=false;runEpoch++;if(backend)backend.invalidate();releaseAll();lastPredicted=-1;}
function cancelTraining(){if(backend)backend.cancelTrain();trainer=null;trainingBank=null;}
function startRun(){
    validateTarget();var rows=scoped(),b=bank();if(!rows.length||rows.length>256)throw Error('Scope 1–256 parameters');
    GloveNeural.validate(b.model,nin(),rows.length);if(!backend)throw Error("FluCoMa is not ready");backend.check();input();stopRun();
    try{
        var channels=pool();
        for(var i=0;i<rows.length;i++){
            var p=rows[i];if(!enabled(p.id)||p.hi<=p.lo)throw Error(p.name+' is unavailable or controlled elsewhere');
            var channel=channels[i];channel.remote.message('smoothing',smoothing);channel.remote.message('float',liveValue(p.id));
            channel.sender.message('int',Number(p.id));channel.used=true;channel.output=liveValue(p.id);remotes[p.id]=channel;
        }
        running=true;lastPredicted=-1;say('Running · '+rows.length+' learned outputs');perform();
    }catch(e){stopRun();throw e;}
}
function perform(){
    if(!running)return;
    try{
        validateTopology();
        if(inputRevision===lastPredicted)return;
        var rows=scoped(),b=bank();backend.predict(b.model,input(),rows.length,{targets:targetStamp(),mode:mode,epoch:runEpoch,bank:b});lastPredicted=inputRevision;
    }catch(e){stopRun();say('Run stopped: '+e.message);emit();}
}
function applyPrediction(y,tag){
    if(!running||tag.epoch!==runEpoch||tag.targets!==targetStamp()||tag.mode!==mode)return;
    try{
        validateTopology();
        if(!running||tag.bank!==bank())return;
        var rows=scoped();if(y.length!==rows.length)throw Error('Prediction dimensions differ');
        for(var i=0;i<rows.length;i++){
            var p=rows[i],v=GloveNeural.clamp(p.lo+(p.hi-p.lo)*y[i],p.min,p.max);
            if(p.quantized){var low=Math.ceil(p.min),high=Math.floor(p.max);if(low>high)throw Error(p.name+' has no discrete step in range');v=GloveNeural.clamp(Math.round(v),low,high);}
            var r=remotes[p.id];if(!r)throw Error('Remote mapping was released');
            if(Math.abs(r.output-v)>1e-9){r.remote.message('float',v);r.output=v;}
            p.value=v;p.predicted=y[i];
        }
    }catch(e){stopRun();say('Run stopped: '+e.message);emit();}
}
function nativeinput(){if(backend)backend.receive('input',arrayfromargs(arguments));}
function nativeoutput(){if(backend)backend.receive('output',arrayfromargs(arguments));}
function nativetrain(){if(backend)backend.receive('train',arrayfromargs(arguments));}
function nativeinfer(){if(backend)backend.receive('infer',arrayfromargs(arguments));}
function nativeError(message){stopRun();cancelTraining();say('FluCoMa: '+message);emit();}
function nativeTrained(job){
    if(trainer!==job||job.cancelled)return;
    var b=trainingBank;b.model=GloveNeural.copy(job.best);b.loss=job.bestLoss;b.origin='FluCoMa MLP · tanh / linear · SGD';
    trainer=null;trainingBank=null;say('FluCoMa trained · normalized RMSE '+b.loss.toFixed(5)+' · enable Run');persist();revision++;emit();
}
function capture(){
    if(running)throw Error('Turn Run off before setting and capturing an example');
    var rows=scoped();if(!rows.length||rows.length>256)throw Error('Scope 1–256 parameters');
    var x=input(),y=[],b=bank();if(b.samples.length>=512)throw Error('512 examples reached');
    for(var i=0;i<rows.length;i++){
        var p=rows[i];if(!enabled(p.id)||p.hi<=p.lo)throw Error(p.name+' is not writable');
        y.push(GloveNeural.clamp((liveValue(p.id)-p.lo)/(p.hi-p.lo),0,1));
    }
    for(i=0;i<b.samples.length;i++){
        var distance=0;for(var j=0;j<x.length;j++)distance=Math.max(distance,Math.abs(x[j]-b.samples[i].x[j]));
        if(distance<.001)throw Error('This pose is already captured; move fingers or undo that example');
    }
    b.samples.push({x:x,y:y});b.model=null;b.loss=null;b.origin='User training';say('Captured example '+b.samples.length+' · pose and target values');persist();
}
function train(){
    stopRun();var rows=scoped(),b=bank();if(!rows.length||rows.length>256)throw Error('Scope 1–256 parameters');
    if(!backend)throw Error('FluCoMa is not ready');backend.check();
    trainingBank=b;try{trainer=backend.startTrain(b.samples,nin(),rows.length,epochs);}catch(e){trainingBank=null;throw e;}
    say('FluCoMa training · 0 / '+epochs+' epochs');
}
function modelID(){return 'model-'+new Date().getTime()+'-'+Math.floor(Math.random()*1000000000);}
function validateRecord(record){
    if(!record||record.format!=='glove-neural-scope-model'||[1,2].indexOf(record.version)<0)throw Error('Not a Glove Neural Scope model file');
    if(['left','right','both'].indexOf(record.mode)<0||record.inputDimensions!==(record.mode==='both'?10:5))throw Error('Invalid saved hand mode');
    if(typeof record.id!=='string'||!record.id||typeof record.name!=='string'||!record.name.trim()||record.name.length>80||typeof record.deviceSignature!=='string'||typeof record.savedAt!=='string'||!isFinite(Date.parse(record.savedAt)))throw Error('Invalid saved model identity');
    var configs=record.configs;if(!(configs instanceof Array)||configs.length<1||configs.length>256)throw Error('Invalid saved parameter scope');
    if(record.version===2){
        if(!(record.targets instanceof Array)||!record.targets.length||record.targets.length>32)throw Error('Invalid saved target list');
        var paths={};for(var t=0;t<record.targets.length;t++){var d=record.targets[t];if(!d||typeof d.path!=='string'||!d.path||typeof d.name!=='string'||typeof d.signature!=='string'||paths[d.path])throw Error('Invalid saved target identity');paths[d.path]=true;}
    }
    var previous=-1,previousTarget=-1;
    for(var i=0;i<configs.length;i++){
        var p=configs[i],slot=record.version===2&&p?p.target:0;
        if(slot!==Math.floor(slot)||slot<0||slot>=(record.version===2?record.targets.length:1)||slot<previousTarget)throw Error('Invalid saved target slot');
        if(slot!==previousTarget)previous=-1;previousTarget=slot;
        if(!p||p.index!==Math.floor(p.index)||p.index<=previous||typeof p.name!=='string'||typeof p.quantized!=='boolean'||
            !GloveNeural.number(p.lo)||!GloveNeural.number(p.hi)||p.hi<=p.lo||!GloveNeural.number(p.min)||!GloveNeural.number(p.max)||p.min<p.lo||p.max>p.hi||p.min>p.max||
            p.quantized&&Math.ceil(p.min)>Math.floor(p.max))throw Error('Invalid saved parameter range');previous=p.index;
    }
    var b=record.bank;GloveNeural.validate(b&&b.model,record.inputDimensions,configs.length);
    if(!(b.samples instanceof Array)||b.samples.length>512)throw Error('Invalid saved examples');
    for(i=0;i<b.samples.length;i++){
        var sample=b.samples[i];if(!sample)throw Error('Invalid saved example');
        GloveNeural.vector(sample.x,record.inputDimensions);GloveNeural.vector(sample.y,configs.length);
        var xy=sample.x.concat(sample.y);for(var j=0;j<xy.length;j++)if(xy[j]<0||xy[j]>1)throw Error('Saved examples must be normalized');
    }
    if(b.loss!==null&&(!GloveNeural.number(b.loss)||b.loss<0))throw Error('Invalid saved model error');
    if(typeof b.origin!=='string')throw Error('Invalid saved model origin');return record;
}
function findModel(id){for(var i=0;i<modelLibrary.length;i++)if(modelLibrary[i].id===String(id))return modelLibrary[i];throw Error('Choose a saved model');}
function compatibility(record){
    var epoch=mode+':'+revision+':'+Math.floor(ticks/5);if(epoch!==compatEpoch){compatEpoch=epoch;compatCache={};}
    var key='model:'+record.id;if(compatCache[key]===undefined)compatCache[key]=compatibilityUncached(record);return compatCache[key];
}
function compatibilityUncached(record){
    if(record.mode!==mode)return 'Choose '+record.mode+' input first';
    if(record.version===1){
        if(targetIDs.length!==1)return 'Legacy model requires one target';
        var s=sessions[targetIDs[0]];if(!s||s.signature!==record.deviceSignature)return 'Target parameter structure differs';
        for(var i=0;i<record.configs.length;i++){var p=record.configs[i],row=s.rows[p.index];if(!row||schema([row])!==schema([p]))return 'Saved output parameter differs';}return '';
    }
    try{for(var i=0;i<record.targets.length;i++){var ref=record.targets[i],id=resolvePath(ref.path),session=sessions[id];if(session&&session.signature!==ref.signature)return 'Saved target structure differs';}}catch(e){return 'Saved target missing from Live Set';}return '';
}
function recordTargets(){return targets().map(function(s){return {path:s.path,key:s.key,name:s.originalName||s.name,signature:s.signature};});}
function recordConfigs(){return scoped().map(function(p){return {target:targetIDs.indexOf(p.deviceID),index:p.index,name:p.name,lo:p.lo,hi:p.hi,quantized:p.quantized,min:p.min,max:p.max};});}

function recordCurrent(name){
    name=String(name||'').trim();if(!name||name.length>80)throw Error('Enter a model name (1–80 characters)');
    validateTarget();var rows=scoped(),b=bank();GloveNeural.validate(b.model,nin(),rows.length);
    return validateRecord({format:'glove-neural-scope-model',version:2,backend:'FluCoMa',id:modelID(),name:name,savedAt:new Date().toISOString(),
        mode:mode,inputDimensions:nin(),deviceSignature:targetStamp(),targets:recordTargets(),configs:recordConfigs(),
        bank:GloveNeural.copy({model:b.model,samples:b.samples,loss:b.loss,origin:b.origin})});
}

function saveModel(name){
    if(modelLibrary.length>=128)throw Error('128 saved models reached; export a model before removing it');
    var record=recordCurrent(name);modelLibrary.push(record);modelSelection=record.id;
    say('Saved '+record.name+' · save the Live Set, or Export a JSON file');persist();
}
function loadModel(id){
    var record=validateRecord(findModel(id)),reason=compatibilityUncached(record);if(reason)throw Error(reason);
    stopRun();cancelTraining();var resolved=[];
    if(record.version===1){validateTarget();resolved=[sessions[targetIDs[0]]];}
    else for(var t=0;t<record.targets.length;t++){
        var ref=record.targets[t],did=resolvePath(ref.path),rows=readRows(did);
        if(schema(rows)!==ref.signature)throw Error(ref.name+' parameter structure differs');
        resolved.push({id:did,ref:ref,rows:rows});
    }
    for(var i=0;i<record.configs.length;i++){
        var c=record.configs[i],slot=record.version===1?0:c.target,row=resolved[slot].rows[c.index];
        if(!row||schema([row])!==schema([c])||!enabled(row.id))throw Error(c.name+' changed or is controlled elsewhere');
    }
    if(record.version===2){
        for(t=0;t<resolved.length;t++)resolved[t]=loadTarget(resolved[t].id,resolved[t].ref);
        targetIDs=resolved.map(function(s){return s.id;});autoTarget=false;
    }
    for(t=0;t<resolved.length;t++)for(i=0;i<resolved[t].rows.length;i++)resolved[t].rows[i].scope=false;
    for(i=0;i<record.configs.length;i++){var c=record.configs[i],slot=record.version===1?0:c.target,row=resolved[slot].rows[c.index];row.scope=true;row.min=c.min;row.max=c.max;}
    var restored=bank();var b=GloveNeural.copy(record.bank);restored.samples=b.samples;restored.model=b.model;restored.loss=b.loss;restored.origin=b.origin;
    if(targetIDs.indexOf(selected)<0)selected=targetIDs[0];modelSelection=record.id;revision++;
    say('Loaded '+record.name+' · targets, scope and bounds restored · Run off');persist();
}

function deleteModel(id){
    findModel(id);modelLibrary=modelLibrary.filter(function(r){return r.id!==String(id);});
    if(modelSelection===String(id))modelSelection='';say('Saved model removed; active training bank retained');persist();
}
function beginImport(){
    stopRun();cancelTraining();pendingImport={device:selected,revision:revision,mode:mode};outlet(3,'import','bang');say('Choose a saved model JSON file');
}
function beginExport(id){
    pendingExport=GloveNeural.copy(validateRecord(findModel(id)));outlet(3,'export','bang');say('Choose where to export '+pendingExport.name);
}
function dialogcancel(kind){
    if(kind==='export')pendingExport=null;else pendingImport=null;say('Model '+kind+' cancelled');emit();
}
function readmodel(){
    var path=Array.prototype.slice.call(arguments).join(' '),file=null;
    try{
        var request=pendingImport;pendingImport=null;if(!request)throw Error('Use Import to choose a model file');
        if(request.device!==selected||request.revision!==revision||request.mode!==mode)throw Error('Target or input changed during file selection; Import again');
        file=new File(path,'read');if(!file.isopen)throw Error('Could not open model file');
        if(file.eof>33554432)throw Error('Model file exceeds 32 MB');var raw='';
        while(file.position<file.eof){var part=file.readstring(4096);if(!part.length)throw Error('Incomplete model file');raw+=part;}file.close();file=null;
        var document=JSON.parse(raw),record;
        if(document.format==='glove-neural-scope-model')record=validateRecord(document);
        else if(document.layers){
            validateTarget();record=recordCurrentFromImported(GloveNeural.fromFluCoMa(document,nin(),scoped().length),path);
        }else if(document.fits&&document.fits.input_regressor){
            validateTarget();var b=GloveNeural.fromDataKnot(document,nin(),scoped().length);
            record=recordCurrentFromImported(b,path);say('Imported Data Knot outputs in current scoped table order');
        }else throw Error('Not a supported neural model JSON');
        record=GloveNeural.copy(record);record.id=modelID();if(modelLibrary.length>=128)throw Error('128 saved models reached');
        modelLibrary.push(record);modelSelection=record.id;persist();
        var reason=compatibility(record);
        if(reason)say('Imported '+record.name+' · '+reason);else loadModel(record.id);
    }catch(e){say('Import failed: '+e.message);}finally{if(file)file.close();}emit();
}
function recordCurrentFromImported(b,path){
    var name=path.substring(path.lastIndexOf('/')+1).replace(/\.json$/i,'').substring(0,80)||'Imported model';
    return validateRecord({format:'glove-neural-scope-model',version:2,id:modelID(),name:name,savedAt:new Date().toISOString(),mode:mode,inputDimensions:nin(),deviceSignature:targetStamp(),targets:recordTargets(),configs:recordConfigs(),bank:b});
}

function writemodel(){
    var path=Array.prototype.slice.call(arguments).join(' '),file=null;
    try{
        var record=pendingExport;pendingExport=null;if(!record)throw Error('Use Export to choose a saved model');
        if(!/\.json$/i.test(path))path+='.json';
        // ASCII JSON preserves Unicode names with Max's legacy File encoding.
        var raw=JSON.stringify(validateRecord(record),null,2).replace(/[\u007f-\uffff]/g,function(c){return '\\u'+('0000'+c.charCodeAt(0).toString(16)).slice(-4);});
        file=new File(path,'write');if(!file.isopen)throw Error('Could not write model file');file.eof=0;
        for(var i=0;i<raw.length;i+=4096)file.writestring(raw.substring(i,i+4096));file.eof=file.position;file.close();file=null;
        say('Exported '+record.name+' · '+path);
    }catch(e){say('Export failed: '+e.message);}finally{if(file)file.close();}emit();
}
function setScope(action,id,value){
    stopRun();cancelTraining();var rows=current().rows,i;
    if(action==='single'){
        var p=null;for(i=0;i<rows.length;i++)if(rows[i].id===String(id))p=rows[i];
        if(!p)throw Error('Parameter no longer exists');if(value&&!enabled(p.id))throw Error('Parameter controlled elsewhere');
        if(value&&!p.scope&&(targetIDs.indexOf(selected)>=0?scoped().length:rows.filter(function(p){return p.scope;}).length)>=256)throw Error('256 outputs reached');p.scope=!!value;
    }else{
        var available=256-(targetIDs.indexOf(selected)>=0?scoped().length-rows.filter(function(p){return p.scope;}).length:0);
        var count=0;for(i=0;i<rows.length;i++){rows[i].scope=action!=='none'&&i>0&&enabled(rows[i].id)&&rows[i].hi>rows[i].lo&&count<Math.min(action==='ten'?10:256,available);if(rows[i].scope)count++;}
    }
    say('Scope changed · independent model bank selected');revision++;persist();
}
function editRow(id,field,value){
    stopRun();var rows=current().rows,p=null;for(var i=0;i<rows.length;i++)if(rows[i].id===String(id))p=rows[i];if(!p)throw Error('Parameter changed');
    var v=Number(value);if(!isFinite(v)||v<p.lo||v>p.hi)throw Error('Enter a value within the native parameter range');
    if(field==='min'||field==='max'){
        if(field==='min'&&v>p.max||field==='max'&&v<p.min)throw Error('Min must be ≤ Max');
        var lo=field==='min'?v:p.min,hi=field==='max'?v:p.max;
        if(p.quantized&&Math.ceil(lo)>Math.floor(hi))throw Error('Range must include a valid discrete step');p[field]=v;persist();
    }else if(field==='value'){
        if(!enabled(id))throw Error('Parameter controlled elsewhere');if(p.quantized)v=Math.round(v);
        api(id).set('value',v);p.value=Number(one(api(id),'value'));
    }else throw Error('Unknown parameter field');revision++;
}
function pollRows(){
    if(!selected)return;var rows=current().rows,visible={};for(var i=0;i<visibleIDs.length;i++)visible[visibleIDs[i]]=true;
    for(i=0;i<rows.length;i++)if(visible[rows[i].id]){
        var p=rows[i];try{p.enabled=enabled(p.id);p.value=liveValue(p.id);p.formatted=String(api(p.id).call('str_for_value',p.value));}catch(e){p.enabled=false;}
    }
}
function tick(){
    if(!ready)return;try{
        if(backend)backend.watch();ticks++;if(ticks%5===0||contextTrack()!==trackID)refresh();followSelection();
        var tracked=targetIDs.slice();if(selected&&tracked.indexOf(selected)<0)tracked.push(selected);
        for(var i=0;i<tracked.length;i++){
            var id=tracked[i],s=sessions[id];if(!s||s.missing)continue;
            try{
                if(containingTrack(id)!==s.track||nativePath(id)!==s.path)throw Error('Target moved');
                if(ids(api(id),'parameters').join(',')!==s.parameterIDs){stopRun();cancelTraining();loadTarget(id);revision++;say('Parameter list changed · review all target scopes');}
            }catch(e){stopRun();cancelTraining();s.missing=true;say(s.name+' unavailable · restore or remove the target');revision++;}
        }
        pollRows();if(trainer)say('FluCoMa training · '+trainer.epoch+' / '+trainer.epochs+' epochs'+(GloveNeural.number(trainer.loss)?' · RMSE '+trainer.loss.toFixed(5):''));emit();
    }catch(e){stopRun();cancelTraining();say('Waiting for target: '+e.message);emit();}
}

function chunks(s){var out=[];for(var i=0;i<s.length;i+=4096)out.push(s.substring(i,i+4096));return out.length?out:[''];}
function snapshotSession(s){return {path:s.path,name:s.name,signature:s.signature,configs:s.rows.map(function(p){return {scope:p.scope,min:p.min,max:p.max};}),banks:s.banks};}

function persist(){
    for(var id in sessions){var s=sessions[id];if(!s.missing)savedSessions[s.key]=snapshotSession(s);}
    storedPayload=encodeURIComponent(JSON.stringify({version:4,targets:recordTargets(),multiBanks:multiBanks,mode:mode,trackMode:trackMode,follow:follow,smoothing:smoothing,epochs:epochs,sessions:savedSessions,models:modelLibrary,modelSelection:modelSelection}));
    var a=chunks(storedPayload);if(a.length===1)outlet(2,a[0]);else outlet.apply(this,[2,'list'].concat(a));
}
function restore(){
    var encoded=Array.prototype.slice.call(arguments).join('');if(!encoded||encoded===storedPayload)return;
    try{
        var d=JSON.parse(decodeURIComponent(encoded));if(d.version!==1&&d.version!==2&&d.version!==3&&d.version!==4)throw Error('Unknown saved state version');
        if(['left','right','both'].indexOf(d.mode)<0||['this','selected'].indexOf(d.trackMode)<0)throw Error('Invalid saved input mode');
        if(d.version===4){
            if(!(d.targets instanceof Array)||d.targets.length>32||!d.multiBanks||typeof d.multiBanks!=='object'||d.multiBanks instanceof Array)throw Error('Invalid saved target set');
            var paths={};for(var t=0;t<d.targets.length;t++){var ref=d.targets[t];if(!ref||typeof ref.path!=='string'||!ref.path||typeof ref.name!=='string'||typeof ref.signature!=='string'||paths[ref.path])throw Error('Invalid saved target identity');paths[ref.path]=true;}
        }
        var models=d.version>=2?d.models:[];if(!(models instanceof Array)||models.length>128)throw Error('Invalid saved model library');
        var seen={};for(var k=0;k<models.length;k++){validateRecord(models[k]);if(seen[models[k].id])throw Error('Duplicate saved model identity');seen[models[k].id]=true;}
        stopRun();cancelTraining();storedPayload=encoded;savedSessions=d.sessions||{};sessions={};selected=null;targetIDs=[];savedTargets=d.version===4?d.targets||[]:[];multiBanks=d.version===4?d.multiBanks||{}:{};autoTarget=d.version!==4;
        modelLibrary=GloveNeural.copy(models);modelSelection=seen[d.modelSelection]?d.modelSelection:'';
        mode=d.mode;trackMode=d.trackMode;follow=!!d.follow;smoothing=GloveNeural.clamp(Number(d.smoothing)||0,0,500);epochs=GloveNeural.clamp(Number(d.epochs)||800,50,5000);
        if(ready){refresh();followSelection();}say('Training banks restored · Run remains off');revision++;emit();
    }catch(e){say('Saved state error: '+e.message);emit();}
}
function directory(){var p=ownerPatcher.filepath||'',slash=p.lastIndexOf('/');return slash>=0?p.substring(0,slash+1):'';}
function loadbang(){outlet(0,'readfile',directory()+'neural_scope_ui.html');}
function bang(){
    try{
        var self=new LiveAPI(null,'this_device');selfID=Number(self.id);if(!selfID)throw Error('Load this AMXD in Ableton Live');
        ready=true;refresh();followSelection();if(!selected&&targetIDs.length)selected=targetIDs[0];
        if(pollTask)pollTask.cancel();pollTask=new Task(tick,this);pollTask.interval=200;pollTask.repeat();
        if(!backend){backend=new GloveFluCoMa.Bridge(ownerPatcher,String(jsarguments[1]),{prediction:applyPrediction,trained:nativeTrained,error:nativeError,status:function(){emit();}});backend.initialize();}
        emit();
    }catch(e){ready=false;say(e.message);emit();}
}
function command(encoded){
    try{
        var m=JSON.parse(decodeURIComponent(String(encoded)));
        if(m.op==='hello'){uiReady=true;emit();return;}
        if(m.op==='open'){outlet(1,'open');return;}
        if(m.op==='visible'){visibleIDs=m.ids||[];return;}
        if(m.op==='stop'){stopRun();cancelTraining();say('Stopped · target parameters released');emit();return;}
        if(m.op==='mode'){
            if(['left','right','both'].indexOf(m.value)<0)throw Error('Choose Left, Right or Both');stopRun();cancelTraining();mode=m.value;revision++;say('Input mode changed · independent model bank selected');persist();
        }else if(m.op==='trackMode'){
            if(['this','selected'].indexOf(m.value)<0)throw Error('Choose This track or Selected track');trackMode=m.value;selected=null;refresh();followSelection();persist();revision++;
        }else if(m.op==='follow'){follow=!!m.value;if(ready)followSelection();persist();}
        else if(m.op==='smooth'){var ms=Number(m.value);if(!isFinite(ms)||ms<0||ms>500)throw Error('Smoothing must be 0–500 ms');smoothing=ms;for(var id in remotes)remotes[id].remote.message('smoothing',ms);persist();}
        else if(m.op==='epochs'){var e=Number(m.value);if(!isFinite(e)||e<50||e>5000)throw Error('Epochs must be 50–5000');epochs=Math.floor(e);persist();}
        else {
            if(!ready)throw Error('Load the AMXD in Ableton Live');
            if(['pickModel','deleteModel','importModel','exportModel'].indexOf(m.op)>=0){
                if(String(m.device)!==String(selected)||Number(m.revision)!==revision)throw Error('Target changed; use the refreshed interface');
                if(m.op==='pickModel'){findModel(m.id);modelSelection=String(m.id);persist();}
                else if(m.op==='deleteModel')deleteModel(m.id);
                else if(m.op==='importModel')beginImport();
                else beginExport(m.id);
            }else if(m.op==='toggleTarget'){
                if(String(m.device)!==String(selected)||Number(m.revision)!==revision)throw Error('View changed; use the refreshed interface');
                if(targetIDs.indexOf(String(m.id))>=0)removeTarget(m.id);else addTarget(m.id);say('Targets changed · combined training bank selected');persist();
            }else if(m.op==='select'){refresh();follow=false;choose(m.id);persist();}
            else if(m.op==='refresh'){refresh();followSelection();}
            else{
                if(String(m.device)!==String(selected)||Number(m.revision)!==revision)throw Error('Target/scope changed; use the refreshed interface');
                if(['scope','scopeAll','edit','loadModel'].indexOf(m.op)<0)validateTarget();
                if(trainer&&['train','stop'].indexOf(m.op)<0)throw Error('Cancel training before changing examples or parameters');
                if(m.op==='scope')setScope('single',m.id,m.value);
                else if(m.op==='scopeAll')setScope(m.value);
                else if(m.op==='edit')editRow(m.id,m.field,m.value);
                else if(m.op==='capture')capture();
                else if(m.op==='train'){if(trainer){cancelTraining();say('Training cancelled; previous model retained');}else train();}
                else if(m.op==='run'){if(running){stopRun();say('Run off · targets released');}else startRun();}
                else if(m.op==='undoSample'){stopRun();var b=bank();b.samples.pop();b.model=null;b.loss=null;say('Last example removed; re-train');persist();}
                else if(m.op==='clear'){stopRun();var cleared=bank();cleared.samples=[];cleared.model=null;cleared.loss=null;cleared.origin='New training';say('Current training bank cleared');persist();}
                else if(m.op==='saveModel')saveModel(m.name);
                else if(m.op==='loadModel')loadModel(m.id);
                else throw Error('Unknown command');
            }
        }
    }catch(e){say(e.message);}
    emit();
}
function emit(){
    if(!uiReady)return;var s=selected?sessions[selected]:null,b=targetIDs.length?bank():null,rows=s?s.rows:[],all=scoped();
    for(var id in sessions)for(var j=0;j<sessions[id].rows.length;j++)sessions[id].rows[j].output=null;
    for(var i=0;i<all.length;i++)all[i].output=i+1;
    var state={ready:ready,revision:revision,selected:selected,devices:devices,mode:mode,trackMode:trackMode,follow:follow,
        targets:targets().map(function(s){return {id:s.id,name:(s.missing?'':s.trackName+' / ')+s.name,path:s.path,missing:!!s.missing,outputs:s.rows.filter(function(p){return p.scope;}).length};}),
        running:running,smoothing:smoothing,epochs:epochs,training:!!trainer,epoch:trainer?trainer.epoch:0,engine:'FluCoMa',engineReady:!!(backend&&backend.available&&!backend.fault),
        note:note,left:inputLeft,right:inputRight,rows:rows,samples:b?b.samples.length:0,trained:!!(b&&b.model),
        loss:b?b.loss:null,origin:b?b.origin:'No model',outputs:all.length,trackName:trackName(),colors:themeColors,
        modelSelection:modelSelection,models:modelLibrary.map(function(r){var reason=compatibility(r);return {id:r.id,name:r.name,mode:r.mode,outputs:r.configs.length,devices:r.version===2?r.targets.length:1,savedAt:r.savedAt,compatible:!reason,reason:reason};})};
    var a=chunks(encodeURIComponent(JSON.stringify(state))),seq=++sequence;for(i=0;i<a.length;i++)outlet(0,'statepacket',seq,i,a.length,a[i]);
}

function trackName(){try{return ready&&trackID?String(one(api(trackID),'name')):'';}catch(e){return '';}}
function notifydeleted(){if(pollTask)pollTask.cancel();cancelTraining();stopRun();if(backend)backend.dispose();}
