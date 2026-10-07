from pathlib import Path
import json,struct,zipfile
ROOT=Path(__file__).resolve().parents[1]
D=ROOT/'Glove_Neural_Scope';D.mkdir(exist_ok=True)
(D/'neural_scope_control.js').write_text((ROOT/'tools/neural_core.js').read_text()+'\n'+(ROOT/'tools/live_adapter.js').read_text())
APP=dict(major=9,minor=1,revision=5,architecture='arm64',modernui=1)
p=dict(fileversion=1,appversion=APP,classnamespace='box',rect=[70,70,1060,750],openinpresentation=1,
       openrect=[0,0,1060,169],devicewidth=1060,bgcolor=[.09,.11,.115,1],default_fontname='Arial',default_fontsize=11,boxes=[],lines=[])
def box(id,text=None,cls='newobj',rect=None,**attrs):
    b=dict(id=id,varname=id,maxclass=cls,patching_rect=rect or [20+(len(p['boxes'])%6)*165,220+(len(p['boxes'])//6)*44,155,22])
    if text is not None:b['text']=text
    b.update(attrs);p['boxes'].append({'box':b});return b
def link(a,b,o=0,i=0):p['lines'].append({'patchline':dict(source=[a,o],destination=[b,i])})
box('web',cls='jweb',rect=[0,0,1060,169],presentation=1,presentation_rect=[0,0,1060,169],numinlets=1,numoutlets=1,rendermode=1)
box('controller','js neural_scope_control.js',numinlets=1,numoutlets=4,outlettype=['','','',''])
box('route-dialog','route import export');link('controller','route-dialog',3)
for kind,object_name,prefix in [('import','opendialog .json','readmodel'),('export','savedialog','writemodel')]:
    box(kind+'-dialog',object_name,numinlets=1,numoutlets=2)
    box(kind+'-path','prepend '+prefix);box(kind+'-defer','deferlow')
    box(kind+'-cancel','dialogcancel '+kind,cls='message');box(kind+'-cancel-defer','deferlow')
    link('route-dialog',kind+'-dialog',0 if kind=='import' else 1)
    link(kind+'-dialog',kind+'-path');link(kind+'-path',kind+'-defer');link(kind+'-defer','controller')
    link(kind+'-dialog',kind+'-cancel',1);link(kind+'-cancel',kind+'-cancel-defer');link(kind+'-cancel-defer','controller')
box('bank','pattr neural_bank',numinlets=1,numoutlets=3,restore=[''],
    saved_object_attributes={'parameter_enable':1},saved_attribute_attributes={'valueof':dict(
        parameter_longname='Glove Neural Training Bank',parameter_shortname='Training Bank',parameter_type=3,
        parameter_invisible=1,parameter_linknames=0,parameter_initial_enable=0,parameter_unitstyle=10)})
box('restore-prefix','prepend restore');box('defer-restore','deferlow');link('controller','bank',2);link('bank','restore-prefix');link('restore-prefix','defer-restore');link('defer-restore','controller')
box('host','live.thisdevice');box('defer-host','deferlow');link('host','defer-host');link('defer-host','controller')
box('colors','live.colors',numinlets=1,numoutlets=2)
box('query-colors','everything',cls='message');box('theme-prefix','prepend theme');box('defer-theme','deferlow')
link('host','query-colors');link('colors','query-colors',1);link('query-colors','colors');link('colors','theme-prefix');link('theme-prefix','defer-theme');link('defer-theme','controller')
box('load','loadbang');box('defer-load','deferlow');box('load-ui','loadbang',cls='message');link('load','defer-load');link('defer-load','load-ui');link('load-ui','controller')
box('route-ui','route command');box('command-prefix','prepend command');box('defer-ui','deferlow');link('web','route-ui');link('route-ui','command-prefix');link('command-prefix','defer-ui');link('defer-ui','controller');link('controller','web')
for hand in ['left','right']:
    box('receive-'+hand,'r G'+hand.capitalize());box('prefix-'+hand,'prepend '+hand);box('defer-'+hand,'deferlow')
    link('receive-'+hand,'prefix-'+hand);link('prefix-'+hand,'defer-'+hand);link('defer-'+hand,'controller')
box('to-editor','s ---glove-neural-state');link('controller','to-editor')
box('from-editor','r ---glove-neural-command');link('from-editor','route-ui')
editor=dict(fileversion=1,appversion=APP,classnamespace='box',rect=[100,100,1060,650],openinpresentation=1,bgcolor=p['bgcolor'],boxes=[
    {'box':dict(id='in',maxclass='inlet',patching_rect=[450,670,30,30])},
    {'box':dict(id='editor-web',varname='editor_web',maxclass='jweb',patching_rect=[0,0,1060,650],presentation=1,presentation_rect=[0,0,1060,650],numinlets=1,numoutlets=1,rendermode=1)},
    {'box':dict(id='receive',maxclass='newobj',text='r ---glove-neural-state',patching_rect=[20,670,180,22])},
    {'box':dict(id='send',maxclass='newobj',text='s ---glove-neural-command',patching_rect=[210,670,190,22])}],lines=[
    {'patchline':dict(source=['receive',0],destination=['editor-web',0])},
    {'patchline':dict(source=['editor-web',0],destination=['send',0])}])
box('editor','p Glove_Neural_Editor',patcher=editor);box('editor-control','pcontrol');link('controller','editor-control',1);link('editor-control','editor')
pool=dict(fileversion=1,appversion=APP,classnamespace='box',rect=[100,100,900,650],boxes=[],lines=[])
for n in range(256):
    pool['boxes'].append({'box':dict(id='remote-'+str(n),varname='remote-'+str(n),maxclass='newobj',text='live.remote~ @normalized 0 @smoothing 30',patching_rect=[20+n%4*220,20+n//4*70,210,22],numinlets=2,numoutlets=1)})
    pool['boxes'].append({'box':dict(id='sender-'+str(n),varname='sender-'+str(n),maxclass='newobj',text='prepend id',patching_rect=[20+n%4*220,46+n//4*70,100,22],numinlets=1,numoutlets=1)})
    pool['lines'].append({'patchline':dict(source=['sender-'+str(n),0],destination=['remote-'+str(n),1])})
box('remote-pool','p remote_pool',patcher=pool)
box('audio-in','plugin~',numinlets=1,numoutlets=2,outlettype=['signal','signal']);box('audio-out','plugout~',numinlets=2,numoutlets=0);link('audio-in','audio-out');link('audio-in','audio-out',1,1)
p['parameters']={'bank':['Glove Neural Training Bank','Training Bank',0],'parameterbanks':{},'inherited_shortname':1}
p['dependency_cache']=[dict(name=f,type='TEXT',implicit=1) for f in ['neural_scope_control.js','neural_scope_ui.html']]
raw=json.dumps({'patcher':p},indent=2,ensure_ascii=False).encode();(D/'Glove Neural Scope.maxpat').write_bytes(raw)
payload=json.dumps({'patcher':p},separators=(',',':'),ensure_ascii=False).encode()+b'\0'
(D/'Glove Neural Scope.amxd').write_bytes(b'ampf'+struct.pack('<I',4)+b'aaaa'+b'meta'+struct.pack('<II',4,0)+b'ptch'+struct.pack('<I',len(payload))+payload)
with zipfile.ZipFile(ROOT/'Glove Neural Scope.zip','w',zipfile.ZIP_DEFLATED) as z:
    for name in ['Glove Neural Scope.amxd','Glove Neural Scope.maxpat','neural_scope_control.js','neural_scope_ui.html']:
        z.write(D/name,'Glove Neural Scope/'+name)
    for name in ['README_中文.md','README.md','VALIDATION.md']:
        if(ROOT/name).exists():z.write(ROOT/name,'Glove Neural Scope/'+name)
print('Built Glove Neural Scope with 256 fixed Live remote channels.')
