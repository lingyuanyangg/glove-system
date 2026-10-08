autowatch=0;
inlets=1;
outlets=4;
var ownerPatcher=this.patcher,ready=false,uiReady=false,selfID=0,trackID=0;
var apiCache={},songView=null,devices=[],sessions={},savedSessions={},selected=null,sequence=0,revision=0;
var mode='left',trackMode='this',follow=true,running=false,smoothing=30,epochs=800;
var inputLeft=null,inputRight=null,inputRevision=0,lastPredicted=-1;
var remotes={},remotePool=null,pollTask=null,trainer=null,trainingBank=null,backend=null,runEpoch=0;
var ticks=0,note='Choose a target device',storedPayload='',visibleIDs=[],deviceSignature='',lastUi=0;
var themeColors={};
var modelLibrary=[],modelSelection='',pendingExport=null,pendingImport=null;
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
function scoped(){var s=current();return s.rows.filter(function(p){return p.scope;});}
function input(){
    if(mode==='left'){if(!inputLeft)throw Error('Waiting for GLeft; move the left hand once');return inputLeft.slice();}
    if(mode==='right'){if(!inputRight)throw Error('Waiting for GRight; move the right hand once');return inputRight.slice();}
    if(!inputLeft||!inputRight)throw Error('Both mode requires valid GLeft and GRight frames');return inputLeft.concat(inputRight);
}
function left(){try{inputLeft=GloveNeural.vector(arrayfromargs(arguments),5);inputRevision++;if(running&&mode!=='right')perform();}catch(e){say('Ignored invalid GLeft frame');}}
function right(){try{inputRight=GloveNeural.vector(arrayfromargs(arguments),5);inputRevision++;if(running&&mode!=='left')perform();}catch(e){say('Ignored invalid GRight frame');}}
function nin(){return mode==='both'?10:5;}
function schema(rows){return rows.map(function(p){return p.index+':'+p.name+':'+p.lo+':'+p.hi+':'+p.quantized;}).join('|');}
function bankKey(){return mode+'|'+schema(scoped());}
function bank(){var s=current(),k=bankKey();if(!s.banks[k])s.banks[k]={samples:[],model:null,loss:null,origin:'New training'};return s.banks[k];}
function liveValue(id){return remotes[id]?remotes[id].output:Number(one(api(id),'value'));}
function enabled(id){if(remotes[id])return true;return !!Number(one(api(id),'is_enabled'));}
function readRows(id){
    var list=ids(api(id),'parameters'),rows=[];
    for(var i=0;i<list.length;i++){
        var a=api(list[i]),lo=Number(one(a,'min')),hi=Number(one(a,'max')),value=liveValue(list[i]);
        if(!isFinite(lo)||!isFinite(hi)||!isFinite(value))throw Error('Invalid Live parameter range');
        rows.push({id:list[i],index:i,name:String(one(a,'name')),lo:lo,hi:hi,min:lo,max:hi,
            value:value,quantized:!!Number(one(a,'is_quantized')),enabled:enabled(list[i]),scope:i>0&&i<=256&&enabled(list[i]),formatted:''});
    }
    return rows;
}
function loadTarget(id){
    id=String(id);var d=findDevice(id);if(!d)throw Error('Target is not on the chosen track');
    var rows=readRows(id),signature=schema(rows),s=sessions[id];
    if(!s||s.signature!==signature){
        s={id:id,name:d.name,key:d.key,signature:signature,rows:rows,banks:{}};
        var saved=savedSessions[d.key];
        if(saved&&saved.signature===signature&&saved.configs&&saved.configs.length===rows.length){
            for(var i=0;i<rows.length;i++){
                var c=saved.configs[i];
                if(c&&isFinite(c.min)&&isFinite(c.max)&&c.min>=rows[i].lo&&c.max<=rows[i].hi&&c.min<=c.max){rows[i].min=c.min;rows[i].max=c.max;rows[i].scope=!!c.scope;}
            }
            // Stored model dimensions/values are validated again when used.
            s.banks=saved.banks||{};
        }
        sessions[id]=s;
    }else{
        for(i=0;i<rows.length;i++){s.rows[i].enabled=rows[i].enabled;s.rows[i].value=rows[i].value;}
        s.key=d.key;s.name=d.name;
    }
    selected=id;s.parameterIDs=rows.map(function(p){return p.id;}).join(',');
    if(scoped().length>256){for(i=0;i<s.rows.length;i++)s.rows[i].scope=false;say('Scope limited to 256 outputs; choose parameters again');}
    revision++;
}
function choose(id){if(String(id)===selected)return;stopRun();cancelTraining();loadTarget(id);visibleIDs=[];say('Target selected · capture gestures and sounds');persist();}
function refresh(){
    if(!ready)return;
    var result=discover(),oldTrack=trackID;trackID=result.track;devices=result.list;
    deviceSignature=trackID+':'+devices.map(function(d){return d.id+':'+d.name+':'+d.key;}).join('|');
    for(var i=0;i<devices.length;i++)if(sessions[devices[i].id]){sessions[devices[i].id].key=devices[i].key;sessions[devices[i].id].name=devices[i].name;}
    if(selected&&(!findDevice(selected)||oldTrack&&oldTrack!==trackID)){
        stopRun();cancelTraining();selected=null;say('Track or target changed · choose a device');revision++;
    }
    if(!devices.length)say('Add an instrument or effect to the chosen track');
}
function followSelection(){
    if(!follow)return;var view=ids(api(trackID),'view')[0];if(!view)return;
    var id=ids(api(view),'selected_device')[0];
    // Clicking this utility itself must not erase the last explicit target.
    if(!id||Number(id)===selfID)return;
    if(findDevice(id)&&id!==selected)choose(id);
}
function validateTarget(){
    if(!ready)throw Error('Load the AMXD in Ableton Live');refresh();var s=current();
    if(containingTrack(s.id)!==contextTrack())throw Error('Target moved to another track');
    var list=ids(api(s.id),'parameters').join(',');
    if(list!==s.parameterIDs){stopRun();cancelTraining();loadTarget(s.id);throw Error('Parameter list changed; review scope and re-train');}
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
        var s=current();
        if(contextTrack()!==trackID||containingTrack(s.id)!==trackID||ids(api(s.id),'parameters').join(',')!==s.parameterIDs){stopRun();say('Target topology changed · Run stopped');return;}
        if(inputRevision===lastPredicted)return;
        var rows=scoped(),b=bank();backend.predict(b.model,input(),rows.length,{device:selected,revision:revision,mode:mode,epoch:runEpoch,bank:b});lastPredicted=inputRevision;
    }catch(e){stopRun();say('Run stopped: '+e.message);emit();}
}
function applyPrediction(y,tag){
    if(!running||tag.epoch!==runEpoch||tag.device!==selected||tag.revision!==revision||tag.mode!==mode)return;
    try{
        var session=current();if(contextTrack()!==trackID||containingTrack(session.id)!==trackID||ids(api(session.id),'parameters').join(',')!==session.parameterIDs){stopRun();say('Target topology changed · Run stopped');return;}
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
    if(!record||record.format!=='glove-neural-scope-model'||record.version!==1)throw Error('Not a Glove Neural Scope model file');
    if(['left','right','both'].indexOf(record.mode)<0||record.inputDimensions!==(record.mode==='both'?10:5))throw Error('Invalid saved hand mode');
    if(typeof record.id!=='string'||!record.id||typeof record.name!=='string'||!record.name.trim()||record.name.length>80||typeof record.deviceSignature!=='string'||typeof record.savedAt!=='string'||!isFinite(Date.parse(record.savedAt)))throw Error('Invalid saved model identity');
    var configs=record.configs;if(!(configs instanceof Array)||configs.length<1||configs.length>256)throw Error('Invalid saved parameter scope');
    var previous=-1;
    for(var i=0;i<configs.length;i++){
        var p=configs[i];
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
    if(record.mode!==mode)return 'Choose '+record.mode+' input first';
    if(!selected||!sessions[selected])return 'Choose a target device';
    var s=current();if(record.deviceSignature!==s.signature)return 'Target parameter structure differs';
    for(var i=0;i<record.configs.length;i++){
        var p=record.configs[i],row=s.rows[p.index];
        if(!row||schema([row])!==schema([p]))return 'Saved output parameter differs';
    }return '';
}
function recordCurrent(name){
    name=String(name||'').trim();if(!name||name.length>80)throw Error('Enter a model name (1–80 characters)');
    var s=current(),rows=scoped(),b=bank();GloveNeural.validate(b.model,nin(),rows.length);
    return validateRecord({format:'glove-neural-scope-model',version:1,backend:'FluCoMa',id:modelID(),name:name,savedAt:new Date().toISOString(),
        mode:mode,inputDimensions:nin(),deviceSignature:s.signature,
        configs:rows.map(function(p){return {index:p.index,name:p.name,lo:p.lo,hi:p.hi,quantized:p.quantized,min:p.min,max:p.max};}),
        bank:GloveNeural.copy({model:b.model,samples:b.samples,loss:b.loss,origin:b.origin})});
}
function saveModel(name){
    if(modelLibrary.length>=128)throw Error('128 saved models reached; export a model before removing it');
    var record=recordCurrent(name);modelLibrary.push(record);modelSelection=record.id;
    say('Saved '+record.name+' · save the Live Set, or Export a JSON file');persist();
}
function loadModel(id){
    var record=validateRecord(findModel(id)),reason=compatibility(record);if(reason)throw Error(reason);
    stopRun();cancelTraining();validateTarget();reason=compatibility(record);if(reason)throw Error(reason);
    var rows=current().rows,configs=record.configs;
    for(var i=0;i<configs.length;i++)if(!enabled(rows[configs[i].index].id))throw Error(configs[i].name+' is controlled elsewhere');
    for(i=0;i<rows.length;i++)rows[i].scope=false;
    for(i=0;i<configs.length;i++){var row=rows[configs[i].index];row.scope=true;row.min=configs[i].min;row.max=configs[i].max;}
    current().banks[bankKey()]=GloveNeural.copy(record.bank);modelSelection=record.id;revision++;
    say('Loaded '+record.name+' · scope and bounds restored · Run off');persist();
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
    var rows=scoped(),name=path.substring(path.lastIndexOf('/')+1).replace(/\.json$/i,'').substring(0,80)||'Imported model';
    return validateRecord({format:'glove-neural-scope-model',version:1,id:modelID(),name:name,savedAt:new Date().toISOString(),mode:mode,inputDimensions:nin(),deviceSignature:current().signature,
        configs:rows.map(function(p){return {index:p.index,name:p.name,lo:p.lo,hi:p.hi,quantized:p.quantized,min:p.min,max:p.max};}),bank:b});
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
        if(value&&!p.scope&&scoped().length>=256)throw Error('256 outputs reached');p.scope=!!value;
    }else{
        var count=0;for(i=0;i<rows.length;i++){rows[i].scope=action!=='none'&&i>0&&enabled(rows[i].id)&&rows[i].hi>rows[i].lo&&count<(action==='ten'?10:256);if(rows[i].scope)count++;}
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
        if(backend)backend.watch();ticks++;if(ticks%5===0||contextTrack()!==trackID)refresh();
        followSelection();
        if(selected&&ids(api(selected),'parameters').join(',')!==current().parameterIDs){stopRun();cancelTraining();loadTarget(selected);say('Parameter list changed · review scope');}
        pollRows();if(trainer)say('FluCoMa training · '+trainer.epoch+' / '+trainer.epochs+' epochs'+(GloveNeural.number(trainer.loss)?' · RMSE '+trainer.loss.toFixed(5):''));emit();
    }catch(e){stopRun();cancelTraining();say('Waiting for target: '+e.message);emit();}
}
function chunks(s){var out=[];for(var i=0;i<s.length;i+=4096)out.push(s.substring(i,i+4096));return out.length?out:[''];}
function snapshotSession(s){return {signature:s.signature,configs:s.rows.map(function(p){return {scope:p.scope,min:p.min,max:p.max};}),banks:s.banks};}
function persist(){
    for(var id in sessions){var s=sessions[id];savedSessions[s.key]=snapshotSession(s);}
    storedPayload=encodeURIComponent(JSON.stringify({version:3,mode:mode,trackMode:trackMode,follow:follow,smoothing:smoothing,epochs:epochs,sessions:savedSessions,models:modelLibrary,modelSelection:modelSelection}));
    var a=chunks(storedPayload);if(a.length===1)outlet(2,a[0]);else outlet.apply(this,[2,'list'].concat(a));
}
function restore(){
    var encoded=Array.prototype.slice.call(arguments).join('');if(!encoded||encoded===storedPayload)return;
    try{
        var d=JSON.parse(decodeURIComponent(encoded));if(d.version!==1&&d.version!==2&&d.version!==3)throw Error('Unknown saved state version');
        if(['left','right','both'].indexOf(d.mode)<0||['this','selected'].indexOf(d.trackMode)<0)throw Error('Invalid saved input mode');
        var models=d.version>=2?d.models:[];if(!(models instanceof Array)||models.length>128)throw Error('Invalid saved model library');
        var seen={};for(var k=0;k<models.length;k++){validateRecord(models[k]);if(seen[models[k].id])throw Error('Duplicate saved model identity');seen[models[k].id]=true;}
        stopRun();cancelTraining();storedPayload=encoded;savedSessions=d.sessions||{};sessions={};selected=null;
        modelLibrary=GloveNeural.copy(models);modelSelection=seen[d.modelSelection]?d.modelSelection:'';
        mode=d.mode;trackMode=d.trackMode;follow=!!d.follow;smoothing=GloveNeural.clamp(Number(d.smoothing)||0,0,500);epochs=GloveNeural.clamp(Number(d.epochs)||800,50,5000);
        if(ready){refresh();followSelection();}say('Training banks restored · Run remains off');revision++;emit();
    }catch(e){say('Saved state error: '+e.message);}
}
function directory(){var p=ownerPatcher.filepath||'',slash=p.lastIndexOf('/');return slash>=0?p.substring(0,slash+1):'';}
function loadbang(){outlet(0,'readfile',directory()+'neural_scope_ui.html');}
function bang(){
    try{
        var self=new LiveAPI(null,'this_device');selfID=Number(self.id);if(!selfID)throw Error('Load this AMXD in Ableton Live');
        ready=true;refresh();followSelection();
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
            if(['this','selected'].indexOf(m.value)<0)throw Error('Choose This track or Selected track');stopRun();cancelTraining();trackMode=m.value;selected=null;refresh();followSelection();persist();revision++;
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
            }else if(m.op==='select'){refresh();follow=false;choose(m.id);persist();}
            else if(m.op==='refresh'){refresh();followSelection();}
            else{
                if(String(m.device)!==selected||Number(m.revision)!==revision)throw Error('Target/scope changed; use the refreshed interface');
                validateTarget();
                if(trainer&&['train','stop'].indexOf(m.op)<0)throw Error('Cancel training before changing examples or parameters');
                if(m.op==='scope')setScope('single',m.id,m.value);
                else if(m.op==='scopeAll')setScope(m.value);
                else if(m.op==='edit')editRow(m.id,m.field,m.value);
                else if(m.op==='capture')capture();
                else if(m.op==='train'){if(trainer){cancelTraining();say('Training cancelled; previous model retained');}else train();}
                else if(m.op==='run'){if(running){stopRun();say('Run off · targets released');}else startRun();}
                else if(m.op==='undoSample'){stopRun();var b=bank();b.samples.pop();b.model=null;b.loss=null;say('Last example removed; re-train');persist();}
                else if(m.op==='clear'){stopRun();current().banks[bankKey()]={samples:[],model:null,loss:null,origin:'New training'};say('Current training bank cleared');persist();}
                else if(m.op==='saveModel')saveModel(m.name);
                else if(m.op==='loadModel')loadModel(m.id);
                else throw Error('Unknown command');
            }
        }
    }catch(e){say(e.message);}
    emit();
}
function emit(){
    if(!uiReady)return;var s=selected?sessions[selected]:null,b=s?bank():null,rows=s?s.rows:[],order=0;
    for(var i=0;i<rows.length;i++)rows[i].output=rows[i].scope?++order:null;
    var state={ready:ready,revision:revision,selected:selected,devices:devices,mode:mode,trackMode:trackMode,follow:follow,
        running:running,smoothing:smoothing,epochs:epochs,training:!!trainer,epoch:trainer?trainer.epoch:0,engine:'FluCoMa',engineReady:!!(backend&&backend.available&&!backend.fault),
        note:note,left:inputLeft,right:inputRight,rows:rows,samples:b?b.samples.length:0,trained:!!(b&&b.model),
        loss:b?b.loss:null,origin:b?b.origin:'No model',outputs:order,trackName:trackName(),colors:themeColors,
        modelSelection:modelSelection,models:modelLibrary.map(function(r){var reason=compatibility(r);return {id:r.id,name:r.name,mode:r.mode,outputs:r.configs.length,savedAt:r.savedAt,compatible:!reason,reason:reason};})};
    var a=chunks(encodeURIComponent(JSON.stringify(state))),seq=++sequence;
    for(i=0;i<a.length;i++)outlet(0,'statepacket',seq,i,a.length,a[i]);
}
function trackName(){try{return ready&&trackID?String(one(api(trackID),'name')):'';}catch(e){return '';}}
function notifydeleted(){if(pollTask)pollTask.cancel();cancelTraining();stopRun();if(backend)backend.dispose();}
