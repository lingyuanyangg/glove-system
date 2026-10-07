// Vector hand drawings: no bitmap dependency, crisp at every display scale.
autowatch = 1;
inlets = 1;
outlets = 0;
mgraphics.init();
mgraphics.relative_coords = 0;
mgraphics.autofill = 0;
var ink=[0.72,0.72,0.72,1], accent=[1,0.71,0.20,1];
var frames=[[0,0,0,0,0],[0,0,0,0,0]], states=["WAIT","WAIT"];
// One spread hand; the opposite hand mirrors this path.
var contour=[
    ["M",124,143], ["C",116,135,89,132,71,124],
    ["C",54,115,21,117,17,105], ["L",17,98],
    ["C",17,88,39,88,39,98], ["L",46,113],
    ["C",50,119,66,118,72,117], ["L",85,88],
    ["C",85,75,107,74,107,88], ["L",112,113],
    ["C",117,118,131,117,139,116], ["L",153,79],
    ["C",153,66,175,66,175,79], ["L",181,113],
    ["C",187,119,199,120,209,118], ["L",221,89],
    ["C",221,75,244,75,244,89], ["L",255,118],
    ["C",260,128,272,128,282,124], ["L",313,114],
    ["C",329,109,340,120,327,128], ["L",295,141],
    ["C",282,146,276,146,272,143]
];
function left() { frames[0]=arrayfromargs(arguments);mgraphics.redraw(); }
function right() { frames[1]=arrayfromargs(arguments);mgraphics.redraw(); }
function status(h,s) { states[h]=s;mgraphics.redraw(); }
function live_lcd_control_fg() { accent=arrayfromargs(arguments);mgraphics.redraw(); }
function live_lcd_frame() { ink=arrayfromargs(arguments);mgraphics.redraw(); }
function live_control_text() { ink=arrayfromargs(arguments);mgraphics.redraw(); }
function anything() { /* Ignore theme colors this drawing does not use. */ }
function path(commands) {
    for(var i=0;i<commands.length;i++) {
        var a=commands[i];
        if(a[0]==="M")mgraphics.move_to(a[1],a[2]);
        else if(a[0]==="L")mgraphics.line_to(a[1],a[2]);
        else mgraphics.curve_to(a[1],a[2],a[3],a[4],a[5],a[6]);
    }
}
function paint() {
    var g=mgraphics;
    g.set_source_rgba(ink[0],ink[1],ink[2],0.22);
    g.set_line_width(0.7);g.move_to(8,22);g.line_to(800,22);g.move_to(404,5);g.line_to(404,144);g.stroke();
    for(var h=0;h<2;h++) {
        g.save();g.translate(h===0?8:784,0);if(h===1)g.scale(-1,1);
        g.set_line_width(1.2);g.set_source_rgba(ink[0],ink[1],ink[2],0.8);
        path(contour);g.stroke();
        g.set_line_width(0.7);g.set_source_rgba(ink[0],ink[1],ink[2],0.35);
        g.move_to(129,137);g.curve_to(161,128,199,132,242,139);g.stroke();
        g.move_to(287,128);g.curve_to(273,130,267,136,260,141);g.stroke();
        var xs=[28,96,164,232,324],tips=[99,89,79,89,120];
        for(var i=0;i<5;i++) {
            var v=Math.max(0,Math.min(1,frames[h][i]||0));
            g.set_source_rgba(accent[0],accent[1],accent[2],states[h]==="WAIT"?0.15:0.4+0.5*v);
            g.set_line_width(2.4);
            if(i<4) {g.move_to(xs[i],tips[i]+2);g.line_to(xs[i]+5, tips[i]+6+v*10);}
            else {g.move_to(323,121);g.line_to(315-v*11,124+v*3);}
            g.stroke();
        }
        g.restore();
    }
}
