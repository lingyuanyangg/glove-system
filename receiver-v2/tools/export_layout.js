// Export the actual jsui vectors + patch presentation rectangles for layout review.
// This is a layout preview, not a screenshot of native Max/Live widgets.
const fs=require('fs'),path=require('path'),vm=require('vm');
const root=path.resolve(__dirname,'..');let svg=[],d='',color='',width=1;
const esc=s=>String(s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/"/g,'&quot;');
const g={init(){},redraw(){},save(){svg.push('<g>');},restore(){svg.push('</g>');},
 translate(x,y){svg.push(`<g transform="translate(${x} ${y})">`);},
 scale(x,y){svg.push(`<g transform="scale(${x} ${y})">`);},
 set_source_rgba(r,g,b,a){color=`rgba(${r*255},${g*255},${b*255},${a})`;},
 set_line_width(w){width=w;},move_to(x,y){d+=` M${x} ${y}`;},
 line_to(x,y){d+=` L${x} ${y}`;},curve_to(...a){d+=' C'+a.join(' ');},
 stroke(){svg.push(`<path d="${d}" fill="none" stroke="${color}" stroke-width="${width}" stroke-linecap="round"/>`);d='';}};
// save/restore must also close the nested transforms emitted in each state scope.
const stack=[];let nested=0;
g.save=()=>stack.push(nested);g.translate=(x,y)=>{svg.push(`<g transform="translate(${x} ${y})">`);nested++;};
g.scale=(x,y)=>{svg.push(`<g transform="scale(${x} ${y})">`);nested++;};
g.restore=()=>{const target=stack.pop();while(nested>target){svg.push('</g>');nested--;}};
const c={mgraphics:g,arrayfromargs:a=>Array.from(a)};vm.createContext(c);
vm.runInContext(fs.readFileSync(path.join(root,'glove_hands.js'),'utf8'),c);c.left(0,.25,.5,.75,.9);c.right(.9,.75,.5,.25,0);c.status(0,'LIVE');c.status(1,'LIVE');c.paint();
let vectors=svg.join('');
fs.writeFileSync(path.join(root,'hands.svg'),`<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 648 122">${vectors}</svg>`);
svg=[`<rect width="648" height="169" fill="#383838"/>`,vectors];
const p=JSON.parse(fs.readFileSync(path.join(root,'Glove_Receiver_Dual.maxpat'))).patcher;
function rect(x,y,w,h,fill='#292929'){svg.push(`<rect x="${x}" y="${y}" width="${w}" height="${h}" fill="${fill}" stroke="#727272" stroke-width=".45"/>`);}
function text(x,y,s,size=9,col='#d4d4d4'){svg.push(`<text x="${x}" y="${y}" font-family="Arial, sans-serif" font-size="${size}" fill="${col}">${esc(s)}</text>`);}
function widgets(p){for(const o of p.boxes){const b=o.box;if(!b.presentation||b.maxclass==='jsui')continue;
 const [x,y,w,h]=b.presentation_rect;
 if(b.maxclass==='live.comment'){text(x,y+h*.74,['left_status','right_status'].includes(b.id)?'LIVE':b.text,b.fontsize);continue;}
 if(b.maxclass==='bpatcher'){
  rect(x,y,46,14);text(x+12,y+10,'Map',9,'#ffc15a');rect(x+47,y,13,14);text(x+49,y+10,'×',9);
  rect(x,y+15,60,9);text(x,y+22,'MIN',7);text(x+31,y+22,'MAX',7);
  rect(x,y+24,29,15);rect(x+31,y+24,29,15);text(x+2,y+35,'0%',9);text(x+32,y+35,'100%',9);continue;
 }
 rect(x,y,w,h,b.id==='filter_enabled'?'#a99a67':'#292929');
 let s=b.text||'';
 if(b.maxclass==='live.menu')s=b.saved_attribute_attributes.valueof.parameter_enum[0];
 if(b.maxclass==='umenu')s=b.items[0];
 if(b.maxclass==='live.numbox'){
  const v=b.saved_attribute_attributes.valueof;const a=v.parameter_initial[0];
  const match=/^(left|right)_(pinky|ring|middle|index|thumb)$/.exec(b.id);const fingers=['pinky','ring','middle','index','thumb'];const value=match?c.frames[match[1]==='left'?0:1][fingers.indexOf(match[2])]:a;
  s=v.parameter_units==='%0.3f'?value.toFixed(3):String(value)+(b.id==='smooth_ms'?' ms':'');
 }
 text(x+4,y+h*.76,s,b.fontsize||10,b.id==='filter_enabled'?'#161616':'#d4d4d4');
}
}
widgets(p);
fs.writeFileSync(path.join(root,'layout-preview.svg'),`<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 648 169" width="1296" height="338">${svg.join('')}</svg>`);
svg=['<rect width="580" height="80" fill="#383838"/>'];
widgets(p.boxes.find(o=>o.box.id==='usb_settings').box.patcher);
fs.writeFileSync(path.join(root,'usb-settings-preview.svg'),`<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 580 80" width="1160" height="160">${svg.join('')}</svg>`);
svg=['<rect width="440" height="222" fill="#383838"/>'];
widgets(p.boxes.find(o=>o.box.id==='left_calibration').box.patcher);
fs.writeFileSync(path.join(root,'calibration-preview.svg'),`<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 222" width="880" height="444">${svg.join('')}</svg>`);
console.log('Exported main, calibration and USB window layout previews from shipped code.');
