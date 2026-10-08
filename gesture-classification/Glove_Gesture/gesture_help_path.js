inlets=1;outlets=1;function bang(){var p=this.patcher.filepath||'',i=p.lastIndexOf('/');outlet(0,'readfile',(i<0?'':p.substring(0,i+1))+'gesture_help.html');}
