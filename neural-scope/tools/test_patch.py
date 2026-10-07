import json,struct,hashlib
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1];D=ROOT/'Glove_Neural_Scope'
p=json.loads((D/'Glove Neural Scope.maxpat').read_text())['patcher'];count=0
def walk(p):
    global count
    ids={o['box']['id']:o['box'] for o in p['boxes']};assert len(ids)==len(p['boxes'])
    for o in p['lines']:
        l=o['patchline']
        for end,n in [('source','numoutlets'),('destination','numinlets')]:
            k,i=l[end];assert k in ids
            if n in ids[k]:assert 0<=i<ids[k][n],str(l)
    for b in ids.values():
        if b.get('text','').startswith('live.remote~'):count+=1
        if 'patcher' in b:walk(b['patcher'])
walk(p);assert count==256
ids={o['box']['id']:o['box'] for o in p['boxes']}
assert ids['receive-left']['text']=='r GLeft';assert ids['receive-right']['text']=='r GRight';assert ids['colors']['text']=='live.colors'
assert ids['bank']['saved_attribute_attributes']['valueof']['parameter_type']==3
assert ids['web']['presentation_rect']==[0,0,1060,169]
lines={(tuple(l['patchline']['source']),tuple(l['patchline']['destination'])) for l in p['lines']}
assert (('audio-in',0),('audio-out',0)) in lines and (('audio-in',1),('audio-out',1)) in lines
b=(D/'Glove Neural Scope.amxd').read_bytes();assert b[:4]==b'ampf' and b[8:12]==b'aaaa' and b[24:28]==b'ptch'
assert len(b)-32==struct.unpack('<I',b[28:32])[0];assert json.loads(b[32:].rstrip(b'\0'))=={'patcher':p}
assert (D/'neural_scope_control.js').read_text()==(ROOT/'tools/neural_core.js').read_text()+'\n'+(ROOT/'tools/live_adapter.js').read_text()
for dep in p['dependency_cache']:assert '/' not in dep['name'] and (D/dep['name']).exists()
assert not (D/'gloveRegressor10.json').exists()
assert ids['controller']['numoutlets']==4
assert ids['import-dialog']['text']=='opendialog .json'
assert ids['export-dialog']['text']=='savedialog'
assert (('controller',3),('route-dialog',0)) in lines
print('PASS recursive patch links, 256 fixed remotes, stereo, dual bus inputs, Live theme and Blob bridges,')
print('     compact dimensions, portable assets, no bundled preset, native import/export dialogs and exact AMXD/source equality')
