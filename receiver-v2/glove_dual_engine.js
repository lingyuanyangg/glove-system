// Dual receiver for ElastremeSense Manu-5D. Max's classic js runtime (ES5).
// Every consumer receives the same atomic, filtered five-float frame.
autowatch = 1;
inlets = 1;
outlets = 7;
var minimum = [0, 18, 18, 18, 70];
var maximum = [180, 180, 180, 180, 180];
var tau = 8, dead = 0.003, filtering = 1;
var hands = [makehand(), makehand()];
var lastTick = 0;
var runner = new Task(tick, this);
runner.interval = 5;

function makehand() {
    return { ready: false, target: [0,0,0,0,0], value: [0,0,0,0,0],
        sent: [0,0,0,0,0], uiDirty: false, uiAt: 0, received: 0, pendingBus: false, status: "WAIT" };
}
function finite(v) { return typeof v === "number" && isFinite(v); }
function clip(v) { return Math.max(0, Math.min(1, v)); }
function start() { runner.cancel(); lastTick = Date.now(); runner.repeat(); }
function stop() { runner.cancel(); }
function loadbang() { start(); report(); }
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
        values[i] = clip(normalized ? args[i] :
            (args[i] - minimum[i]) / (maximum[i] - minimum[i]));
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
function lost(h) { hands[h].pendingBus=false;hands[h].received=0;setstatus(h,"HOLD"); }
// Re-send current frames when OSC forwarding is enabled or its destination changes.
function flush() { for (var h=0; h<2; h++) if (hands[h].ready) emit(h,true); }
function reset() { hands=[makehand(),makehand()]; lastTick=Date.now(); report(); }
// Optional advanced calibration messages; changes take effect on subsequent raw input.
function calibration() {
    var a=arrayfromargs(arguments);
    if (a.length!==10) return;
    for (var i=0;i<5;i++) if (!finite(a[i])||!finite(a[i+5])||a[i+5]<=a[i]) return;
    minimum=a.slice(0,5); maximum=a.slice(5);
}
