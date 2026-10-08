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
        var job={epoch:0,epochs:epochs,n:n,classes:classes,loss:null,best:null,bestLoss:Infinity,chunk:Math.max(1,Math.min(10,Math.floor(32768/(a.length*classes.length*16)))),stage:'datasets',xLoaded:false,yLoaded:false,cancelled:false,deadline:new Date().getTime()+10000};this.job=job;
        this.train.message('clear');this.train.message('hiddenlayers',n===10?16:8);this.train.message('activation',3);this.train.message('learnrate',0.01);this.train.message('momentum',0.9);this.train.message('batchsize',4);this.train.message('validation',0);
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
