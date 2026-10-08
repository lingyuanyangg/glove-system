// Feature validation, temporal recognition and native model serialization.
// FluCoMa performs all neural training and prediction.
var Gesture = (function () {
    var labels=['open','fist','index','v','middle','ok','other'];
    var names=['Open hand','Fist','Index','V sign','Middle','OK','Other'];
    function copy(v){return JSON.parse(JSON.stringify(v));}
    function number(v){return typeof v==='number'&&isFinite(v);}
    function vector(v,n){
        if(!(v instanceof Array)||v.length!==n)throw Error('Expected '+n+' finger values');
        var a=[];for(var i=0;i<n;i++){if(!number(v[i])||v[i]<0||v[i]>1)throw Error('Finger values must be finite and normalized 0–1');a.push(v[i]);}return a;
    }
    function dim(mode){if(['left','right','both'].indexOf(mode)<0)throw Error('Invalid hand mode');return mode==='both'?10:5;}
    function model(m,n,expected){
        if(!m||!m.mlp||!(m.mlp.layers instanceof Array)||m.mlp.layers.length<1||m.mlp.layers.length>4||!m.labels||!(m.labels.labels instanceof Array))throw Error('Not a native FluCoMa classifier');
        var list=m.labels.labels,seen={};if(list.length<2||list.length>7||m.labels.rows!==list.length)throw Error('Invalid classifier labels');
        for(var i=0;i<list.length;i++){if(labels.indexOf(list[i])<0||seen[list[i]])throw Error('Unknown or duplicate classifier label');seen[list[i]]=true;}
        if(expected&&(expected.length!==list.length||expected.some(function(s){return !seen[s];})))throw Error('Classifier labels differ from the recorded classes');
        for(var k=0;k<m.mlp.layers.length;k++){
            var l=m.mlp.layers[k];if(l.rows!==n||l.cols<1||l.cols>64||l.cols!==Math.floor(l.cols)||[0,1,2,3].indexOf(l.activation)<0||!(l.weights instanceof Array)||l.weights.length!==n||!(l.biases instanceof Array)||l.biases.length!==l.cols)throw Error('Invalid classifier layer');
            for(i=0;i<n;i++){if(!(l.weights[i] instanceof Array)||l.weights[i].length!==l.cols)throw Error('Invalid weight shape');for(var j=0;j<l.cols;j++)if(!number(l.weights[i][j]))throw Error('Invalid weight');}
            for(j=0;j<l.cols;j++)if(!number(l.biases[j]))throw Error('Invalid bias');n=l.cols;
        }
        if(n!==list.length)throw Error('Classifier output dimensions differ');return m;
    }
    function samples(a,n){
        if(!(a instanceof Array)||a.length>2800)throw Error('Invalid sample bank');
        var counts={};for(var i=0;i<a.length;i++){
            var s=a[i];if(!s||labels.indexOf(s.label)<0||typeof s.trial!=='string'||!s.trial||s.trial.length>100)throw Error('Invalid recorded example');
            vector(s.x,n);counts[s.label]=(counts[s.label]||0)+1;if(counts[s.label]>400)throw Error('400 examples per gesture reached');
        }return a;
    }
    function bank(){return {samples:[],model:null,loss:null,enabled:[true,true,true,true,true,true]};}
    function validateBank(b,n){if(!b||!(b.enabled instanceof Array)||b.enabled.length!==6||b.enabled.some(function(v){return typeof v!=='boolean';}))throw Error('Invalid bank');samples(b.samples,n);if(b.model){var expected=labels.filter(function(s,i){return i===6||b.enabled[i];});model(b.model,n,expected);for(var i=0;i<expected.length;i++){var count=0;for(var j=0;j<b.samples.length;j++)if(b.samples[j].label===expected[i])count++;if(count<20)throw Error('Saved classifier needs examples for every learned label');}}if(b.loss!==null&&(!number(b.loss)||b.loss<0))throw Error('Invalid training loss');return b;}
    function record(r){
        if(!r||r.format!=='glove-gesture-model'||r.version!==1||typeof r.id!=='string'||!r.id||typeof r.name!=='string'||!r.name.trim()||r.name.length>80||typeof r.savedAt!=='string'||!isFinite(Date.parse(r.savedAt)))throw Error('Invalid gesture model file');
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
    return {labels:labels,names:names,copy:copy,number:number,vector:vector,dim:dim,model:model,samples:samples,bank:bank,validateBank:validateBank,record:record,distance:distance,Temporal:Temporal};
}());
if(typeof module!=='undefined')module.exports=Gesture;
