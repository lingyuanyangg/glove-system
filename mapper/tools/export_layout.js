// Illustrative native widget layout, not an Ableton screenshot.
const fs=require('fs'),path=require('path');const root=path.resolve(__dirname,'..');
const p=JSON.parse(fs.readFileSync(path.join(root,'Glove_Mapper.maxpat'))).patcher;
const esc=s=>String(s).replace(/&/g,'&amp;').replace(/</g,'&lt;');
let svg=['<rect width="388" height="169" fill="#383838"/>'];
function rect(x,y,w,h){svg.push(`<rect x="${x}" y="${y}" width="${w}" height="${h}" fill="#292929" stroke="#727272" stroke-width=".45"/>`);}
function text(x,y,s,size=9,col='#d4d4d4'){svg.push(`<text x="${x}" y="${y}" font-family="Arial, sans-serif" font-size="${size}" fill="${col}">${esc(s)}</text>`);}
for(const o of p.boxes){const b=o.box;if(!b.presentation)continue;const [x,y,w,h]=b.presentation_rect;
 if(b.maxclass==='live.comment'){text(x,y+h*.74,b.text,b.fontsize);continue;}
 if(b.maxclass==='bpatcher'){
  rect(x,y,46,14);text(x+12,y+10,'Map',9,'#ffc15a');rect(x+47,y,13,14);text(x+49,y+10,'×',9);
  text(x,y+22,'MIN',7);text(x+31,y+22,'MAX',7);
  rect(x,y+24,29,15);rect(x+31,y+24,29,15);text(x+2,y+35,'0%',9);text(x+32,y+35,'100%',9);continue;
 }
 rect(x,y,w,h);text(x+4,y+11,'0.000',10);
}
fs.writeFileSync(path.join(root,'layout-preview.svg'),`<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 388 169" width="776" height="338">${svg.join('')}</svg>`);
console.log('Exported Mapper presentation preview.');
