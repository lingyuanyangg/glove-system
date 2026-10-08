#!/usr/bin/env python3
"""Build a dual-hand Max for Live audio effect; retain the original device."""
import json, struct
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
APP = dict(major=9, minor=1, revision=3, architecture="arm64", modernui=1)

def patch():
    return dict(fileversion=1, appversion=APP, classnamespace='box',
                rect=[70,90,1110,780], openinpresentation=1,
                default_fontsize=11, default_fontname='Arial',
                devicewidth=648, enablehscroll=0, enablevscroll=0,
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

box('art','jsui',pres=[0,0,648,122],rect=[20,40,648,122],filename='glove_hands.js',
    numinlets=1,numoutlets=0,jsarguments=['glove_hands.js'],ignoreclick=1,
    border=0,parameter_enable=0,background=1)
label('left_title','GLOVE  /  LEFT',[8,3,109,17],10)
label('right_title','GLOVE  /  RIGHT',[332,3,109,17],10)
label('left_port','IN 7000',[120,4,88,15],8)
label('right_port','IN 6000',[444,4,88,15],8)
label('left_status','WAIT',[282,4,36,15],8)['suppressinlet']=0
label('right_status','WAIT',[606,4,36,15],8)['suppressinlet']=0

box('engine',text='js glove_dual_engine.js',rect=[80,360,170,22],
    numinlets=1,numoutlets=7,outlettype=['','','','','','',''],varname='engine')
box('device',text='live.thisdevice',rect=[20,240,95,22])
box('start',text='start',cls='message',rect=[20,278,50,22]);wire('device','start');wire('start','engine')
box('colors',text='live.colors',rect=[680,300,75,22])
box('query_colors','message','everything',rect=[680,268,70,22])
wire('device','query_colors');wire('colors','query_colors',1);wire('query_colors','colors');wire('colors','art')
wire('engine','art',2)
box('statusroute',text='route status calstatus caldata routing',rect=[290,368,210,22]);wire('engine','statusroute',2)
box('handroute',text='route 0 1',rect=[290,404,70,22]);wire('statusroute','handroute')
box('calroute',text='route 0 1');wire('statusroute','calroute',1)
box('caldataroute',text='route 0 1');wire('statusroute','caldataroute',2)
box('calreport',cls='message',text='calreport');wire('device','calreport');wire('calreport','engine')
for h,(name,port,origin,mirrored) in enumerate([('left',7000,8,False),('right',6000,332,True)]):
    labelname=name.capitalize()
    box(name+'_udp',text=f'udpreceive {port}',rect=[40+300*h,210,130,22])
    box(name+'_route',text=f'route /servos /G{labelname}',rect=[40+300*h,245,180,22])
    box(name+'_input_gate',text='gate 1 1',numinlets=2,numoutlets=1,outlettype=[''])
    wire(name+'_udp',name+'_input_gate',0,1);wire(name+'_input_gate',name+'_route')
    for o,kind in enumerate(['raw','norm']):
        id=name+'_'+kind;box(id,text='prepend '+kind+name,rect=[40+300*h+o*130,285,125,22])
        wire(name+'_route',id,o);wire(id,'engine')
    box(name+'_send',text='s G'+labelname,rect=[40+300*h,465,75,22]);wire('engine',name+'_send',3+h)
    box(name+'_control_send',text='s G'+labelname+'Control');wire('engine',name+'_control_send',h)
    box(name+'_monitor_unpack',text='unpack f f f f f',numinlets=1,numoutlets=5,outlettype=['float']*5);wire('engine',name+'_monitor_unpack',5+h)
    box(name+'_statusset',text='prepend set',rect=[290+100*h,439,85,22]);wire('handroute',name+'_statusset',h);wire(name+'_statusset',name+'_status')
    box(name+'_art',text='prepend '+name,rect=[50+300*h,550,95,22]);wire('engine',name+'_art',5+h);wire(name+'_art','art')
    for ch,(finger,x,tip) in enumerate(zip(['Pinky','Ring','Middle','Index','Thumb'],[26,85,144,203,277],[0,0,0,0,0])):
        x=origin+(308-x if mirrored else x)
        id=f'{name}_{finger.lower()}'
        label(id+'_label',finger.upper(),[x-23,27,46,11],8)
        b=param(id,labelname+' '+finger,0.,1.,0.,[x-23,40,46,16],
            annotation='Filtered normalized finger value, from 0 to 1.',
            decimal_places=3,focusbordercolor=[1,.71,.196,1])
        # Native numeric range/format; hidden monitor state is not automated or saved.
        b['saved_attribute_attributes']['valueof']['parameter_invisible']=2
        b.update(ignoreclick=1,parameter_mappable=0)
        setid=id+'_set';box(setid,text='prepend set');wire(name+'_monitor_unpack',setid,ch);wire(setid,id)
    button(name+'_calibrate',labelname+' Calibrate',[216+324*h,4,60,15],mode=0).update(text='Calibrate',texton='Calibrate')
    box(name+'_cal_press',text='t b b');wire(name+'_calibrate',name+'_cal_press')
    wire(name+'_cal_press','calreport',1)
    box(name+'_cal_open',cls='message',text='open');wire(name+'_cal_press',name+'_cal_open')
    box(name+'_cal_control',text='pcontrol');wire(name+'_cal_open',name+'_cal_control')
    main_patch=p
    p=patch();p.update(rect=[120,160,440,222],devicewidth=440)
    label('cal_title',labelname.upper()+' HAND  /  CALIBRATION',[10,7,420,18],11)
    label('cal_hint','Hold each pose still for 0.3 seconds before capturing.',[10,29,420,16],10)
    for id,title,x,command in [('open','Open → 0',10,f'capture {h} open'),
                              ('fist','Fist → 0.9',150,f'capture {h} fist'),
                              ('clear','Reset',290,f'clearcal {h}')]:
        button('cal_'+id,labelname+' Calibration '+id,[x,51,130,22],mode=0).update(text=title,texton=title)
        box('cal_'+id+'_bang',text='t b');wire('cal_'+id,'cal_'+id+'_bang')
        box('cal_'+id+'_command',cls='message',text=command);wire('cal_'+id+'_bang','cal_'+id+'_command')
        wire('cal_'+id+'_command','cal_output')
    label('cal_status','Default range. Capture Open and Fist.',[10,80,420,17],10)
    label('cal_headroom','Fist = 0.900; extra bend may rise to 1.000.',[10,102,420,16],10)
    label('input_label','Input: no data',[10,124,420,16],10)
    label('raw_row_label','Input',[10,161,65,17],9)
    label('open_label','Open saved',[10,181,75,17],9)
    label('fist_label','Fist saved',[10,201,75,17],9)
    for ch,finger in enumerate(['PINKY','RING','MIDDLE','INDEX','THUMB']):
        label('inspect_finger_'+str(ch),finger,[95+64*ch,145,62,12],8)
        for row,y in [('input',161),('open',181),('fist',201)]:
            label(row+str(ch),'—',[95+64*ch,y,62,17],10)
    inspect_keys=['input_label','open_label','fist_label']+[row+str(ch) for row in ['input','open','fist'] for ch in range(5)]
    box('cal_input','inlet',numinlets=0,numoutlets=1)
    box('cal_data_route',text='route '+' '.join(inspect_keys),numinlets=1,numoutlets=len(inspect_keys)+1,outlettype=['']*(len(inspect_keys)+1))
    wire('cal_input','cal_data_route')
    for i,key in enumerate(inspect_keys):
        box(key+'_set',text='prepend set');wire('cal_data_route',key+'_set',i);wire(key+'_set',key)
    wire('cal_data_route','cal_status',len(inspect_keys))
    box('cal_output','outlet',numinlets=1,numoutlets=0)
    calibration_patch=p;p=main_patch
    popup=name+'_calibration'
    box(popup,text='p '+labelname+'_Calibration',patcher=calibration_patch,
        numinlets=1,numoutlets=1,outlettype=[''],varname=popup)
    for k,v in calibration_patch['parameters'].items():
        if isinstance(v,list):p['parameters'][popup+'::'+k]=v
    wire(name+'_cal_control',popup);wire(popup,'engine')
    box(name+'_cal_statusset',text='prepend set');wire('calroute',name+'_cal_statusset',h);wire(name+'_cal_statusset',popup)
    wire('caldataroute',popup,h)

box('calibration_state',text='pattr hand_calibration @bindto engine @initial none',
    varname='hand_calibration',parameter_enable=1,
    saved_attribute_attributes={'valueof':dict(parameter_longname='Hand Calibration',
        parameter_shortname='Calibration',parameter_type=3,parameter_invisible=1,
        parameter_initial=['none'],parameter_initial_enable=1)})
p['parameters']['calibration_state']=['Hand Calibration','Calibration',0]

button('filter_enabled','Stabilize',[8,127,54,16],1)
label('smooth_label','Smooth',[72,126,39,17]);param('smooth_ms','Smooth ms',0,500,8,[113,127,46,16],unit=2)
label('dead_label','Deadband',[169,126,48,17]);param('deadband','Deadband',0,.1,.003,[222,127,52,16],decimal_places=3)
for id,selector in [('filter_enabled','enabled'),('smooth_ms','smooth'),('deadband','deadband')]:
    box(id+'_prepend',text='prepend '+selector);wire(id,id+'_prepend');wire(id+'_prepend','engine')
button('osc_enable','OSC Out',[8,150,51,16],0)
label('ip_label','IP',[69,149,15,17])
box('osc_host','textedit',pres=[88,149,174,17],text='127.0.0.1',varname='osc_host',
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
label('port_label','Port',[274,149,24,17]);param('osc_port','OSC Port',1,65535,8000,[302,150,58,16],unit=0,integer=True)
button('apply','Apply',[370,150,46,16],mode=0)

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
label('bus_hint','GLeft / GRight  →  Glove Mapper',[436,149,204,17],8)
# Keep the Live presentation within its fixed 169px height; USB settings use a separate window.
label('input_label','Input',[436,126,31,17])
b=box('input_mode','live.menu',pres=[471,127,63,16],varname='input_mode',
    numinlets=1,numoutlets=3,outlettype=['int','','float'],parameter_enable=1,fontsize=10)
b['saved_attribute_attributes']={'valueof':dict(parameter_longname='Input Mode',
    parameter_shortname='Input',parameter_type=2,parameter_enum=['OSC','USB'],
    parameter_mmax=1,parameter_initial=[0],parameter_initial_enable=1,parameter_invisible=1)}
p['parameters']['input_mode']=['Input Mode','Input',0]
button('usb_setup','USB…',[544,127,96,16],mode=0)
box('usb_setup_press',text='t b');wire('usb_setup','usb_setup_press')
box('usb_setup_open',cls='message',text='open');wire('usb_setup_press','usb_setup_open')
box('usb_setup_control',text='pcontrol');wire('usb_setup_open','usb_setup_control')
main_patch=p
p=patch();p.update(rect=[120,160,580,80],devicewidth=580,enablehscroll=0,enablevscroll=0)
label('usb_port_label','Port',[8,7,26,18])
box('usb_ports','umenu',pres=[40,8,286,18],varname='usb_ports',
    numinlets=1,numoutlets=3,outlettype=['int','',''],items=['Choose USB port'],
    parameter_enable=0,fontsize=10,allowdrag=0,
    saved_attribute_attributes={'bgfillcolor':{'expression':'themecolor.live_lcd_bg'},
        'textcolor':{'expression':'themecolor.live_lcd_control_fg'}})
button('usb_refresh','Refresh',[334,8,57,18],mode=0)
button('usb_connect','Open',[399,8,50,18],mode=0)
button('usb_close','Close',[457,8,50,18],mode=0)
button('swap_hands','Swap L/R',[515,8,57,18],default=0)
label('usb_hint','115200 · 8N1 · Close Arduino Serial Monitor before Open',[8,33,564,16])
label('usb_status','OSC · USB closed',[8,55,564,18],10)
for i,target in enumerate(['usb_ports','usb_status']):
    box('usb_in_'+str(i),'inlet',rect=[20+i*60,110,25,25],numinlets=0,numoutlets=1)
    wire('usb_in_'+str(i),target)
for i,source in enumerate(['usb_ports','usb_refresh','usb_connect','usb_close','swap_hands']):
    box('usb_out_'+str(i),'outlet',rect=[20+i*60,280,25,25],numinlets=1,numoutlets=0)
    wire(source,'usb_out_'+str(i))
for i,b in enumerate([o['box'] for o in p['boxes'] if o['box'].get('presentation')]):
    b['patching_rect']=[20+(i%3)*190,150+(i//3)*32, min(b['presentation_rect'][2],180),b['presentation_rect'][3]]
usb_patch=p;p=main_patch
box('usb_settings',text='p USB_Settings',patcher=usb_patch,
    numinlets=2,numoutlets=5,outlettype=['int','','','','int'],varname='usb_settings')
for k,v in usb_patch['parameters'].items():
    if isinstance(v,list):p['parameters']['usb_settings::'+k]=v
wire('usb_setup_control','usb_settings')
box('usb_controller',text='js glove_usb_serial.js',varname='usb_controller',
    numinlets=1,numoutlets=7,outlettype=['','','','','','',''])
box('swap_command',text='prepend swaphands');wire('usb_settings','swap_command',4);wire('swap_command','engine')
box('swap_title',text='prepend routeswap');wire('statusroute','swap_title',3);wire('swap_title','usb_controller')
box('serial',text='serial @baud 115200 @autoopen 0 @poll 0 @asyncread 1 @bufsize 2048 @chunk 0 @defer 0 @xonxoff 0',
    numinlets=1,numoutlets=2,outlettype=['int',''])
wire('usb_controller','serial')
# serial reports read N before the N bytes. Native grouping avoids one JS call
# per byte; defer complete lists FIFO only after grouping, preserving byte order.
box('serial_group',text='zl group 1 @zlmaxsize 2048',numinlets=2,numoutlets=2,outlettype=['',''])
box('serial_route',text='route read',numinlets=1,numoutlets=2,outlettype=['',''])
box('serial_read_setup',text='t i b',numinlets=1,numoutlets=2,outlettype=['int','bang'])
box('serial_group_clear',cls='message',text='zlclear',numinlets=2,numoutlets=1,outlettype=[''])
box('serial_group_size',text='max 1',numinlets=2,numoutlets=1,outlettype=['int'])
box('serial_batch_defer',text='deferlow',numinlets=1,numoutlets=1,outlettype=[''])
box('serial_info_defer',text='deferlow',numinlets=1,numoutlets=1,outlettype=[''])
box('serial_info',text='prepend serialinfo',numinlets=1,numoutlets=1,outlettype=[''])
wire('serial','serial_group',0,0);wire('serial','serial_route',1)
wire('serial_route','serial_read_setup',0);wire('serial_read_setup','serial_group_clear',1)
wire('serial_group_clear','serial_group');wire('serial_read_setup','serial_group_size',0)
wire('serial_group_size','serial_group',0,1)
wire('serial_group','serial_batch_defer');wire('serial_batch_defer','usb_controller')
wire('serial_route','serial_info',1);wire('serial_info','serial_info_defer');wire('serial_info_defer','usb_controller')
wire('usb_controller','engine',1)
for name in ['left','right']:wire('usb_controller',name+'_input_gate',2)
wire('usb_controller','usb_settings',3,0)
wire('usb_controller','usb_settings',4,1)
wire('usb_controller','left_port',5);wire('usb_controller','right_port',6)
box('input_mode_command',text='prepend mode');wire('input_mode','input_mode_command');wire('input_mode_command','usb_controller')
for o,selector in enumerate(['chooseport','refresh','connect','disconnect']):
    id='usb_'+selector+'_command';box(id,text='prepend '+selector)
    wire('usb_settings',id,o);wire(id,'usb_controller')
box('usb_init',cls='message',text='init');box('usb_init_defer',text='deferlow')
wire('device','usb_init_defer');wire('usb_init_defer','usb_init');wire('usb_init','usb_controller')
box('usb_saved_port',text='pattr usb_port_name @bindto usb_controller @initial none',
    varname='usb_port_name',parameter_enable=1,
    saved_attribute_attributes={'valueof':dict(parameter_longname='USB Port Name',
        parameter_shortname='USB Port',parameter_type=3,parameter_invisible=1,
        parameter_initial=['none'],parameter_initial_enable=1)})
p['parameters']['usb_saved_port']=['USB Port Name','USB Port',0]
p['parameters']['parameterbanks']={'0':dict(index=0,name='Receiver',parameters=['smooth_ms','deadband','filter_enabled','osc_enable','osc_port','-','-','-'])}
p['parameters']['inherited_shortname']=1
p['dependency_cache']=[dict(name=f,bootpath='.',patcherrelativepath='.',type='TEXT',implicit=1) for f in ['glove_dual_engine.js','glove_hands.js','glove_usb_serial.js']]
p['autosave']=0
# Arrange the editable graph separately from the compact performance presentation.
objects={o['box']['id']:o['box'] for o in p['boxes']}
for h,name in enumerate(['left','right']):
    x=30+h*660
    positions={name+'_udp':[x,250,130,22],name+'_route':[x,290,210,22],
        name+'_input_gate':[x+220,250,80,22],
        name+'_raw':[x,330,120,22],name+'_norm':[x+170,330,125,22],
        name+'_send':[x,440,80,22],
        name+'_monitor_unpack':[x,800,555,22],
        name+'_art':[x+130,440,90,22],name+'_statusset':[x+250,440,95,22]}
    for k,v in positions.items():objects[k]['patching_rect']=v
    for ch,finger in enumerate(['pinky','ring','middle','index','thumb']):
        id=name+'_'+finger;cx=x+ch*112
        positions={id+'_label':[cx,540,90,14],id+'_set':[cx,565,90,22],
          id:[cx,602,46,16]}
        for k,v in positions.items():objects[k]['patching_rect']=v
objects['engine']['patching_rect']=[355,390,195,22]
objects['statusroute']['patching_rect']=[820,395,85,22]
objects['handroute']['patching_rect']=[820,428,70,22]
objects['art']['patching_rect']=[30,35,648,122]
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
print(f'Built compact 648 × 169 receiver: {len(p["boxes"])} objects, no mapping modules.')
