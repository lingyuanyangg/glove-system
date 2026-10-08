#!/usr/bin/env python3
"""Produce and verify portable MIDI and complete source ZIPs, then install the module."""
import hashlib,json,shutil,zipfile
from pathlib import Path
MODULE=Path(__file__).resolve().parents[1];REPO=MODULE.parent
ARCHIVE='Glove_MIDI_Trigger.zip'
def files(root):
 return sorted(f for f in root.rglob('*') if f.is_file() and f.name!='.DS_Store' and '__pycache__' not in f.parts and f.suffix!='.pyc')
manifest={}
for f in files(MODULE):
 if f.name in [ARCHIVE,'release-manifest.json']:continue
 data=f.read_bytes();manifest[str(f.relative_to(MODULE))]={'bytes':len(data),'sha256':hashlib.sha256(data).hexdigest()}
(MODULE/'release-manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
with zipfile.ZipFile(MODULE/ARCHIVE,'w',zipfile.ZIP_DEFLATED) as z:
 for f in files(MODULE):
  if f.name!=ARCHIVE:z.write(f,str(f.relative_to(REPO)))
with zipfile.ZipFile(MODULE/ARCHIVE) as z:
 assert z.testzip() is None
 for name in z.namelist():assert z.read(name)==(REPO/name).read_bytes()
shutil.copy2(MODULE/ARCHIVE,REPO.parent/ARCHIVE)
DEST=Path.home()/'Music/Ableton/User Library/Max For Live/LY.M4L/Glove/midi-trigger'
DEST.mkdir(parents=True,exist_ok=True)
for f in files(MODULE):
 target=DEST/f.relative_to(MODULE);target.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(f,target)
for name,row in manifest.items():
 data=(DEST/name).read_bytes();assert len(data)==row['bytes'] and hashlib.sha256(data).hexdigest()==row['sha256']
with zipfile.ZipFile(REPO.parent/'Glove_System_GitHub.zip','w',zipfile.ZIP_DEFLATED) as z:
 for f in files(REPO):z.write(f,str(f.relative_to(REPO.parent)))
with zipfile.ZipFile(REPO.parent/'Glove_System_GitHub.zip') as z:
 assert z.testzip() is None
 for name in z.namelist():
  assert Path(name).name!='gloveRegressor10.json';assert z.read(name)==(REPO.parent/name).read_bytes()
print('Verified MIDI package, installed module manifest, and complete source archive.')
print('Installed:',DEST)
