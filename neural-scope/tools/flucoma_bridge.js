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
