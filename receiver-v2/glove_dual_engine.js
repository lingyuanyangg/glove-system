// Dual receiver for ElastremeSense Manu-5D. Max's classic js runtime (ES5).
// Every consumer receives the same atomic, filtered five-float frame.
autowatch = 1;
inlets = 1;
outlets = 7;
var minimum = [0, 18, 18, 18, 70];
var maximum = [180, 180, 180, 180, 180];
var tau = 8, dead = 0.003, filtering = 1;
var hands = [makehand(), makehand()];
var calibrated = [null, null];
var poses = [makeposes(), makeposes()];
var lastTick = 0;
var runner = new Task(tick, this);
runner.interval = 5;

function makehand() {
    return { ready: false, target: [0,0,0,0,0], value: [0,0,0,0,0],
        sent: [0,0,0,0,0], uiDirty: false, uiAt: 0, received: 0, pendingBus: false, status: "WAIT" };
}
function makeposes() { return { kind: null, recent: [], open: null, fist: null }; }
function finite(v) { return typeof v === "number" && isFinite(v); }
function clip(v) { return Math.max(0, Math.min(1, v)); }
function start() { runner.cancel(); lastTick = Date.now(); runner.repeat(); }
function stop() { runner.cancel(); }
function loadbang() { start(); report(); calreport(); }
function notifydeleted() { stop(); }
function smooth(v) { if (finite(v)) tau = Math.max(0, Math.min(500, v)); }
function deadband(v) { if (finite(v)) dead = Math.max(0, Math.min(0.1, v)); }
function enabled(v) {
    filtering = v ? 1 : 0;
    if (!filtering) {
        for (var h=0; h<2; h++) if (hands[h].ready) {
            hands[h].value = hands[h].target.slice(); emit(h, true);
        }
    }
}
function rawleft() { receive(0, arrayfromargs(arguments), false); }
function rawright() { receive(1, arrayfromargs(arguments), false); }
function normleft() { receive(0, arrayfromargs(arguments), true); }
function normright() { receive(1, arrayfromargs(arguments), true); }
function receive(index, args, normalized) {
    if (args.length !== 5) { outlet(2, "invalid", index); return; }
    var values = [], i, hand = hands[index], now = Date.now();
    for (i=0; i<5; i++) {
        if (!finite(args[i])) { outlet(2, "invalid", index); return; }
    }
    var kind = normalized ? "norm" : "raw", state = poses[index], cal = calibrated[index];
    if (state.kind !== kind) { poses[index] = state = makeposes(); state.kind = kind; }
    state.recent.push({ at: now, values: args.slice() });
    while (state.recent.length && (now-state.recent[0].at>250 || state.recent.length>128)) state.recent.shift();
    for (i=0; i<5; i++) {
        values[i] = clip(cal && cal.kind === kind ?
            0.9 * (args[i]-cal.open[i]) / (cal.fist[i]-cal.open[i]) :
            normalized ? args[i] : (args[i]-minimum[i]) / (maximum[i]-minimum[i]));
    }
    hand.received = now;
    hand.pendingBus = true;
    if (!hand.ready) {
        hand.ready = true; hand.target = values.slice(); hand.value = values.slice();
        emit(index, true);
    } else {
        for (i=0; i<5; i++) {
            // Compare with the last accepted target, never the moving filter state.
            if (!filtering || Math.abs(values[i] - hand.target[i]) >= dead)
                hand.target[i] = values[i];
        }
        if (!filtering || tau === 0) { hand.value = hand.target.slice(); emit(index, false); }
    }
    setstatus(index, "LIVE");
}
function manualleft(i, v) { manual(0, i, v); }
function manualright(i, v) { manual(1, i, v); }
function manual(h, i, v) {
    if (!finite(i) || i !== Math.floor(i) || i<0 || i>4 || !finite(v)) return;
    var hand = hands[h];
    hand.target[i] = clip(v);
    if (!hand.ready) { hand.ready = true; hand.value = hand.target.slice(); emit(h, true); }
    if (!filtering || tau===0) { hand.value=hand.target.slice(); emit(h, false); }
    setstatus(h, "TEST");
}
function tick() { process(Date.now()); }
function process(now) {
    var dt = Math.max(0, now-lastTick); lastTick=now;
    var a = !filtering || tau===0 ? 1 : 1-Math.exp(-dt/tau);
    for (var h=0; h<2; h++) {
        var hand=hands[h]; if (!hand.ready) continue;
        for (var i=0; i<5; i++) {
            hand.value[i] += a*(hand.target[i]-hand.value[i]);
            if (Math.abs(hand.target[i]-hand.value[i])<0.00001) hand.value[i]=hand.target[i];
        }
        emit(h, false);
        draw(h, false, now);
        // Only real valid input refreshes learning/classification consumers.
        // Changed-only UI/OSC outputs remain on outlets 0/1. Fresh stable frames
        // have separate bus outlets 3/4, paired at this same filter tick.
        if (hand.pendingBus) {
            hand.pendingBus=false;
            if(now-hand.received<=100)outlet(3+h,hand.value.slice());
        }
        if (hand.received && now-hand.received>1000 && hand.status!=="TEST") setstatus(h,"HOLD");
    }
}
function emit(h, force) {
    var hand=hands[h], changed=force;
    for (var i=0; i<5; i++) if (Math.abs(hand.value[i]-hand.sent[i])>=0.00001) changed=true;
    if (!changed) return;
    hand.sent=hand.value.slice(); outlet(h, hand.sent);
    hand.uiDirty=true;
    if(force)draw(h,true,Date.now());
}
// Monitor painting is capped independently; control outlets 0/1 stay immediate.
function draw(h, force, now) {
    var hand=hands[h];
    if(!force&&(!hand.uiDirty||now-hand.uiAt<33))return;
    hand.uiDirty=false;hand.uiAt=now;outlet(5+h,hand.value.slice());
}
function setstatus(h, s) {
    if (hands[h].status!==s) { hands[h].status=s; outlet(2,"status",h,s); }
}
function report() {
    for (var h=0; h<2; h++) outlet(2,"status",h,hands[h].status);
}
function lostleft() { lost(0); }
function lostright() { lost(1); }
function lost(h) { hands[h].pendingBus=false;hands[h].received=0;poses[h]=makeposes();setstatus(h,"HOLD"); }
// Re-send current frames when OSC forwarding is enabled or its destination changes.
function flush() { for (var h=0; h<2; h++) if (hands[h].ready) emit(h,true); }
function reset() { hands=[makehand(),makehand()]; poses=[makeposes(),makeposes()]; lastTick=Date.now(); report(); calreport(); }
// Only the capture action averages recent input; ordinary motion gets no extra delay.
function capture(h, pose) {
    if ((h!==0 && h!==1) || (pose!=="open" && pose!=="fist")) return;
    var s=poses[h], now=Date.now(), rows=[], mean=[0,0,0,0,0], i,j;
    for (i=0;i<s.recent.length;i++) if (now-s.recent[i].at<=250) rows.push(s.recent[i]);
    if (rows.length<3 || now-rows[rows.length-1].at>150) {
        calmessage(h,"Need fresh data; hold the pose and retry."); return;
    }
    for (i=0;i<5;i++) {
        var lo=Infinity,hi=-Infinity;
        for (j=0;j<rows.length;j++) { var v=rows[j].values[i];mean[i]+=v;lo=Math.min(lo,v);hi=Math.max(hi,v); }
        if (hi-lo>(s.kind==="raw"?3:0.02)) { calmessage(h,"Hold still for 0.3 seconds, then retry.");return; }
        mean[i]/=rows.length;
    }
    var open=pose==="open"?mean:s.open, fist=pose==="fist"?mean:s.fist;
    if (open && fist) {
        for (i=0;i<5;i++) if (Math.abs(fist[i]-open[i])<(s.kind==="raw"?5:0.025)) {
            calmessage(h,"Pose span too small: "+["Pinky","Ring","Middle","Index","Thumb"][i]+". Retry this pose.");return;
        }
        calibrated[h]={kind:s.kind,open:open.slice(),fist:fist.slice()};
        s.open=null;s.fist=null;
        // Do not replay the captured pose as a fresh learning frame.
        hands[h]=makehand();outlet(2,"status",h,"WAIT");
        if (typeof notifyclients==="function") notifyclients();
        calmessage(h,"Calibrated ("+s.kind+"): Open 0.000 / Fist 0.900.");
    } else {
        s[pose]=mean;
        calmessage(h,(pose==="open"?"Open captured. Now hold fist and click Fist.":"Fist captured. Now open hand and click Open.")+ (calibrated[h]?" Previous pair active.":""));
    }
}
function clearcal(h) {
    if (h!==0 && h!==1) return;
    calibrated[h]=null;poses[h]=makeposes();hands[h]=makehand();
    outlet(2,"status",h,"WAIT");
    if (typeof notifyclients==="function") notifyclients();
    calmessage(h,"Default range restored. Capture Open and Fist.");
}
function calmessage(h,s) { outlet(2,"calstatus",h,s); }
function calreport() {
    for (var h=0;h<2;h++) calmessage(h,calibrated[h]?"Calibrated ("+calibrated[h].kind+"): Open 0.000 / Fist 0.900.":"Default range. Capture Open and Fist.");
}
// Bound pattr saves endpoints, never recent samples, connection state or held data.
function getvalueof() { return JSON.stringify({version:1,hands:calibrated}); }
function setvalueof() {
    var a=arrayfromargs(arguments), data, restored=[];
    try { data=a.length===1&&a[0]==="none"?{version:1,hands:[null,null]}:JSON.parse(a.join(" ")); }
    catch(e) { return; }
    if (!data || data.version!==1 || !Array.isArray(data.hands) || data.hands.length!==2) return;
    for (var h=0;h<2;h++) {
        var v=data.hands[h];
        if (v===null) { restored[h]=null;continue; }
        if (!v || (v.kind!=="raw" && v.kind!=="norm") || !Array.isArray(v.open) || !Array.isArray(v.fist) || v.open.length!==5 || v.fist.length!==5) return;
        for(var i=0;i<5;i++) if(!finite(v.open[i]) || !finite(v.fist[i]) || Math.abs(v.fist[i]-v.open[i])<(v.kind==="raw"?5:0.025))return;
        restored[h]={kind:v.kind,open:v.open.slice(),fist:v.fist.slice()};
    }
    calibrated=restored;reset();
}
// Optional advanced calibration messages; changes take effect on subsequent raw input.
function calibration() {
    var a=arrayfromargs(arguments);
    if (a.length!==10) return;
    for (var i=0;i<5;i++) if (!finite(a[i])||!finite(a[i+5])||a[i+5]<=a[i]) return;
    minimum=a.slice(0,5); maximum=a.slice(5);
}
