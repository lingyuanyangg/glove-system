"""Embedded Cycling 74 liveui.map with compact native Min/Max controls."""
import copy,json
from pathlib import Path
NATIVE = Path('/Applications/Max.app/Contents/Resources/C74/packages/Max for Live/patchers/liveui.map.maxpat')
native=json.loads(NATIVE.read_text())['patcher']
# Embed the native Live UI implementation; customize only presentation/name metadata.
def mapping(name):
    m=copy.deepcopy(native);m.update(devicewidth=60,rect=[0,0,60,40],enablehscroll=0,enablevscroll=0)
    ids={o['box']['id']:o['box'] for o in m['boxes']}
    for id in ('obj-48','obj-34'): ids[id]['presentation_rect']=[0,0,46,14]
    ids['obj-47'].update(presentation_rect=[47,0,13,14],usepicture=0,pictures=[],fontsize=9,text='×',texton='×')
    ids['obj-48']['fontsize']=9
    for id,x in [('obj-46',0),('obj-45',31)]:
        ids[id].update(presentation=1,presentation_rect=[x,24,29,15],fontsize=9,appearance=0)
        ids[id]['saved_attribute_attributes']['valueof']['parameter_mmin']=0.
    m['boxes'].insert(0,{'box':dict(id='range_label_background',maxclass='panel',
        numinlets=1,numoutlets=0,patching_rect=[0,15,60,9],presentation=1,
        presentation_rect=[0,15,60,9],background=1,border=0,rounded=0,
        saved_attribute_attributes={'bgcolor':{'expression':'themecolor.live_lcd_bg'}})})
    for id,x,text in [('range_min_label',0,'MIN'),('range_max_label',31,'MAX')]:
        m['boxes'].append({'box':dict(id=id,maxclass='live.comment',text=text,
            fontsize=7,numinlets=1,numoutlets=0,patching_rect=[x,16,29,8],
            presentation=1,presentation_rect=[x,16,29,8])})
    for id,data in list(m['parameters'].items()):
        if not isinstance(data,list):continue
        unique=name+' '+data[1]
        data[0]=unique
        ids[id]['saved_attribute_attributes']['valueof']['parameter_longname']=unique
    # live.map dumpout returns range on getrange. Query it before passing the
    # mapped ID downstream, including Set recall and target reassignment.
    m['boxes'].extend([
        {'box':dict(id='mapped_id_and_range',maxclass='newobj',text='t l b',
            numinlets=1,numoutlets=2,outlettype=['list','bang'],patching_rect=[310,340,50,22])},
        {'box':dict(id='get_target_range',maxclass='message',text='getrange',
            numinlets=2,numoutlets=1,outlettype=[''],patching_rect=[375,340,60,22])}])
    for o in m['lines']:
        l=o['patchline']
        if l['source']==['obj-3',1] and l['destination']==['obj-25',0]:
            l['destination']=['mapped_id_and_range',0]
    for source,destination in [(['mapped_id_and_range',1],['get_target_range',0]),
        (['get_target_range',0],['obj-3',0]),(['mapped_id_and_range',0],['obj-25',0])]:
        m['lines'].append({'patchline':dict(source=source,destination=destination)})
    def shorten(sub):
        for o in sub['boxes']:
            b=o['box']
            if b.get('text')=='zl slice 12':b['text']='zl slice 5'
            if 'patcher' in b:shorten(b['patcher'])
    shorten(m)
    return m

