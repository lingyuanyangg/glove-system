#!/usr/bin/env python3
import json,struct
from pathlib import Path
root=Path(__file__).resolve().parents[1]
p=json.loads((root/'Glove_Mapper.maxpat').read_text())['patcher']
maps=[];names=[]
def walk(p):
    ids={o['box']['id']:o['box'] for o in p['boxes']};assert len(ids)==len(p['boxes'])
    for o in p['lines']:
        for end,count in [('source','numoutlets'),('destination','numinlets')]:
            id,i=o['patchline'][end];assert id in ids
            if count in ids[id]:assert 0<=i<ids[id][count]
    for b in ids.values():
        if b.get('text','').startswith('live.map'):maps.append(b)
        v=b.get('saved_attribute_attributes',{}).get('valueof')
        if b.get('parameter_enable') and v:names.append(v['parameter_longname'])
        if 'patcher' in b:walk(b['patcher'])
walk(p);assert len(maps)==10 and len(names)==len(set(names))
assert all(b['saved_object_attributes']['_persistence']==1 for b in maps)
ids={o['box']['id']:o['box'] for o in p['boxes']}
links={(tuple(l['patchline']['source']),tuple(l['patchline']['destination'])) for l in p['lines']}
assert not any('udpreceive' in b.get('text','') or b.get('text','').startswith('serial ') for b in ids.values())
for h,name in enumerate(['left','right']):
    assert ids[name+'_receive']['text']=='r G'+name.capitalize()
    assert ids[name+'_control_receive']['text']=='r G'+name.capitalize()+'Control'
    for ch,finger in enumerate(['pinky','ring','middle','index','thumb']):
        n=name+'_'+finger
        for a,o,b,i in [('controller',h,name+'_unpack',0),(name+'_unpack',ch,n+'_signal',0),
            (n+'_signal',0,n+'_map',0),(n+'_map',0,n+'_remote',0),(n+'_map',1,n+'_remote',1),
            ('controller',2+h,name+'_monitor',0),(name+'_monitor',ch,n+'_set',0),(n+'_set',0,n,0)]:
            assert ((a,o),(b,i)) in links
        assert '@normalized 0 @smoothing 0.' in ids[n+'_remote']['text']
        m=ids[n+'_map']['patcher'];mi={o['box']['id']:o['box'] for o in m['boxes']}
        ml={(tuple(l['patchline']['source']),tuple(l['patchline']['destination'])) for l in m['lines']}
        assert mi['mapped_id_and_range']['text']=='t l b' and mi['get_target_range']['text']=='getrange'
        for a,o,b,i in [('obj-3',1,'mapped_id_and_range',0),('mapped_id_and_range',1,'get_target_range',0),('get_target_range',0,'obj-3',0),('mapped_id_and_range',0,'obj-25',0)]:
            assert ((a,o),(b,i)) in ml
        for id in ['obj-45','obj-46']:
            v=mi[id]['saved_attribute_attributes']['valueof'];assert mi[id]['presentation']==1
            assert v['parameter_mmin']==0 and v['parameter_mmax']==100
    assert (('audioin',h),('audioout',h)) in links
visible=[b for b in ids.values() if b.get('presentation')]
for i,b in enumerate(visible):
    x,y,w,h=b['presentation_rect'];assert 0<=x and 0<=y and x+w<=388 and y+h<=169
    for a in visible[i+1:]:
        xx,yy,ww,hh=a['presentation_rect']
        assert min(x+w,xx+ww)<=max(x,xx) or min(y+h,yy+hh)<=max(y,yy),(b['id'],a['id'])
b=(root/'Glove_Mapper.amxd').read_bytes();assert b[:12]==b'ampf\x04\0\0\0aaaa'
assert struct.unpack('<I',b[28:32])[0]==len(b)-32
assert json.loads(b[32:].rstrip(b'\0'))=={'patcher':p}
# Receiver must supply change-driven smoothing ticks independently of fresh training frames.
r=json.loads((root.parent/'receiver-v2/Glove_Receiver_Dual.maxpat').read_text())['patcher']
ri={o['box']['id']:o['box'] for o in r['boxes']}
rl={(tuple(l['patchline']['source']),tuple(l['patchline']['destination'])) for l in r['lines']}
for h,name in enumerate(['left','right']):
    assert ri[name+'_control_send']['text']=='s G'+name.capitalize()+'Control'
    assert (('engine',h),(name+'_control_send',0)) in rl
    assert (('engine',3+h),(name+'_send',0)) in rl
print('PASS 10 persistent native maps, percentage ranges, fast/fresh bus paths, unique parameters, AMXD, stereo, 388 × 169 bounds and no overlap.')
