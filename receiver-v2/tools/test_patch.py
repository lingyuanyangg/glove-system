#!/usr/bin/env python3
import json, struct
from pathlib import Path
root=Path(__file__).resolve().parents[1]
p=json.loads((root/'Glove_Receiver_Dual.maxpat').read_text())['patcher']
native_maps=[];params=[]
def walk(p):
    ids={o['box']['id']:o['box'] for o in p['boxes']}
    assert len(ids)==len(p['boxes'])
    for o in p['lines']:
        l=o['patchline']
        for end,count in [('source','numoutlets'),('destination','numinlets')]:
            id,i=l[end];assert id in ids
            if count in ids[id]: assert 0<=i<ids[id][count],str(l)
    for b in ids.values():
        if b.get('text','').startswith('live.map'):native_maps.append(b)
        v=b.get('saved_attribute_attributes',{}).get('valueof')
        if b.get('parameter_enable') and v:params.append(v['parameter_longname'])
        if 'patcher' in b:walk(b['patcher'])
walk(p);assert len(native_maps)==10
assert all(b['saved_object_attributes']['_persistence']==1 for b in native_maps)
assert len(params)==len(set(params)), 'Live parameter names must be globally unique'
ids={o['box']['id']:o['box'] for o in p['boxes']}
lines={(tuple(l['patchline']['source']),tuple(l['patchline']['destination'])) for l in p['lines']}
for h,name in enumerate(['left','right']):
    assert ids[name+'_udp']['text']=='udpreceive '+str([7000,6000][h])
    assert (('engine',h),(name+'_send',0)) in lines
    assert (('engine',h),(name+'_unpack',0)) in lines
    assert (('engine',h),(name+'_osc_gate',1)) in lines
    assert ids[name+'_send']['text']=='s G'+name.capitalize()
    assert ids[name+'_osc_prefix']['text']=='prepend /G'+name.capitalize()
    for ch,finger in enumerate(['pinky','ring','middle','index','thumb']):
        n=name+'_'+finger
        assert ids[n+'_map']['embed']==1
        assert ((''+name+'_unpack',ch),(n+'_signal',0)) in lines
        assert ((n+'_signal',0),(n+'_remote',0)) in lines
        assert ((n+'_map',1),(n+'_remote',1)) in lines
        assert '@normalized 1' in ids[n+'_remote']['text']
        assert ids[n]['ignoreclick']==1
assert (('audioin',0),('audioout',0)) in lines
assert (('audioin',1),('audioout',1)) in lines
assert ids['osc_port']['saved_attribute_attributes']['valueof']['parameter_type']==0
assert ids['host_state']['saved_attribute_attributes']['valueof']['parameter_type']==3
assert ids['osc_enable']['saved_attribute_attributes']['valueof']['parameter_initial']==[0]
visible=[b for b in ids.values() if b.get('presentation') and b['maxclass']!='jsui']
for b in visible:
    x,y,w,h=b['presentation_rect'];assert x>=0 and y>=0 and x+w<=808 and y+h<=169,b['id']
for i,b in enumerate(visible):
    x,y,w,h=b['presentation_rect']
    for a in visible[i+1:]:
        xx,yy,ww,hh=a['presentation_rect']
        assert min(x+w,xx+ww)-max(x,xx)<=0 or min(y+h,yy+hh)-max(y,yy)<=0,(b['id'],a['id'])
b=(root/'Glove_Receiver_Dual.amxd').read_bytes()
assert b[:12]==b'ampf\x04\x00\x00\x00aaaa'
assert struct.unpack('<I',b[28:32])[0]==len(b)-32
assert json.loads(b[32:].rstrip(b'\0'))=={'patcher':p}
print('PASS: AMXD payload, recursive patch links, unique parameters, 10 persistent native maps,')
print('      dual input/output topology, stereo passthrough and 808 × 169 layout bounds/overlap.')
