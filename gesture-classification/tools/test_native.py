"""Build/run a standalone native-core test using existing dependency checkouts.

Requires FluCoMa core tag 1.0.9, Eigen 3.4.0, and built foonathan memory v0.7-3.
Does not install packages or launch Max/Live.
"""
import argparse
import json
from pathlib import Path
import subprocess
import tempfile

parser=argparse.ArgumentParser()
parser.add_argument('--core',type=Path,required=True)
parser.add_argument('--eigen',type=Path,required=True)
parser.add_argument('--memory',type=Path,required=True)
parser.add_argument('--memory-build',type=Path,required=True)
parser.add_argument('--compiler',default='clang++')
args=parser.parse_args()
root=Path(__file__).resolve().parents[1]
libraries=list((args.memory_build/'src').glob('libfoonathan_memory*.a'))
if len(libraries)!=1:raise SystemExit('Expected one built static foonathan memory library in memory-build/src')
with tempfile.TemporaryDirectory(prefix='glove-native-') as directory:
    executable=Path(directory)/'native-test'
    command=[args.compiler,'-std=c++17','-O2',
             '-I'+str(args.core/'include'),'-I'+str(args.eigen),
             '-I'+str(args.memory/'include/foonathan'),'-I'+str(args.memory_build/'src'),
             str(root/'tools/test_native.cpp'),str(libraries[0]),'-o',str(executable)]
    subprocess.run(command,check=True)
    result=json.loads(subprocess.check_output([str(executable)],text=True))
    result['dependencies']={'flucoma_core':'1.0.9','eigen':'3.4.0','foonathan_memory':'0.7-3'}
    (root/'validation/native-core.json').write_text(json.dumps(result,indent=2)+'\n')
    print(str(len(result['checks']))+' native FluCoMa core checks passed; no Max/Live host test')
