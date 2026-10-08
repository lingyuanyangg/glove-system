#!/usr/bin/env python3
import json,struct,hashlib
from pathlib import Path
R=Path(__file__).resolve().parents[1]
p=json.loads((R/'Glove_MIDI_Trigger.maxpat').read_text())['patcher']
b={x['box']['id']:x['box'] for x in p['boxes']};assert len(b)==len(p['boxes'])
links={(tuple(x['patchline']['source']),tuple(x['patchline']['destination'])) for x in p['lines']}
def edge(a,ao,z,zi=0):assert ((a,ao),(z,zi)) in links,(a,ao,z,zi)
for src,dst in links:assert src[0] in b and dst[0] in b
assert p['devicewidth']==984 and p['openinpresentation']==1
controls=[v for v in b.values() if v.get('parameter_enable')==1]
assert len(controls)==106
for x in controls:
 assert x['id'] in p['parameters'];v=x['saved_attribute_attributes']['valueof'];assert v['parameter_initial_enable']==1
 assert v['parameter_mmin']<=v['parameter_initial'][0]<=v['parameter_mmax']
 edge('init',0,x['id']);edge(x['id'],0,x['id']+'_send');edge(x['id']+'_send',0,'engine')
for x in b.values():
 if x.get('presentation'):
  xx,y,w,h=x['presentation_rect'];assert 0<=xx and 0<=y and xx+w<=984 and y+h<=169,x['id']
 assert x['maxclass'] not in ['jweb','jsui','live.remote~']
edge('device',1,'device_state');edge('device_state',0,'engine');edge('free',0,'stop');edge('stop',0,'engine')
edge('midiin',0,'engine',1);edge('engine',0,'midiout')
for h in ['Left','Right']:
 assert b[h+'_receive']['text']=='r G'+h
 assert not any('G'+h+'Control' in str(x.get('text','')) for x in b.values())
 edge(h+'_receive',0,h+'_input');edge(h+'_input',0,'engine')
edge('engine',2,'reference_route');edge('reference_route',0,'reference_set');edge('reference_set',0,'reference')
assert b['reference_set']['text']=='prepend set'
assert p['dependency_cache'][0]['name']=='glove_midi_trigger.js'
raw=(R/'Glove_MIDI_Trigger.amxd').read_bytes();assert raw[:12]==b'ampf'+struct.pack('<I',4)+b'mmmm'
assert raw[12:24]==b'meta'+struct.pack('<I',4)+struct.pack('<I',1)
assert raw[24:28]==b'ptch' and struct.unpack('<I',raw[28:32])[0]==len(raw)-32 and raw[-1:]==b'\0'
assert json.loads(raw[32:-1])['patcher']==p
print('Patch checks passed: MIDI envelope, 106 native controls, both fresh inputs, calibration recall wiring, lifecycle, all UI bounds.')
