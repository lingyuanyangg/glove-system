"""Build the Glove Gesture Max for Live audio effect and portable runtime bundle."""
from pathlib import Path
import copy,json,struct,zipfile
ROOT=Path(__file__).resolve().parents[1];D=ROOT/'Glove_Gesture';D.mkdir(exist_ok=True)
NATIVE=Path('/Applications/Max.app/Contents/Resources/C74/packages/Max for Live/patchers/liveui.map.maxpat')
native=json.loads(NATIVE.read_text())['patcher']
(D/'gesture_control.js').write_text('\n'.join((ROOT/'tools'/name).read_text() for name in ['gesture_logic.js','classifier_bridge.js','controller.js']))
icons={n:(ROOT/'assets'/f'{n}.svg').read_text().strip() for n in ['open','fist','index','v','middle','ok']}
(D/'gesture_ui.html').write_text((ROOT/'tools/gesture_ui.template.html').read_text().replace('__GESTURE_ICONS__',json.dumps(icons)))
APP=dict(major=9,minor=1,revision=5,architecture='arm64',modernui=1)
p=dict(fileversion=1,appversion=APP,classnamespace='box',rect=[80,80,1100,900],openinpresentation=1,openrect=[0,0,1000,169],devicewidth=1000,enablehscroll=0,enablevscroll=0,bgcolor=[.16,.16,.16,1],default_fontname='Arial',default_fontsize=11,boxes=[],lines=[],parameters={})
def box(id,text=None,cls='newobj',rect=None,**attrs):
 b=dict(id=id,varname=id,maxclass=cls,patching_rect=rect or [20+len(p['boxes'])%5*200,220+len(p['boxes'])//5*42,190,22])
 if text is not None:b['text']=text
 b.update(attrs);p['boxes'].append({'box':b});return b
def link(a,b,o=0,i=0):p['lines'].append({'patchline':dict(source=[a,o],destination=[b,i])})
def mapping(name):
 m=copy.deepcopy(native);m.update(devicewidth=154,rect=[0,0,154,18],enablehscroll=0,enablevscroll=0)
 ids={x['box']['id']:x['box'] for x in m['boxes']}
 for id in ['obj-48','obj-34']:ids[id].update(presentation_rect=[0,0,138,17],fontsize=9)
 ids['obj-47'].update(presentation_rect=[139,0,15,17],usepicture=0,pictures=[],fontsize=10,text='×',texton='×')
 for id in ['obj-45','obj-46']:ids[id]['presentation']=0
 for id,value in m['parameters'].items():
  if isinstance(value,list):
   value[0]=name+' '+value[1];ids[id]['saved_attribute_attributes']['valueof']['parameter_longname']=value[0]
 return m
box('web',cls='jweb',rect=[0,0,1000,142],presentation=1,presentation_rect=[0,0,1000,142],numinlets=1,numoutlets=1,rendermode=1)
box('controller','js gesture_control.js #0',numinlets=1,numoutlets=4,outlettype=['','','',''])
for i,name in enumerate(['Open hand','Fist','Index','V sign','Middle','OK']):
 m=mapping(name);id='map-'+str(i)
 box(id,cls='bpatcher',patcher=m,presentation=1,presentation_rect=[8+i*165.6666667,146,154,17],numinlets=1,numoutlets=2,outlettype=['signal',''],embed=1,bgmode=2,offset=[0,0])
 for key,val in m['parameters'].items():
  if isinstance(val,list):p['parameters'][id+'::'+key]=val
 box(id+'-prefix','prepend mapped '+str(i));box(id+'-defer','deferlow');link(id,id+'-prefix',1);link(id+'-prefix',id+'-defer');link(id+'-defer','controller')
for id,text,lane in [('classifier-train','fluid.mlpclassifier~ #0-gesture-trainer @hiddenlayers 8 @activation 3 @learnrate 0.01 @momentum 0.9 @batchsize 4 @validation 0 @maxiter 10','nativetrain'),('classifier-infer','fluid.mlpclassifier~ #0-gesture-inference','nativeinfer'),('data-input','fluid.dataset~ #0-gesture-x','nativeinput'),('data-labels','fluid.labelset~ #0-gesture-labels','nativelabels')]:
 box(id,text,numinlets=1,numoutlets=2,outlettype=['','']);box(id+'-prefix','prepend '+lane);box(id+'-defer','deferlow');link(id,id+'-prefix');link(id,id+'-prefix',1);link(id+'-prefix',id+'-defer');link(id+'-defer','controller')
box('input-buffer','buffer~ #0-gesture-input @samps 5',numinlets=1,numoutlets=2)
for hand in ['left','right']:
 box('receive-'+hand,'r G'+hand.capitalize());box('prefix-'+hand,'prepend '+hand);box('defer-'+hand,'deferlow');link('receive-'+hand,'prefix-'+hand);link('prefix-'+hand,'defer-'+hand);link('defer-'+hand,'controller')
box('event-route','route enter exit');link('controller','event-route',1)
for kind in ['enter','exit']:
 box(kind+'-route','route left right both');link('event-route',kind+'-route',0 if kind=='enter' else 1)
 for n,hand in enumerate(['Left','Right','Both']):
  box(kind+'-'+hand+'-prefix','prepend '+kind);box(kind+'-'+hand+'-send','s GGesture'+hand);link(kind+'-route',kind+'-'+hand+'-prefix',n);link(kind+'-'+hand+'-prefix',kind+'-'+hand+'-send')
box('route-ui','route command');box('command-prefix','prepend command');box('defer-ui','deferlow');link('web','route-ui');link('route-ui','command-prefix');link('command-prefix','defer-ui');link('defer-ui','controller');link('controller','web')
box('bank','pattr gesture_bank',numinlets=1,numoutlets=3,restore=[''],saved_object_attributes={'parameter_enable':1},saved_attribute_attributes={'valueof':dict(parameter_longname='Glove Gesture Training Bank',parameter_shortname='Gesture Bank',parameter_type=3,parameter_invisible=1,parameter_linknames=0,parameter_initial_enable=0,parameter_unitstyle=10)})
p['parameters']['bank']=['Glove Gesture Training Bank','Gesture Bank',0]
box('restore-prefix','prepend restore');box('restore-defer','deferlow');link('controller','bank',2);link('bank','restore-prefix');link('restore-prefix','restore-defer');link('restore-defer','controller')
box('host','live.thisdevice');box('host-defer','deferlow');link('host','host-defer');link('host-defer','controller')
box('load','loadbang');box('load-defer','deferlow');box('load-ui','loadbang',cls='message');link('load','load-defer');link('load-defer','load-ui');link('load-ui','controller')
box('colors','live.colors',numinlets=1,numoutlets=2);box('query-colors','everything',cls='message');box('theme-prefix','prepend theme');box('theme-defer','deferlow');link('host','query-colors');link('colors','query-colors',1);link('query-colors','colors');link('colors','theme-prefix');link('theme-prefix','theme-defer');link('theme-defer','controller')
box('dialog-route','route import export help');link('controller','dialog-route',3)
for i,kind in enumerate(['import','export']):
 box(kind+'-dialog','opendialog .json' if kind=='import' else 'savedialog');box(kind+'-prefix','prepend '+('readmodel' if kind=='import' else 'writemodel'));box(kind+'-defer','deferlow');box(kind+'-cancel','dialogcancel '+kind,cls='message');box(kind+'-cancel-defer','deferlow')
 link('dialog-route',kind+'-dialog',i);link(kind+'-dialog',kind+'-prefix');link(kind+'-prefix',kind+'-defer');link(kind+'-defer','controller');link(kind+'-dialog',kind+'-cancel',1);link(kind+'-cancel',kind+'-cancel-defer');link(kind+'-cancel-defer','controller')
helpP=dict(fileversion=1,appversion=APP,classnamespace='box',rect=[180,180,650,600],openinpresentation=1,boxes=[{'box':dict(id='help-web',maxclass='jweb',varname='help-web',patching_rect=[0,0,650,600],presentation=1,presentation_rect=[0,0,650,600],numinlets=1,numoutlets=1,url='')}],lines=[])
box('help','p Gesture_Guide',patcher=helpP);box('help-open','open',cls='message');box('help-control','pcontrol');link('dialog-route','help-open',2);link('help-open','help-control');link('help-control','help')
# A companion path is resolved by the controller at load time, rather than an absolute URL.
box('help-load','js gesture_help_path.js');link('load-defer','help-load');link('help-load','help')
helpP['boxes'].append({'box':dict(id='help-inlet',maxclass='inlet',patching_rect=[10,625,30,30])});helpP['lines'].append({'patchline':dict(source=['help-inlet',0],destination=['help-web',0])})
(D/'gesture_help_path.js').write_text("inlets=1;outlets=1;function bang(){var p=this.patcher.filepath||'',i=p.lastIndexOf('/');outlet(0,'readfile',(i<0?'':p.substring(0,i+1))+'gesture_help.html');}\n")
box('audio-in','plugin~',numinlets=1,numoutlets=2,outlettype=['signal','signal']);box('audio-out','plugout~',numinlets=2,numoutlets=0);link('audio-in','audio-out');link('audio-in','audio-out',1,1)
p['parameters'].update(parameterbanks={},inherited_shortname=1)
p['dependency_cache']=[dict(name=n+'.mxo',type='iLaX') for n in ['fluid.mlpclassifier~','fluid.dataset~','fluid.labelset~']]+[dict(name=n,type='TEXT',implicit=1) for n in ['gesture_control.js','gesture_ui.html','gesture_help.html','gesture_help_path.js']]
raw=json.dumps({'patcher':p},indent=2,ensure_ascii=False).encode();(D/'Glove Gesture.maxpat').write_bytes(raw)
payload=json.dumps({'patcher':p},separators=(',',':'),ensure_ascii=False).encode()+b'\0'
(D/'Glove Gesture.amxd').write_bytes(b'ampf'+struct.pack('<I',4)+b'aaaa'+b'meta'+struct.pack('<II',4,0)+b'ptch'+struct.pack('<I',len(payload))+payload)
with zipfile.ZipFile(ROOT/'Glove Gesture.zip','w',zipfile.ZIP_DEFLATED) as z:
 for n in ['Glove Gesture.amxd','Glove Gesture.maxpat','gesture_control.js','gesture_ui.html','gesture_help.html','gesture_help_path.js']:z.write(D/n,'Glove Gesture/'+n)
 for n in ['README.md','README_中文.md','VALIDATION.md']:
  if (ROOT/n).exists():z.write(ROOT/n,'Glove Gesture/'+n)
 for n in ['gesture-art.png','gesture-art.svg','logic.json','adapter.json','ui.json','native-core.json']:
  if (ROOT/'validation'/n).exists():z.write(ROOT/'validation'/n,'Glove Gesture/validation/'+n)
print('Built Glove Gesture with native FluCoMa classification and six native Live Map components.')
