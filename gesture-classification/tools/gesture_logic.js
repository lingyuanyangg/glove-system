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
