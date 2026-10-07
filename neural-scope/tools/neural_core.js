// ES5 neural regression, compatible with the supplied Data Knot layer layout.
var GloveNeural = (function () {
    function copy(v) { return JSON.parse(JSON.stringify(v)); }
    function number(v) { return typeof v === 'number' && isFinite(v); }
    function clamp(v, lo, hi) { return Math.max(lo,Math.min(hi,v)); }
    function vector(a,n) {
        if (!a || a.length!==n) throw Error('Expected '+n+' numeric values');
        var out=[];for(var i=0;i<n;i++) {if(!number(a[i]))throw Error('Non-finite input');out.push(clamp(a[i],0,1));}return out;
    }
    function tanh(x) { x=clamp(x,-20,20);var e=Math.exp(2*x);return (e-1)/(e+1); }
    function validate(model,nin,nout) {
        if(!model||!model.layers||model.layers.length<1||model.layers.length>8)throw Error('Invalid neural model');
        var n=nin;
        for(var k=0;k<model.layers.length;k++) {
            var l=model.layers[k];
            if(l.rows!==n||l.cols<1||l.cols>256||l.cols!==Math.floor(l.cols)||
                [0,3].indexOf(l.activation)<0||!l.biases||l.biases.length!==l.cols||!l.weights||l.weights.length!==l.rows)
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
    function forward(model,x) {
        var states=[x.slice()],a=x.slice();
        for(var k=0;k<model.layers.length;k++) {
            var l=model.layers[k],next=[];
            for(var j=0;j<l.cols;j++) {
                var z=l.biases[j];for(var i=0;i<l.rows;i++)z+=a[i]*l.weights[i][j];
                var v=l.activation===3?tanh(z):z;if(!number(v))throw Error('Neural output is not finite');next.push(v);
            }
            a=next;states.push(a);
        }
        return states;
    }
    function predict(model,x) {var a=forward(model,x);return a[a.length-1].map(function(v){return clamp(v,0,1);});}
    function rng(seed) {var s=(seed||2437)>>>0;return function(){s^=s<<13;s^=s>>>17;s^=s<<5;return (s>>>0)/4294967296;};}
    function create(nin,nout,seed) {
        var random=rng(seed),sizes=[nin,16,nout],layers=[];
        for(var k=0;k<2;k++) {
            var rows=sizes[k],cols=sizes[k+1],scale=Math.sqrt(6/(rows+cols)),w=[],b=[];
            for(var i=0;i<rows;i++){w[i]=[];for(var j=0;j<cols;j++)w[i][j]=(random()*2-1)*scale;}
            for(j=0;j<cols;j++)b[j]=0;
            layers.push({rows:rows,cols:cols,weights:w,biases:b,activation:k===0?3:0});
        }
        return {layers:layers};
    }
    function zeros(model) {return model.layers.map(function(l){return {w:l.weights.map(function(r){return r.map(function(){return 0;});}),b:l.biases.map(function(){return 0;})};});}
    function Trainer(samples,nin,nout,epochs) {
        if(samples.length<2||samples.length>512)throw Error('Capture 2–512 different poses before training');
        this.samples=copy(samples);this.nin=nin;this.nout=nout;
        for(var i=0;i<samples.length;i++){vector(samples[i].x,nin);vector(samples[i].y,nout);}
        this.model=create(nin,nout,5249);this.m=zeros(this.model);this.v=zeros(this.model);
        this.epochs=Math.floor(clamp(epochs||800,50,5000));this.epoch=0;this.position=0;this.step=0;
        this.random=rng(2153);this.order=[];for(i=0;i<samples.length;i++)this.order.push(i);
        this.best=copy(this.model);this.bestLoss=Infinity;this.loss=Infinity;this.done=false;
    }
    Trainer.prototype.shuffle=function(){for(var i=this.order.length-1;i>0;i--){var j=Math.floor(this.random()*(i+1)),t=this.order[i];this.order[i]=this.order[j];this.order[j]=t;}};
    Trainer.prototype.sample=function(s) {
        var states=forward(this.model,s.x),last=states[states.length-1],delta=[],grads=[],k,i,j;
        for(j=0;j<this.nout;j++)delta[j]=2*(last[j]-s.y[j])/this.nout;
        for(k=this.model.layers.length-1;k>=0;k--) {
            var l=this.model.layers[k],input=states[k],output=states[k+1],d=[];
            for(j=0;j<l.cols;j++)d[j]=delta[j]*(l.activation===3?1-output[j]*output[j]:1);
            var prev=[];for(i=0;i<l.rows;i++){prev[i]=0;for(j=0;j<l.cols;j++)prev[i]+=l.weights[i][j]*d[j];}
            grads[k]={d:d,input:input};delta=prev;
        }
        this.step++;var b1=.9,b2=.999,correction1=1-Math.pow(b1,this.step),correction2=1-Math.pow(b2,this.step),rate=.01;
        for(k=0;k<this.model.layers.length;k++) {
            l=this.model.layers[k];var m=this.m[k],v=this.v[k],g=grads[k];
            for(j=0;j<l.cols;j++) {
                var db=clamp(g.d[j],-5,5);m.b[j]=b1*m.b[j]+(1-b1)*db;v.b[j]=b2*v.b[j]+(1-b2)*db*db;
                l.biases[j]-=rate*(m.b[j]/correction1)/(Math.sqrt(v.b[j]/correction2)+1e-8);
                for(i=0;i<l.rows;i++) {
                    var dw=clamp(g.input[i]*g.d[j],-5,5);m.w[i][j]=b1*m.w[i][j]+(1-b1)*dw;v.w[i][j]=b2*v.w[i][j]+(1-b2)*dw*dw;
                    l.weights[i][j]-=rate*(m.w[i][j]/correction1)/(Math.sqrt(v.w[i][j]/correction2)+1e-8);
                }
            }
        }
    };
    Trainer.prototype.measure=function(){
        var sum=0;
        for(var i=0;i<this.samples.length;i++){
            var a=forward(this.model,this.samples[i].x),y=a[a.length-1];
            for(var j=0;j<this.nout;j++)sum+=Math.pow(y[j]-this.samples[i].y[j],2);
        }
        this.loss=Math.sqrt(sum/(this.samples.length*this.nout));
        if(this.loss<this.bestLoss){this.bestLoss=this.loss;this.best=copy(this.model);}
    };
    // One sample per call; the Max adapter budgets chunks and yields to its scheduler.
    Trainer.prototype.advance=function(){
        if(this.done)return true;
        if(this.position===0)this.shuffle();
        this.sample(this.samples[this.order[this.position++]]);
        if(this.position===this.samples.length){
            this.position=0;this.epoch++;
            if(this.epoch%10===0||this.epoch===this.epochs)this.measure();
            if(this.epoch>=this.epochs||this.bestLoss<.001){this.model=copy(this.best);this.loss=this.bestLoss;this.done=true;}
        }
        return this.done;
    };
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
    return {copy:copy,number:number,clamp:clamp,vector:vector,validate:validate,
        forward:forward,predict:predict,Trainer:Trainer,fromDataKnot:fromDataKnot};
}());
if(typeof module!=='undefined')module.exports=GloveNeural;
