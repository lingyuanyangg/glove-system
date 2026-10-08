#!/usr/bin/env python3
"""Build a standalone ten-finger native mapper driven by GLeft / GRight."""
import json,struct,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT.parent/'tools'))
from native_mapping import mapping
APP=dict(major=9,minor=1,revision=3,architecture='arm64',modernui=1)
p=dict(fileversion=1,appversion=APP,classnamespace='box',rect=[70,90,1180,780],
    openinpresentation=1,default_fontsize=11,default_fontname='Arial',devicewidth=388,
    enablehscroll=1,enablevscroll=1,boxes=[],lines=[],parameters={},autosave=0)
def box(id,cls='newobj',text=None,pres=None,**attrs):
    n=len(p['boxes']);b=dict(id=id,maxclass=cls,patching_rect=[20+(n%6)*190,210+(n//6)*60,170,22])
    if text is not None:b['text']=text
    if pres:b.update(presentation=1,presentation_rect=pres)
    b.update(attrs);p['boxes'].append({'box':b});return b
def wire(a,b,o=0,i=0):p['lines'].append({'patchline':dict(source=[a,o],destination=[b,i])})
def label(id,text,pres,size=9):return box(id,'live.comment',text,pres,fontsize=size,numinlets=1,numoutlets=0)
label('title','GLOVE  /  MAPPER',[8,3,144,16],10)
label('source','GLeft / GRight  ·  calibrated 0–1',[166,3,214,16],8)
box('controller',text='js glove_mapper.js',varname='controller',numinlets=1,numoutlets=5,outlettype=['']*5)
box('device',text='live.thisdevice');box('start','message','start');wire('device','start');wire('start','controller')
box('status',text='route status');box('hands',text='route 0 1');wire('controller','status',4);wire('status','hands')
for ch,finger in enumerate(['Pinky','Ring','Middle','Index','Thumb']):label('finger_'+str(ch),finger.upper(),[66+62*ch,20,60,11],8)
for h,name in enumerate(['left','right']):
    y=33+68*h
    label(name+'_title',name.upper(),[8,y+3,52,14],9)
    label(name+'_status','WAIT',[8,y+19,52,13],8)
    box(name+'_status_set',text='prepend set');wire('hands',name+'_status_set',h);wire(name+'_status_set',name+'_status')
    box(name+'_receive',text='r G'+name.capitalize());box(name+'_input',text='prepend '+name)
    wire(name+'_receive',name+'_input');wire(name+'_input','controller')
    box(name+'_control_receive',text='r G'+name.capitalize()+'Control');box(name+'_control_input',text='prepend '+name+'control')
    wire(name+'_control_receive',name+'_control_input');wire(name+'_control_input','controller')
    box(name+'_unpack',text='unpack f f f f f',numinlets=1,numoutlets=5,outlettype=['float']*5);wire('controller',name+'_unpack',h)
    box(name+'_monitor',text='unpack f f f f f',numinlets=1,numoutlets=5,outlettype=['float']*5);wire('controller',name+'_monitor',2+h)
    for ch,finger in enumerate(['pinky','ring','middle','index','thumb']):
        id=name+'_'+finger;x=66+62*ch
        b=box(id,'live.numbox',pres=[x,y,60,15],numinlets=1,numoutlets=2,outlettype=['','float'],
            parameter_enable=1,parameter_mappable=0,ignoreclick=1,varname=id,fontsize=10)
        b['saved_attribute_attributes']={'valueof':dict(parameter_longname=name.capitalize()+' '+finger.capitalize()+' Input',
            parameter_shortname=finger.capitalize(),parameter_type=0,parameter_mmin=0.,parameter_mmax=1.,
            parameter_initial=[0.],parameter_initial_enable=1,parameter_invisible=2,parameter_unitstyle=9,parameter_units='%0.3f')}
        p['parameters'][id]=[name.capitalize()+' '+finger.capitalize()+' Input',finger.capitalize(),0]
        box(id+'_set',text='prepend set');wire(name+'_monitor',id+'_set',ch);wire(id+'_set',id)
        box(id+'_signal',text='sig~ 0.');wire(name+'_unpack',id+'_signal',ch)
        mp=mapping(name.capitalize()+' '+finger.capitalize());mapper=id+'_map'
        box(mapper,'bpatcher',pres=[x,y+18,60,40],patcher=mp,numinlets=1,numoutlets=2,
            outlettype=['signal',''],varname=mapper,offset=[0,0],border=0,embed=1,clickthrough=0,enablehscroll=0,enablevscroll=0)
        for k,v in mp['parameters'].items():
            if isinstance(v,list):p['parameters'][mapper+'::'+k]=v
        remote=id+'_remote'
        box(remote,text='live.remote~ @normalized 0 @smoothing 0.',numinlets=2,numoutlets=0,saved_object_attributes={'_persistence':1})
        wire(id+'_signal',mapper);wire(mapper,remote);wire(mapper,remote,1,1)
box('audioin',text='plugin~',numinlets=0,numoutlets=2)
box('audioout',text='plugout~',numinlets=2,numoutlets=0);wire('audioin','audioout');wire('audioin','audioout',1,1)
p['parameters']['inherited_shortname']=1
p['dependency_cache']=[dict(name='glove_mapper.js',bootpath='.',patcherrelativepath='.',type='TEXT',implicit=1)]
(ROOT/'Glove_Mapper.maxpat').write_text(json.dumps({'patcher':p},indent=2,ensure_ascii=False))
payload=json.dumps({'patcher':p},separators=(',',':'),ensure_ascii=False).encode()+b'\0'
header=b'ampf'+struct.pack('<I',4)+b'aaaa'+b'meta'+struct.pack('<I',4)+struct.pack('<I',1)+b'ptch'+struct.pack('<I',len(payload))
(ROOT/'Glove_Mapper.amxd').write_bytes(header+payload)
print('Built Glove Mapper: ten persistent native Map/Min/Max rows, 388 × 169.')
