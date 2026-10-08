// Original animated vector hands. Values are normalized curl, not measured joint angles.
autowatch = 1;
inlets = 1;
outlets = 0;
mgraphics.init();
mgraphics.relative_coords = 0;
mgraphics.autofill = 0;
var ink=[0.72,0.72,0.72,1], accent=[1,0.71,0.20,1];
var frames=[[0,0,0,0,0],[0,0,0,0,0]], states=['WAIT','WAIT'];
var columns=[26,85,144,203,277];
function frame(h,args){var a=arrayfromargs(args);if(a.length!==5)return;for(var i=0;i<5;i++)if(typeof a[i]!=='number'||!isFinite(a[i]))return;frames[h]=a;mgraphics.redraw();}
function left(){frame(0,arguments);}
function right(){frame(1,arguments);}
function status(h,s){if((h===0||h===1)&&states[h]!==s){states[h]=s;mgraphics.redraw();}}
function live_lcd_control_fg(){accent=arrayfromargs(arguments);mgraphics.redraw();}
function live_lcd_frame(){ink=arrayfromargs(arguments);mgraphics.redraw();}
function live_control_text(){ink=arrayfromargs(arguments);mgraphics.redraw();}
function anything(){}
function color(c,a){mgraphics.set_source_rgba(c[0],c[1],c[2],a);}
function line(x,y,xx,yy,w){mgraphics.set_line_width(w);mgraphics.move_to(x,y);mgraphics.line_to(xx,yy);mgraphics.stroke();}
function normal(a,b){var x=b[0]-a[0],y=b[1]-a[1],n=Math.sqrt(x*x+y*y)||1;return [-y/n,x/n];}
function edge(p,n,r){return [p[0]+n[0]*r,p[1]+n[1]*r];}
function capsule(points,r){
    var g=mgraphics,a=points[0],b=points[1],c=points[2],n=normal(a,b),t=normal(b,c);
    var mid=normal(a,c),u=edge(a,n,r),v=edge(b,mid,r),w=edge(c,t,r);
    var uu=edge(a,n,-r),vv=edge(b,mid,-r),ww=edge(c,t,-r);
    g.move_to(u[0],u[1]);g.curve_to(u[0],u[1]-5,v[0],v[1],w[0],w[1]);
    g.curve_to(w[0]+t[1]*r,w[1]-t[0]*r,ww[0]+t[1]*r,ww[1]-t[0]*r,ww[0],ww[1]);
    g.curve_to(vv[0],vv[1],uu[0],uu[1]-5,uu[0],uu[1]);g.stroke();
}
function joints(i,v){
    if(i===4)return [[242,111],[265-12*v,100+9*v],[280-31*v,94+18*v]];
    var root=[56+54*i,104],openX=columns[i]+8,tipY=[82,75,70,77][i];
    return [root,[(root[0]+openX)/2+8*v,88+12*v],[openX+19*v,tipY+(104-tipY)*v]];
}
function paint(){
    var g=mgraphics;color(ink,.22);line(8,22,640,22,.7);line(324,4,324,122,.7);
    for(var h=0;h<2;h++){
        g.save();g.translate(h===0?8:640,0);if(h===1)g.scale(-1,1);
        var live=states[h]!=='WAIT',opacity=states[h]==='HOLD'?.48:live?.95:.3;
        for(var i=0;i<5;i++){
            var v=Math.max(0,Math.min(1,frames[h][i]||0)),x=columns[i]-23;
            color(ink,.2);line(x,61,x+46,61,4);
            if(v>0){color(accent,opacity);line(x,61,x+46*v,61,4);}
            color(ink,.55);line(x+41.4,58,x+41.4,64,.6); // Calibrated fist = 0.9.
            color(ink,.16);g.set_line_width(.8);capsule(joints(i,0),6);
            var points=joints(i,v);color(ink,live?.65:.35);g.set_line_width(1.1);capsule(points,6);
            color(accent,opacity);line(points[0][0],points[0][1],points[1][0],points[1][1],2.2);
            line(points[1][0],points[1][1],points[2][0],points[2][1],2.2);
        }
        color(ink,live?.7:.35);g.set_line_width(1.1);
        for(var k=0;k<3;k++){var base=56+54*k;g.move_to(base+6,104);g.curve_to(base+17,101,base+36,101,base+48,104);g.stroke();}
        g.move_to(224,104);g.curve_to(232,105,233,109,236,111);g.stroke();
        // Palm, wrist and a shallow crease link the five separate moving fingers.
        color(ink,live?.7:.35);g.set_line_width(1.1);
        g.move_to(50,105);g.curve_to(57,115,77,119,99,120);
        g.line_to(213,120);g.curve_to(231,118,242,116,248,112);g.stroke();
        color(ink,.3);g.move_to(93,111);g.curve_to(129,106,180,106,220,112);g.stroke();
        g.restore();
    }
}
