#!/usr/bin/env python3
"""Build the native Ableton-style Glove MIDI effect and a matching layout preview."""
import json,struct,html
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
APP=dict(major=9,minor=1,revision=3,architecture='arm64',modernui=1)
WIDTH=984
p=dict(fileversion=1,appversion=APP,classnamespace='box',rect=[70,90,1250,820],
    openinpresentation=1,default_fontsize=10,default_fontname='Arial',devicewidth=WIDTH,
    enablehscroll=0,enablevscroll=0,boxes=[],lines=[],parameters={},autosave=0)
preview=[]
def box(id,cls='newobj',text=None,pres=None,**attrs):
    n=len(p['boxes']);b=dict(id=id,maxclass=cls,patching_rect=[20+(n%8)*155,220+(n//8)*38,145,22])
    if text is not None:b['text']=text
    if pres:b.update(presentation=1,presentation_rect=pres)
    b.update(attrs);p['boxes'].append({'box':b});return b
def wire(a,b,o=0,i=0):p['lines'].append({'patchline':dict(source=[a,o],destination=[b,i])})
def label(id,text,pres,size=9):
    preview.append(('label',text,pres,size));return box(id,'live.comment',text,pres,fontsize=size,numinlets=1,numoutlets=0)
def control(id,name,pres,default=0,lo=0,hi=127,enum=None,unit=1,annotation=''):
    cls='live.toggle' if id.endswith('_on') else ('live.menu' if enum else 'live.numbox');opts=dict(numinlets=1,numoutlets=3 if enum else 2,outlettype=['']*(3 if enum else 2),parameter_enable=1,varname=id,fontsize=9,annotation=annotation)
    if enum and cls=='live.menu':opts.update(items=enum)
    if cls=='live.toggle':opts.update(numoutlets=2,outlettype=['',''])
    b=box(id,cls,pres=pres,**opts)
    value=dict(parameter_longname=name,parameter_shortname=name,parameter_type=2 if enum else 0,
        parameter_mmin=lo,parameter_mmax=len(enum)-1 if enum else hi,parameter_initial=[default],parameter_initial_enable=1,parameter_unitstyle=unit)
    if enum:value['parameter_enum']=enum
    b['saved_attribute_attributes']={'valueof':value};p['parameters'][id]=[name,name,0]
    preview.append(('control',enum[default] if enum else str(default),pres,9))
    return b
def button(id,name,pres,cmd):
    box(id,'live.text',name,pres,texton=name,mode=0,numinlets=1,numoutlets=2,outlettype=['',''],parameter_enable=0,varname=id,fontsize=9)
    box(id+'_bang',text='t b');box(id+'_command','message',cmd);wire(id,id+'_bang');wire(id+'_bang',id+'_command');wire(id+'_command','engine')
    preview.append(('control',name,pres,9))
box('engine',text='js glove_midi_trigger.js',varname='engine',numinlets=2,numoutlets=3,outlettype=['','',''])
box('device',text='live.thisdevice',numinlets=1,numoutlets=3,outlettype=['bang','int','int'])
box('init',text='t b b');box('start','message','start');wire('device','init');wire('init','start',1);wire('start','engine')
box('device_state',text='prepend device');wire('device','device_state',1);wire('device_state','engine')
box('free',text='freebang');box('stop','message','stop');wire('free','stop');wire('stop','engine')
box('midiin',text='midiin',numinlets=1,numoutlets=1,outlettype=['int']);wire('midiin','engine',0,1)
box('midiout',text='midiout',numinlets=1,numoutlets=0);wire('engine','midiout')
label('title','GLOVE / MIDI TRIGGER',[8,3,154,17],11)
label('subtitle','Bend acceleration · hold · scale',[8,23,167,13],8)
settings=[('sensitivity','Sens %',10,400,100,180,62),('threshold','Threshold',.05,.95,.25,248,58),
    ('length','Length ms',10,2000,120,312,60),('gap','Retrig ms',20,2000,120,378,60),
    ('channel','Channel',1,16,1,444,49),('reference','Cal ref / s²',.1,10000,50,499,82)]
for key,name,lo,hi,value,x,w in settings:
    label(key+'_label',name,[x,3,w,13],8)
    b=control(key,'Global '+name,[x,19,w,17],value,lo,hi)
    if key in ['threshold','reference']:b['saved_attribute_attributes']['valueof'].update(parameter_unitstyle=9,parameter_units='%0.2f')
    box(key+'_send',text='prepend setting '+key);wire(key,key+'_send');wire(key+'_send','engine');wire('init',key)
button('calibrate','Calibrate 8 s',[589,19,80,17],'calibrate')
button('panic','Panic',[675,19,47,17],'panic')
label('hint','MIDI effect → instrument',[734,3,242,13],9)
label('notice','Return fingers below 0.45 to arm.',[734,20,242,16],8)
box('ui_route',text='route status finger notice');wire('engine','ui_route',1)
box('hand_route',text='route 0 1');wire('ui_route','hand_route')
box('finger_route',text='route '+' '.join(map(str,range(10))));wire('ui_route','finger_route',1)
box('notice_set',text='prepend set');wire('ui_route','notice_set',2);wire('notice_set','notice')
box('reference_route',text='route reference');box('reference_set',text='prepend set');wire('engine','reference_route',2);wire('reference_route','reference_set');wire('reference_set','reference')
widths=[48,22,48,46,38,34,76,38,38,34,34]
keys=['finger','on','mode','pitchmode','note','root','scale','low','high','vmin','vmax']
heads=['FINGER','ON','TRIGGER','PITCH','NOTE','ROOT','SCALE','LOW','HIGH','V MIN','V MAX']
scale_names=['Chromatic','Major','Minor','Dorian','Phrygian','Lydian','Mixolydian','Locrian','Maj pent','Min pent','Blues','Whole tone']
root_names=['C','C#','D','D#','E','F','F#','G','G#','A','A#','B']
for h,name in enumerate(['Left','Right']):
    origin=8+h*488
    label(name+'_title',name.upper(),[origin,40,48,14],10)
    label(name+'_status','WAIT',[origin+55,40,70,14],9)
    label(name+'_bus','G'+name+' · fresh frames',[origin+136,41,190,13],8)
    box(name+'_set',text='prepend set');wire('hand_route',name+'_set',h);wire(name+'_set',name+'_status')
    box(name+'_receive',text='r G'+name);box(name+'_input',text='prepend '+name.lower());wire(name+'_receive',name+'_input');wire(name+'_input','engine')
    xx=origin
    for head,w in zip(heads,widths):label(name+'_'+head,head,[xx,56,w,12],8);xx+=w+2
    for f,finger in enumerate(['Pinky','Ring','Middle','Index','Thumb']):
        index=h*5+f;y=70+f*18;x=origin
        fid=name+'_'+finger;label(fid,finger,[x,y,48,16],9)
        box(fid+'_set',text='prepend set');wire('finger_route',fid+'_set',index);wire(fid+'_set',fid);x+=50
        specs=[('on',1,0,1,['Off','On'],1),('mode',0,0,1,['Accel','Toggle'],1),('pitchmode',0,0,1,['Fixed','Random'],1),
            ('note',60+index,0,127,None,3),('root',0,0,11,root_names,1),('scale',1,0,11,scale_names,1),
            ('low',48,0,127,None,3),('high',84,0,127,None,3),('vmin',20,1,127,None,1),('vmax',127,1,127,None,1)]
        for w,(key,default,lo,hi,enum,unit) in zip(widths[1:],specs):
            id=fid+'_'+key
            control(id,name+' '+finger+' '+key,[x,y,w,16],default,lo,hi,enum,unit,
                'Toggle holds above 0.5 and releases below 0.45. Random uses this root/scale within Low–High. Velocity endpoints may be inverted.')
            box(id+'_send',text='prepend config '+str(index)+' '+key);wire(id,id+'_send');wire(id+'_send','engine');wire('init',id);x+=w+2
label('footer','* = held note    ·    Random: root + scale + Low–High    ·    Toggle: >0.5 ON, <0.45 OFF; bend sends poly pressure    ·    source loss releases notes',[8,160,968,9],8)
p['parameters']['inherited_shortname']=1
p['dependency_cache']=[dict(name='glove_midi_trigger.js',bootpath='.',patcherrelativepath='.',type='TEXT',implicit=1)]
(ROOT/'Glove_MIDI_Trigger.maxpat').write_text(json.dumps({'patcher':p},indent=2,ensure_ascii=False)+'\n')
payload=json.dumps({'patcher':p},separators=(',',':'),ensure_ascii=False).encode()+b'\0'
header=b'ampf'+struct.pack('<I',4)+b'mmmm'+b'meta'+struct.pack('<I',4)+struct.pack('<I',1)+b'ptch'+struct.pack('<I',len(payload))
(ROOT/'Glove_MIDI_Trigger.amxd').write_bytes(header+payload)
svg=[f'<svg xmlns="http://www.w3.org/2000/svg" width="{WIDTH}" height="169" viewBox="0 0 {WIDTH} 169"><rect width="{WIDTH}" height="169" fill="#292929"/>']
svg+=['<path d="M492 40V157 M8 38H976" stroke="#4d4d4d"/>']
for kind,text,(x,y,w,h),size in preview:
    if kind=='control':svg.append(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="2" fill="#3e3e3e" stroke="#666" stroke-width=".6"/>')
    svg.append(f'<text x="{x+3}" y="{y+(h+size)/2-1}" font-family="Arial,sans-serif" font-size="{size}" fill="#ddd">{html.escape(text)}</text>')
svg.append('</svg>');(ROOT/'ui-layout.svg').write_text('\n'.join(svg)+'\n')
print(f'Built MIDI effect: 10 fingers, {len(p["parameters"])-1} persistent controls, {WIDTH} × 169.')
