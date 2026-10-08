// Fast control outlets and separately rate-limited read-only monitors.
autowatch=1;
inlets=1;
outlets=5;
var values=[null,null],pending=[false,false],last=[0,0],states=['WAIT','WAIT'],task=null;
function frame(h,args,fresh){
    var a=arrayfromargs(args);if(a.length!==5)return;
    for(var i=0;i<5;i++)if(typeof a[i]!=='number'||!isFinite(a[i])||a[i]<0||a[i]>1)return;
    var changed=!values[h];for(i=0;!changed&&i<5;i++)if(values[h][i]!==a[i])changed=true;
    values[h]=a;if(fresh)last[h]=new Date().getTime();pending[h]=pending[h]||changed;
    // No UI timer or extra smoothing delays the native mapping signal.
    if(changed)outlet(h,a);
}
function left(){frame(0,arguments,true);}
function right(){frame(1,arguments,true);}
function leftcontrol(){frame(0,arguments,false);}
function rightcontrol(){frame(1,arguments,false);}
function tick(){
    var now=new Date().getTime();
    for(var h=0;h<2;h++){
        if(pending[h]){pending[h]=false;outlet(2+h,values[h]);}
        var s=!last[h]?'WAIT':now-last[h]>1000?'HOLD':'LIVE';
        if(s!==states[h]){states[h]=s;outlet(4,'status',h,s);}
    }
}
function start(){if(task)task.cancel();task=new Task(tick,this);task.interval=33;task.repeat();for(var h=0;h<2;h++)outlet(4,'status',h,states[h]);}
function notifydeleted(){if(task)task.cancel();}
