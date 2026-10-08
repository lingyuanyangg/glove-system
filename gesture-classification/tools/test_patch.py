from pathlib import Path
import json,struct,zipfile,xml.etree.ElementTree as E
ROOT=Path(__file__).resolve().parents[1];D=ROOT/'Glove_Gesture'
p=json.loads((D/'Glove Gesture.maxpat').read_text())['patcher']
amxd=(D/'Glove Gesture.amxd').read_bytes();assert amxd[:4]==b'ampf' and amxd[8:12]==b'aaaa' and amxd[24:28]==b'ptch'
size=struct.unpack('<I',amxd[28:32])[0];assert len(amxd)==32+size
assert json.loads(amxd[32:-1])['patcher']==p
def walk(p):
 ids={b['box']['id']:b['box'] for b in p['boxes']};assert len(ids)==len(p['boxes'])
 for x in p['lines']:
  l=x['patchline'];assert l['source'][0] in ids and l['destination'][0] in ids
 for b in ids.values():
  yield b
  if 'patcher' in b:yield from walk(b['patcher'])
allboxes=list(walk(p));maps=[b for b in allboxes if b.get('text','').startswith('live.map')];assert len(maps)==6 and all(b['saved_object_attributes']['_persistence']==1 for b in maps)
ids={x['box']['id']:x['box'] for x in p['boxes']};assert sum(b.get('text','').startswith('fluid.mlpclassifier~') for b in allboxes)==2
assert sum(b.get('text','').startswith('fluid.labelset~') for b in allboxes)==1
assert ids['receive-left']['text']=='r GLeft' and ids['receive-right']['text']=='r GRight'
assert not any('live.remote~' in b.get('text','') for b in allboxes)
lines={(tuple(x['patchline']['source']),tuple(x['patchline']['destination'])) for x in p['lines']}
assert (('audio-in',0),('audio-out',0)) in lines and (('audio-in',1),('audio-out',1)) in lines
for id in ['classifier-train','classifier-infer','data-input','data-labels']:
 assert ((id,0),(id+'-prefix',0)) in lines and ((id,1),(id+'-prefix',0)) in lines
for i in range(6):
 assert ids['map-'+str(i)]['embed']==1
 assert (('map-'+str(i),1),('map-'+str(i)+'-prefix',0)) in lines
for hand in ['Left','Right','Both']:assert ids['enter-'+hand+'-send']['text']=='s GGesture'+hand
paramnames=[v[0] for v in p['parameters'].values() if isinstance(v,list)];assert len(paramnames)==len(set(paramnames))
for b in allboxes:
 if b.get('presentation') and b in ids.values():
  x,y,w,h=b['presentation_rect'];assert x>=0 and y>=0 and x+w<=1000.001 and y+h<=169
for n in ['open','fist','index','v','middle','ok']:E.parse(ROOT/'assets'/f'{n}.svg')
js=(D/'gesture_control.js').read_text();assert js=='\n'.join((ROOT/'tools'/n).read_text() for n in ['gesture_logic.js','classifier_bridge.js','controller.js'])
with zipfile.ZipFile(ROOT/'Glove Gesture.zip') as z:
 for n in ['Glove Gesture.amxd','Glove Gesture.maxpat','gesture_control.js','gesture_ui.html','gesture_help.html','gesture_help_path.js']:assert z.read('Glove Gesture/'+n)==(D/n).read_bytes()
print('PASS: AMXD/source, six persistent native maps, native classifier outlets, gesture buses, stereo audio and portable companions.')
