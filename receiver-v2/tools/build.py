#!/usr/bin/env python3
"""Build a dual-hand Max for Live audio effect; retain the original device."""
import copy, json, struct
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
APP = dict(major=9, minor=1, revision=3, architecture="arm64", modernui=1)
NATIVE = Path('/Applications/Max.app/Contents/Resources/C74/packages/Max for Live/patchers/liveui.map.maxpat')

def patch():
    return dict(fileversion=1, appversion=APP, classnamespace='box',
                rect=[70,90,1110,780], openinpresentation=1,
                default_fontsize=11, default_fontname='Arial',
                devicewidth=808, enablehscroll=0, enablevscroll=0,
                boxes=[], lines=[], parameters={})

p=patch()
def box(id, cls='newobj', text=None, rect=None, pres=None, **attrs):
    b=dict(id=id,maxclass=cls,patching_rect=rect or [20,200+len(p['boxes'])*24,145,22])
    if text is not None: b['text']=text
    if pres: b.update(presentation=1,presentation_rect=pres)
    b.update(attrs);p['boxes'].append({'box':b});return b
def wire(a,b,o=0,i=0,order=None):
    l=dict(source=[a,o],destination=[b,i])
    if order is not None:l['order']=order
    p['lines'].append({'patchline':l})
def param(id,name,lo,hi,default,pres,unit=1,integer=False,**attrs):
    b=box(id,'live.numbox',pres=pres,numinlets=1,numoutlets=2,
          outlettype=['','float'],parameter_enable=1,varname=id,fontsize=10,
          **attrs)
    b['saved_attribute_attributes']={'valueof':dict(parameter_longname=name,
        parameter_shortname=name,parameter_type=0,
        parameter_mmin=lo,parameter_mmax=hi,parameter_initial=[default],
        parameter_initial_enable=1,parameter_unitstyle=unit)}
    if attrs.get('decimal_places') is not None:
        b.pop('decimal_places',None)
        b['saved_attribute_attributes']['valueof'].update(
            parameter_unitstyle=9,parameter_units='%0.3f')
    p['parameters'][id]=[name,name,0];return b
def button(id,name,pres,default=0,mode=1):
    b=box(id,'live.text',text=name,pres=pres,texton=name,mode=mode,
          numinlets=1,numoutlets=2,outlettype=['',''],parameter_enable=1,
          varname=id,fontsize=9)
    b['saved_attribute_attributes']={'valueof':dict(parameter_longname=name,
        parameter_shortname=name,parameter_type=2,parameter_enum=['Off','On'],
        parameter_mmax=1,parameter_initial=[default],parameter_initial_enable=1,
        parameter_invisible=1 if mode else 2)}
    p['parameters'][id]=[name,name,0];return b
def label(id,text,rect,size=9):
    return box(id,'live.comment',text=text,pres=rect,fontsize=size,
               numinlets=1,numoutlets=0,textjustification=0)

native=json.loads(NATIVE.read_text())['patcher']
# Embed the native Live UI implementation; customize only presentation/name metadata.
def mapping(name):
    m=copy.deepcopy(native);m.update(devicewidth=60,rect=[0,0,60,15],enablehscroll=0,enablevscroll=0)
    ids={o['box']['id']:o['box'] for o in m['boxes']}
    for id in ('obj-48','obj-34'): ids[id]['presentation_rect']=[0,0,46,14]
    ids['obj-47'].update(presentation_rect=[47,0,13,14],usepicture=0,pictures=[],fontsize=9,text='×',texton='×')
    ids['obj-48']['fontsize']=9
    for id in ('obj-45','obj-46'):ids[id]['presentation']=0
    for id,data in list(m['parameters'].items()):
        if not isinstance(data,list):continue
        unique=name+' '+data[1]
        data[0]=unique
        ids[id]['saved_attribute_attributes']['valueof']['parameter_longname']=unique
    def shorten(sub):
        for o in sub['boxes']:
            b=o['box']
            if b.get('text')=='zl slice 12':b['text']='zl slice 5'
            if 'patcher' in b:shorten(b['patcher'])
    shorten(m)
    return m

box('art','jsui',pres=[0,0,808,149],rect=[20,40,808,149],filename='glove_hands.js',
    numinlets=1,numoutlets=0,jsarguments=['glove_hands.js'],ignoreclick=1,
    border=0,parameter_enable=0,background=1)
label('left_title','GLOVE  /  LEFT',[8,3,125,17],10)
label('right_title','GLOVE  /  RIGHT',[414,3,125,17],10)
label('left_port','IN 7000  ·  /servos',[146,4,118,15],9)
label('right_port','IN 6000  ·  /servos',[552,4,118,15],9)
label('left_status','WAIT',[340,4,48,15],9)['suppressinlet']=0
label('right_status','WAIT',[746,4,48,15],9)['suppressinlet']=0

box('engine',text='js glove_dual_engine.js',rect=[80,360,170,22],
    numinlets=1,numoutlets=3,outlettype=['','',''],varname='engine')
box('device',text='live.thisdevice',rect=[20,240,95,22])
box('start',text='start',cls='message',rect=[20,278,50,22]);wire('device','start');wire('start','engine')
box('colors',text='live.colors',rect=[680,300,75,22])
box('query_colors','message','everything',rect=[680,268,70,22])
wire('device','query_colors');wire('colors','query_colors',1);wire('query_colors','colors');wire('colors','art')
wire('engine','art',2)
box('statusroute',text='route status',rect=[290,368,90,22]);wire('engine','statusroute',2)
box('handroute',text='route 0 1',rect=[290,404,70,22]);wire('statusroute','handroute')
for h,(name,port,origin,mirrored) in enumerate([('left',7000,8,False),('right',6000,414,True)]):
    labelname=name.capitalize()
    box(name+'_udp',text=f'udpreceive {port}',rect=[40+300*h,210,130,22])
    box(name+'_route',text=f'route /servos /G{labelname}',rect=[40+300*h,245,180,22])
    wire(name+'_udp',name+'_route')
    for o,kind in enumerate(['raw','norm']):
        id=name+'_'+kind;box(id,text='prepend '+kind+name,rect=[40+300*h+o*130,285,125,22])
        wire(name+'_route',id,o);wire(id,'engine')
    box(name+'_send',text='s G'+labelname,rect=[40+300*h,465,75,22]);wire('engine',name+'_send',h)
    box(name+'_unpack',text='unpack f f f f f',rect=[40+300*h,505,190,22]);wire('engine',name+'_unpack',h)
    box(name+'_statusset',text='prepend set',rect=[290+100*h,439,85,22]);wire('handroute',name+'_statusset',h);wire(name+'_statusset',name+'_status')
    box(name+'_art',text='prepend '+name,rect=[50+300*h,550,95,22]);wire('engine',name+'_art',h);wire(name+'_art','art')
    for ch,(finger,x,tip) in enumerate(zip(['Pinky','Ring','Middle','Index','Thumb'],[28,96,164,232,324],[91,78,69,78,112])):
        x=origin+(370-x if mirrored else x)
        id=f'{name}_{finger.lower()}'
        label(id+'_label',finger.upper(),[x-29,tip-44,62,11],8)
        b=param(id,labelname+' '+finger,0.,1.,0.,[x-29,tip-33,60,15],
            annotation='Filtered normalized finger value, from 0 to 1.',
            decimal_places=3,focusbordercolor=[1,.71,.196,1])
        # Native numeric range/format; hidden monitor state is not automated or saved.
        b['saved_attribute_attributes']['valueof']['parameter_invisible']=2
        b.update(ignoreclick=1,parameter_mappable=0)
        setid=id+'_set';box(setid,text='prepend set');wire(name+'_unpack',setid,ch);wire(setid,id)
        sig=id+'_signal';box(sig,text='sig~ 0.');wire(name+'_unpack',sig,ch)
        mapper=id+'_map';mp=mapping(labelname+' '+finger)
        box(mapper,'bpatcher',pres=[x-29,tip-17,60,14],patcher=mp,
            numinlets=1,numoutlets=2,outlettype=['signal',''],varname=mapper,
            offset=[0,0],border=0,embed=1,clickthrough=0,enablehscroll=0,enablevscroll=0)
        for k,v in mp['parameters'].items():
            if isinstance(v,list):p['parameters'][mapper+'::'+k]=v
        remote=id+'_remote';box(remote,text='live.remote~ @normalized 1 @smoothing 0.',
            saved_object_attributes={'_persistence':1});wire(sig,remote);wire(mapper,remote,1,1)
        wire(sig,mapper)

button('filter_enabled','Stabilize',[8,151,54,15],1)
label('smooth_label','Smooth',[72,150,39,17]);param('smooth_ms','Smooth ms',0,500,30,[113,151,46,15],unit=2)
label('dead_label','Deadband',[169,150,48,17]);param('deadband','Deadband',0,.1,.003,[222,151,52,15],decimal_places=3)
for id,selector in [('filter_enabled','enabled'),('smooth_ms','smooth'),('deadband','deadband')]:
    box(id+'_prepend',text='prepend '+selector);wire(id,id+'_prepend');wire(id+'_prepend','engine')
button('osc_enable','OSC Out',[289,151,51,15],0)
label('ip_label','IP',[351,150,15,17])
box('osc_host','textedit',pres=[368,150,133,17],text='127.0.0.1',varname='osc_host',
    numinlets=1,numoutlets=4,outlettype=['','int','',''],keymode=1,lines=1,wordwrap=0,
    fontsize=10,border=0,rounded=0,
    saved_attribute_attributes={
        'bgcolor':{'expression':'themecolor.live_lcd_bg'},
        'textcolor':{'expression':'themecolor.live_lcd_control_fg'}})
box('host_state',text='pattr destination @bindto osc_host @initial 127.0.0.1',
    varname='destination',parameter_enable=1,
    saved_attribute_attributes={'valueof':dict(parameter_longname='OSC Destination',
        parameter_shortname='Destination',parameter_type=3,parameter_invisible=1,
        parameter_initial=['127.0.0.1'],parameter_initial_enable=1)})
p['parameters']['host_state']=['OSC Destination','Destination',0]
label('port_label','Port',[510,150,24,17]);param('osc_port','OSC Port',1,65535,8000,[539,151,53,15],unit=0,integer=True)
button('apply','Apply',[602,151,40,15],mode=0)
label('order_note','Pinky → Ring → Middle → Index → Thumb',[652,151,151,15],8)
box('host_route',text='route text');wire('osc_host','host_route')
box('host_prepend',text='prepend host');wire('host_route','host_prepend')
box('port_integer',text='i');wire('osc_port','port_integer')
box('port_prepend',text='prepend port');wire('port_integer','port_prepend')
box('udpout',text='udpsend 127.0.0.1 8000',rect=[620,570,160,22]);wire('host_prepend','udpout');wire('port_prepend','udpout')
box('apply_bang',text='t b b');wire('apply','apply_bang');wire('apply_bang','osc_host',1);wire('apply_bang','osc_port',0)
box('startup_destination',text='deferlow');wire('device','startup_destination');wire('startup_destination','apply_bang')
box('osc_switch',text='t b i');wire('osc_enable','osc_switch')
box('flush',cls='message',text='flush');wire('osc_switch','flush');wire('flush','engine')
for h,name in enumerate(['left','right']):
    gate=name+'_osc_gate';prefix=name+'_osc_prefix'
    box(gate,text='gate 1');wire('osc_switch',gate,1);wire('engine',gate,h,1)
    box(prefix,text='prepend /G'+name.capitalize());wire(gate,prefix);wire(prefix,'udpout')
box('host_flush',text='deferlow');wire('host_route','host_flush');wire('port_prepend','host_flush');wire('host_flush','flush')
box('audioin',text='plugin~',rect=[880,220,75,22]);box('audioout',text='plugout~',rect=[880,265,75,22]);wire('audioin','audioout');wire('audioin','audioout',1,1)
p['parameters']['parameterbanks']={'0':dict(index=0,name='Receiver',parameters=['smooth_ms','deadband','filter_enabled','osc_enable','osc_port','-','-','-'])}
p['parameters']['inherited_shortname']=1
p['dependency_cache']=[dict(name=f,bootpath='.',patcherrelativepath='.',type='TEXT',implicit=1) for f in ['glove_dual_engine.js','glove_hands.js']]
p['autosave']=0
# Arrange the editable graph separately from the compact performance presentation.
objects={o['box']['id']:o['box'] for o in p['boxes']}
for h,name in enumerate(['left','right']):
    x=30+h*660
    positions={name+'_udp':[x,250,130,22],name+'_route':[x,290,210,22],
        name+'_raw':[x,330,120,22],name+'_norm':[x+170,330,125,22],
        name+'_send':[x,440,80,22],name+'_unpack':[x,485,555,22],
        name+'_art':[x+130,440,90,22],name+'_statusset':[x+250,440,95,22]}
    for k,v in positions.items():objects[k]['patching_rect']=v
    for ch,finger in enumerate(['pinky','ring','middle','index','thumb']):
        id=name+'_'+finger;cx=x+ch*112
        positions={id+'_label':[cx,540,90,14],id+'_set':[cx,565,90,22],
          id:[cx,602,60,15],id+'_signal':[cx,641,65,22],
          id+'_map':[cx,683,60,14],id+'_remote':[cx,726,105,46]}
        for k,v in positions.items():objects[k]['patching_rect']=v
objects['engine']['patching_rect']=[355,390,195,22]
objects['statusroute']['patching_rect']=[820,395,85,22]
objects['handroute']['patching_rect']=[820,428,70,22]
objects['art']['patching_rect']=[30,35,808,149]
placed=set(['art','engine','statusroute','handroute'])
placed.update(k for k in objects if k.startswith('left_') or k.startswith('right_'))
# Non-performance controls and OSC output occupy a readable settings block.
remaining=[b for b in objects.values() if b['id'] not in placed]
for n,b in enumerate(remaining):
    w=b['patching_rect'][2];height=b['patching_rect'][3]
    b['patching_rect']=[30+(n%5)*245,850+(n//5)*55,min(w,230),height]
p.update(rect=[70,90,1310,790],enablehscroll=1,enablevscroll=1)
data=json.dumps({'patcher':p},indent=2,ensure_ascii=False).encode('utf-8')
(ROOT/'Glove_Receiver_Dual.maxpat').write_bytes(data)
payload=json.dumps({'patcher':p},separators=(',',':'),ensure_ascii=False).encode('utf-8')+b'\x00'
header=b'ampf'+struct.pack('<I',4)+b'aaaa'+b'meta'+struct.pack('<I',4)+struct.pack('<I',1)+b'ptch'+struct.pack('<I',len(payload))
(ROOT/'Glove_Receiver_Dual.amxd').write_bytes(header+payload)
print(f'Built {len(p["boxes"])} top-level objects and ten embedded native Live mapping modules.')
