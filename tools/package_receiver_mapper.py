#!/usr/bin/env python3
"""Package Receiver/Mapper sources and portable releases; verify every archived byte."""
import hashlib,json,shutil,zipfile
from pathlib import Path
REPO=Path(__file__).resolve().parents[1]
def files(folder):
 return sorted(f for f in folder.rglob('*') if f.is_file() and f.name!='.DS_Store' and '__pycache__' not in f.parts and f.suffix!='.pyc')
for name,archive in [('mapper','Glove_Mapper.zip'),('receiver-v2','Glove_Receiver_Dual.zip')]:
 module=REPO/name
 manifest={}
 for f in files(module):
  if f.name in ['release-manifest.json',archive]:continue
  b=f.read_bytes();manifest[str(f.relative_to(module))]={'bytes':len(b),'sha256':hashlib.sha256(b).hexdigest()}
 (module/'release-manifest.json').write_text(json.dumps(manifest,indent=2,ensure_ascii=False)+'\n')
 folders=[module] if name=='mapper' else [module,REPO/'mapper',REPO/'arduino/glove_usb_dual',REPO/'arduino/glove_usb_dual_hardware']
 paths=[f for d in folders for f in files(d) if f.suffix!='.zip']
 paths.extend([REPO/'tools/native_mapping.py',REPO/'tools/package_receiver_mapper.py'])
 if name=='receiver-v2':paths.append(REPO/'tools/build_usb_hardware.py')
 with zipfile.ZipFile(module/archive,'w',zipfile.ZIP_DEFLATED) as z:
  for f in sorted(set(paths)):z.write(f,str(f.relative_to(REPO)))
 with zipfile.ZipFile(module/archive) as z:
  assert z.testzip() is None
  for n in z.namelist():assert z.read(n)==(REPO/n).read_bytes()
 shutil.copy2(module/archive,REPO.parent/archive)
 print('Verified',archive,(module/archive).stat().st_size)
with zipfile.ZipFile(REPO.parent/'Glove_System_GitHub.zip','w',zipfile.ZIP_DEFLATED) as z:
 for f in files(REPO):z.write(f,str(f.relative_to(REPO.parent)))
with zipfile.ZipFile(REPO.parent/'Glove_System_GitHub.zip') as z:
 assert z.testzip() is None
 for n in z.namelist():
  assert Path(n).name!='gloveRegressor10.json'
  assert z.read(n)==(REPO.parent/n).read_bytes()
print('Verified complete GitHub source archive.')
