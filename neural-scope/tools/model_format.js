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
