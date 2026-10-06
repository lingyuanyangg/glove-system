{
    "patcher": {
        "fileversion": 1,
        "appversion": {
            "major": 9,
            "minor": 1,
            "revision": 3,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [ 211.0, 242.0, 1276.0, 651.0 ],
        "openinpresentation": 1,
        "gridonopen": 2,
        "gridsize": [ 12.0, 12.0 ],
        "gridsnaponopen": 2,
        "objectsnaponopen": 0,
        "boxanimatetime": 0,
        "style": "jx.style",
        "subpatcher_template": "jx.template9",
        "boxes": [
            {
                "box": {
                    "id": "obj-10",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 228.0, 96.0, 57.0, 18.0 ],
                    "text": "loadmess 1."
                }
            },
            {
                "box": {
                    "comment": "",
                    "id": "obj-5",
                    "index": 1,
                    "maxclass": "inlet",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "patching_rect": [ 168.0, 48.0, 30.0, 30.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-32",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 540.0, 264.0, 29.5, 18.0 ],
                    "text": "set •"
                }
            },
            {
                "box": {
                    "id": "obj-29",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 468.0, 288.0, 29.5, 18.0 ],
                    "text": "set"
                }
            },
            {
                "box": {
                    "id": "obj-26",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 3,
                    "outlettype": [ "bang", "bang", "" ],
                    "patching_rect": [ 468.0, 252.0, 40.0, 18.0 ],
                    "text": "sel 0 1"
                }
            },
            {
                "box": {
                    "id": "obj-25",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 468.0, 216.0, 29.5, 18.0 ],
                    "text": "!= 0"
                }
            },
            {
                "box": {
                    "id": "obj-23",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 468.0, 324.0, 15.0, 16.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 3.000000089406967, -2.0000000596046448, 15.0, 16.0 ],
                    "text": "•"
                }
            },
            {
                "box": {
                    "bgcolor": [ 0.3686274509803922, 0.3686274509803922, 0.3686274509803922, 0.97 ],
                    "contdata": 1,
                    "hint": "2-Reaktor 6 >> Reaktor 6 >> P0039",
                    "id": "obj-28",
                    "maxclass": "multislider",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "orientation": 0,
                    "outlettype": [ "", "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 144.0, 288.0, 96.0, 12.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 72.0, 0.0, 96.0, 12.0 ],
                    "setminmax": [ 0.0, 100.0 ],
                    "setstyle": 1,
                    "slidercolor": [ 0.7411764705882353, 0.45098039215686275, 0.29411764705882354, 1.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-37",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 84.0, 120.0, 19.0, 18.0 ],
                    "text": "t i"
                }
            },
            {
                "box": {
                    "id": "obj-34",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 168.0, 204.0, 77.0, 18.0 ],
                    "text": "join @triggers -1"
                }
            },
            {
                "box": {
                    "attr": "setminmax",
                    "id": "obj-31",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 167.8571412563324, 228.0, 156.1428587436676, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 180.0, 0.0, 156.0, 18.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-22",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 348.0, 228.0, 43.0, 18.0 ],
                    "text": "deferlow"
                }
            },
            {
                "box": {
                    "id": "obj-9",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "", "", "" ],
                    "patcher": {
                        "fileversion": 1,
                        "appversion": {
                            "major": 9,
                            "minor": 1,
                            "revision": 3,
                            "architecture": "x64",
                            "modernui": 1
                        },
                        "classnamespace": "box",
                        "rect": [ 160.0, 180.0, 950.0, 677.0 ],
                        "gridonopen": 2,
                        "gridsize": [ 12.0, 12.0 ],
                        "gridsnaponopen": 2,
                        "objectsnaponopen": 0,
                        "boxanimatetime": 0,
                        "style": "jx.style",
                        "subpatcher_template": "jx.template9",
                        "boxes": [
                            {
                                "box": {
                                    "id": "obj-4",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 120.0, 492.0, 45.0, 18.0 ],
                                    "text": "tosymbol"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-3",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 48.0, 516.0, 24.0, 24.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-2",
                                    "index": 2,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 84.0, 516.0, 24.0, 24.0 ]
                                }
                            },
                            {
                                "box": {
                                    "arrows": 1,
                                    "id": "obj-1",
                                    "justification": 1,
                                    "linecolor": [ 0.19999997317791, 0.199999943375587, 0.19999997317791, 1.0 ],
                                    "maxclass": "live.line",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 192.0, 324.0, 84.0, 12.0 ],
                                    "prototypename": "jx.->",
                                    "saved_attribute_attributes": {
                                        "linecolor": {
                                            "expression": ""
                                        }
                                    }
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-7",
                                    "linecount": 3,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 276.0, 312.0, 168.0, 36.0 ],
                                    "text": "when a control in mixer device is chosen, the name value is non existent; type reports: MixerDevice"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-5",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 168.0, 324.0, 19.0, 18.0 ],
                                    "text": "t l"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-121",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 120.0, 468.0, 113.0, 18.0 ],
                                    "text": "sprintf %s >> %s >> %s"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-119",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 120.0, 444.0, 85.0, 18.0 ],
                                    "text": "join 3 @triggers -1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-116",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 156.0, 348.0, 111.0, 16.0 ],
                                    "text": "parent of device is track"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-115",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 156.0, 216.0, 174.0, 16.0 ],
                                    "text": "parent of param is device or MixerDevice"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-107",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 120.0, 420.0, 55.0, 18.0 ],
                                    "text": "route name"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-109",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 120.0, 324.0, 43.0, 18.0 ],
                                    "text": "deferlow"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-111",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 120.0, 372.0, 47.0, 18.0 ],
                                    "text": "get name"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-112",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "bang", "" ],
                                    "patching_rect": [ 120.0, 348.0, 29.5, 18.0 ],
                                    "text": "t b l"
                                }
                            },
                            {
                                "box": {
                                    "color": [ 0.925490196078431, 0.72156862745098, 0.780392156862745, 1.0 ],
                                    "id": "obj-113",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 120.0, 396.0, 50.0, 18.0 ],
                                    "saved_object_attributes": {
                                        "_persistence": 1
                                    },
                                    "text": "live.object"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-106",
                                    "maxclass": "newobj",
                                    "numinlets": 4,
                                    "numoutlets": 4,
                                    "outlettype": [ "", "", "", "" ],
                                    "patching_rect": [ 120.0, 288.0, 147.0, 18.0 ],
                                    "text": "route canonical_parent name type"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-101",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 120.0, 192.0, 43.0, 18.0 ],
                                    "text": "deferlow"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-103",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 120.0, 240.0, 173.0, 18.0 ],
                                    "text": "gettype, get name, get canonical_parent"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-104",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "bang", "" ],
                                    "patching_rect": [ 120.0, 216.0, 29.5, 18.0 ],
                                    "text": "t b l"
                                }
                            },
                            {
                                "box": {
                                    "color": [ 0.925490196078431, 0.72156862745098, 0.780392156862745, 1.0 ],
                                    "id": "obj-105",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 120.0, 264.0, 50.0, 18.0 ],
                                    "saved_object_attributes": {
                                        "_persistence": 1
                                    },
                                    "text": "live.object"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-92",
                                    "maxclass": "newobj",
                                    "numinlets": 5,
                                    "numoutlets": 5,
                                    "outlettype": [ "", "", "", "", "" ],
                                    "patching_rect": [ 48.0, 168.0, 166.0, 18.0 ],
                                    "text": "route min max canonical_parent name"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-93",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 48.0, 120.0, 214.0, 18.0 ],
                                    "text": "get min, get max, get name, get canonical_parent"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-95",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "bang", "" ],
                                    "patching_rect": [ 48.0, 96.0, 29.5, 18.0 ],
                                    "text": "t b l"
                                }
                            },
                            {
                                "box": {
                                    "color": [ 0.925490196078431, 0.72156862745098, 0.780392156862745, 1.0 ],
                                    "id": "obj-96",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 48.0, 144.0, 50.0, 18.0 ],
                                    "saved_object_attributes": {
                                        "_persistence": 1
                                    },
                                    "text": "live.object"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-23",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 48.0, 60.0, 24.0, 24.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-24",
                                    "index": 3,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 120.0, 516.0, 24.0, 24.0 ]
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "obj-104", 0 ],
                                    "source": [ "obj-101", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-105", 0 ],
                                    "source": [ "obj-103", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-103", 0 ],
                                    "source": [ "obj-104", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-105", 1 ],
                                    "source": [ "obj-104", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-106", 0 ],
                                    "source": [ "obj-105", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-109", 0 ],
                                    "source": [ "obj-106", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-5", 0 ],
                                    "source": [ "obj-106", 2 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-5", 0 ],
                                    "source": [ "obj-106", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-119", 0 ],
                                    "source": [ "obj-107", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-112", 0 ],
                                    "source": [ "obj-109", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-113", 0 ],
                                    "source": [ "obj-111", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-111", 0 ],
                                    "source": [ "obj-112", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-113", 1 ],
                                    "source": [ "obj-112", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-107", 0 ],
                                    "source": [ "obj-113", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-121", 0 ],
                                    "source": [ "obj-119", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-4", 0 ],
                                    "source": [ "obj-121", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-95", 0 ],
                                    "source": [ "obj-23", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-24", 0 ],
                                    "source": [ "obj-4", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-119", 1 ],
                                    "source": [ "obj-5", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-101", 0 ],
                                    "source": [ "obj-92", 2 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-119", 2 ],
                                    "source": [ "obj-92", 3 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-2", 0 ],
                                    "source": [ "obj-92", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-3", 0 ],
                                    "source": [ "obj-92", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-96", 0 ],
                                    "source": [ "obj-93", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-93", 0 ],
                                    "source": [ "obj-95", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-96", 1 ],
                                    "source": [ "obj-95", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-92", 0 ],
                                    "source": [ "obj-96", 0 ]
                                }
                            }
                        ],
                        "styles": [
                            {
                                "name": "jpatcher001",
                                "default": {
                                    "accentcolor": [ 1.0, 1.0, 1.0, 0.25 ],
                                    "bgcolor": [ 0.095481, 0.100396, 0.100293, 0.36 ],
                                    "bgfillcolor": {
                                        "angle": 270.0,
                                        "color": [ 0.0, 0.0, 0.0, 0.45 ],
                                        "color1": [ 0.65098, 0.666667, 0.662745, 0.64 ],
                                        "color2": [ 0.0, 0.0, 0.0, 0.65 ],
                                        "proportion": 0.39,
                                        "type": "color"
                                    },
                                    "color": [ 0.8, 0.8, 0.8, 1.0 ],
                                    "fontname": [ "Verdana" ],
                                    "fontsize": [ 8.0 ],
                                    "patchlinecolor": [ 0.239216, 0.254902, 0.278431, 0.45 ],
                                    "textcolor": [ 0.0, 0.0, 0.0, 0.690196 ]
                                },
                                "parentstyle": "",
                                "multi": 0
                            },
                            {
                                "name": "jx.style",
                                "default": {
                                    "accentcolor": [ 1.0, 1.0, 1.0, 0.25 ],
                                    "bgcolor": [ 0.095481, 0.100396, 0.100293, 0.36 ],
                                    "bgfillcolor": {
                                        "angle": 270.0,
                                        "color": [ 0.0, 0.0, 0.0, 0.45 ],
                                        "color1": [ 0.65098, 0.666667, 0.662745, 0.64 ],
                                        "color2": [ 0.0, 0.0, 0.0, 0.65 ],
                                        "proportion": 0.39,
                                        "type": "color"
                                    },
                                    "color": [ 0.8, 0.8, 0.8, 1.0 ],
                                    "fontname": [ "Verdana" ],
                                    "fontsize": [ 8.0 ],
                                    "patchlinecolor": [ 0.239216, 0.254902, 0.278431, 0.45 ],
                                    "textcolor": [ 0.0, 0.0, 0.0, 0.690196 ]
                                },
                                "parentstyle": "jpatcher001",
                                "multi": 0
                            }
                        ],
                        "toolbaradditions": [ "transport", "audiomute", "audiosolo" ],
                        "toolbarexclusions": [ "transport", "audiomute", "audiosolo" ],
                        "selectioncolor": [ 0.92156862745098, 0.709803921568627, 0.329411764705882, 1.0 ],
                        "textcolor": [ 1.0, 1.0, 1.0, 0.67 ],
                        "patchlinecolor": [ 0.109803921568627, 0.109803921568627, 0.109803921568627, 0.450980392156863 ],
                        "bgcolor": [ 0.384313725490196, 0.384313725490196, 0.384313725490196, 1.0 ],
                        "editing_bgcolor": [ 0.454901960784314, 0.454901960784314, 0.454901960784314, 1.0 ],
                        "saved_attribute_attributes": {
                            "editing_bgcolor": {
                                "expression": ""
                            },
                            "locked_bgcolor": {
                                "expression": ""
                            },
                            "patchlinecolor": {
                                "expression": ""
                            }
                        }
                    },
                    "patching_rect": [ 180.0, 156.0, 65.0, 18.0 ],
                    "saved_attribute_attributes": {
                        "editing_bgcolor": {
                            "expression": ""
                        },
                        "locked_bgcolor": {
                            "expression": ""
                        },
                        "patchlinecolor": {
                            "expression": ""
                        }
                    },
                    "saved_object_attributes": {
                        "editing_bgcolor": [ 0.454901960784314, 0.454901960784314, 0.454901960784314, 1.0 ],
                        "locked_bgcolor": [ 0.384313725490196, 0.384313725490196, 0.384313725490196, 1.0 ],
                        "patchlinecolor": [ 0.109803921568627, 0.109803921568627, 0.109803921568627, 0.450980392156863 ],
                        "selectioncolor": [ 0.92156862745098, 0.709803921568627, 0.329411764705882, 1.0 ],
                        "style": "jx.style",
                        "textcolor": [ 1.0, 1.0, 1.0, 0.67 ]
                    },
                    "text": "p param_path"
                }
            },
            {
                "box": {
                    "id": "obj-19",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 348.0, 252.0, 29.5, 18.0 ],
                    "text": "id $1"
                }
            },
            {
                "box": {
                    "id": "obj-15",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 348.0, 204.0, 19.0, 18.0 ],
                    "text": "t i"
                }
            },
            {
                "box": {
                    "id": "obj-12",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 360.0, 120.0, 40.0, 18.0 ],
                    "text": "route id"
                }
            },
            {
                "box": {
                    "id": "obj-8",
                    "ignoreclick": 1,
                    "maxclass": "live.numbox",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 348.0, 180.0, 44.0, 15.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "live.numbox",
                            "parameter_mmax": 9999.0,
                            "parameter_modmode": 4,
                            "parameter_shortname": "live.numbox",
                            "parameter_type": 0,
                            "parameter_unitstyle": 0
                        }
                    },
                    "varname": "live.numbox"
                }
            },
            {
                "box": {
                    "id": "obj-11",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 312.0, 300.0, 58.0, 18.0 ],
                    "text": "set value $1"
                }
            },
            {
                "box": {
                    "id": "obj-7",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 348.0, 156.0, 29.5, 18.0 ],
                    "text": "gate"
                }
            },
            {
                "box": {
                    "color": [ 0.925490196078431, 0.72156862745098, 0.780392156862745, 0.81 ],
                    "id": "obj-24",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 312.0, 324.0, 50.0, 18.0 ],
                    "saved_object_attributes": {
                        "_persistence": 1
                    },
                    "text": "live.object"
                }
            },
            {
                "box": {
                    "color": [ 0.925490196078431, 0.72156862745098, 0.780392156862745, 0.81 ],
                    "id": "obj-21",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "", "", "" ],
                    "patching_rect": [ 288.0, 48.0, 181.0, 18.0 ],
                    "text": "live.path live_set view selected_parameter"
                }
            },
            {
                "box": {
                    "id": "obj-20",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 108.0, 84.0, 29.5, 18.0 ],
                    "text": "0"
                }
            },
            {
                "box": {
                    "id": "obj-18",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 84.0, 240.0, 56.0, 18.0 ],
                    "text": "prepend set"
                }
            },
            {
                "box": {
                    "id": "obj-17",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 84.0, 204.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-14",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 84.0, 180.0, 51.0, 18.0 ],
                    "text": "metro 500"
                }
            },
            {
                "box": {
                    "id": "obj-13",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "bang", "" ],
                    "patching_rect": [ 72.0, 84.0, 29.5, 18.0 ],
                    "text": "sel 0"
                }
            },
            {
                "box": {
                    "annotation": "Use this button to assign the slider to a parameter from another Live device.",
                    "annotation_name": "Assign button",
                    "bgcolor": [ 0.094117647058824, 0.101960784313725, 0.101960784313725, 0.0 ],
                    "id": "obj-6",
                    "maxclass": "led",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "oncolor": [ 0.995808362960815, 0.800102710723877, 0.399984955787659, 1.0 ],
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 72.0, 58.0, 18.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 0.0, -2.0, 18.0, 18.0 ],
                    "varname": "assign"
                }
            },
            {
                "box": {
                    "id": "obj-4",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 144.0, 180.0, 76.0, 18.0 ],
                    "text": "scale 0. 1. 0 127"
                }
            },
            {
                "box": {
                    "annotation": "Displays the incoming value.",
                    "id": "obj-1",
                    "maxclass": "live.numbox",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 120.0, 120.0, 44.0, 15.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 24.0, 0.0, 36.0, 15.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_linknames": 1,
                            "parameter_longname": "inputValue",
                            "parameter_modmode": 3,
                            "parameter_shortname": "inVal",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "inputValue"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "obj-4", 0 ],
                    "source": [ "obj-1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-24", 0 ],
                    "source": [ "obj-11", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-7", 1 ],
                    "source": [ "obj-12", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-37", 0 ],
                    "source": [ "obj-13", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-17", 0 ],
                    "source": [ "obj-14", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-22", 0 ],
                    "order": 1,
                    "source": [ "obj-15", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-25", 0 ],
                    "order": 0,
                    "source": [ "obj-15", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-18", 0 ],
                    "source": [ "obj-17", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-6", 0 ],
                    "midpoints": [ 93.5, 288.33984375, 36.54296875, 288.33984375, 36.54296875, 50.0, 81.5, 50.0 ],
                    "source": [ "obj-18", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-24", 1 ],
                    "order": 0,
                    "source": [ "obj-19", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-9", 0 ],
                    "midpoints": [ 357.5, 280.0, 337.62890625, 280.0, 337.62890625, 151.46484375, 189.5, 151.46484375 ],
                    "order": 1,
                    "source": [ "obj-19", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-17", 0 ],
                    "order": 0,
                    "source": [ "obj-20", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-37", 0 ],
                    "order": 1,
                    "source": [ "obj-20", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-12", 0 ],
                    "order": 0,
                    "source": [ "obj-21", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-20", 0 ],
                    "midpoints": [ 378.5, 75.0, 117.5, 75.0 ],
                    "order": 1,
                    "source": [ "obj-21", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-19", 0 ],
                    "source": [ "obj-22", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-26", 0 ],
                    "source": [ "obj-25", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-29", 0 ],
                    "source": [ "obj-26", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-32", 0 ],
                    "source": [ "obj-26", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-11", 0 ],
                    "source": [ "obj-28", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-23", 0 ],
                    "source": [ "obj-29", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-28", 0 ],
                    "source": [ "obj-31", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-23", 0 ],
                    "source": [ "obj-32", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-31", 0 ],
                    "source": [ "obj-34", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-14", 0 ],
                    "order": 1,
                    "source": [ "obj-37", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-7", 0 ],
                    "midpoints": [ 93.5, 147.0, 357.5, 147.0 ],
                    "order": 0,
                    "source": [ "obj-37", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-28", 0 ],
                    "source": [ "obj-4", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "source": [ "obj-5", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-13", 0 ],
                    "source": [ "obj-6", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-8", 0 ],
                    "source": [ "obj-7", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-15", 0 ],
                    "source": [ "obj-8", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-34", 1 ],
                    "order": 0,
                    "source": [ "obj-9", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-34", 0 ],
                    "order": 1,
                    "source": [ "obj-9", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-4", 4 ],
                    "order": 1,
                    "source": [ "obj-9", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-4", 3 ],
                    "order": 0,
                    "source": [ "obj-9", 0 ]
                }
            }
        ],
        "styles": [
            {
                "name": "jpatcher001",
                "default": {
                    "accentcolor": [ 1.0, 1.0, 1.0, 0.25 ],
                    "bgcolor": [ 0.095481, 0.100396, 0.100293, 0.36 ],
                    "bgfillcolor": {
                        "angle": 270.0,
                        "color": [ 0.0, 0.0, 0.0, 0.45 ],
                        "color1": [ 0.65098, 0.666667, 0.662745, 0.64 ],
                        "color2": [ 0.0, 0.0, 0.0, 0.65 ],
                        "proportion": 0.39,
                        "type": "color"
                    },
                    "color": [ 0.8, 0.8, 0.8, 1.0 ],
                    "fontname": [ "Verdana" ],
                    "fontsize": [ 8.0 ],
                    "patchlinecolor": [ 0.239216, 0.254902, 0.278431, 0.45 ],
                    "textcolor": [ 0.0, 0.0, 0.0, 0.690196 ]
                },
                "parentstyle": "",
                "multi": 0
            },
            {
                "name": "jx.style",
                "default": {
                    "accentcolor": [ 1.0, 1.0, 1.0, 0.25 ],
                    "bgcolor": [ 0.095481, 0.100396, 0.100293, 0.36 ],
                    "bgfillcolor": {
                        "angle": 270.0,
                        "color": [ 0.0, 0.0, 0.0, 0.45 ],
                        "color1": [ 0.65098, 0.666667, 0.662745, 0.64 ],
                        "color2": [ 0.0, 0.0, 0.0, 0.65 ],
                        "proportion": 0.39,
                        "type": "color"
                    },
                    "color": [ 0.8, 0.8, 0.8, 1.0 ],
                    "fontname": [ "Verdana" ],
                    "fontsize": [ 8.0 ],
                    "patchlinecolor": [ 0.239216, 0.254902, 0.278431, 0.45 ],
                    "textcolor": [ 0.0, 0.0, 0.0, 0.690196 ]
                },
                "parentstyle": "jpatcher001",
                "multi": 0
            }
        ],
        "toolbaradditions": [ "transport", "audiomute", "audiosolo" ],
        "toolbarexclusions": [ "transport", "audiomute", "audiosolo" ],
        "selectioncolor": [ 0.92156862745098, 0.709803921568627, 0.329411764705882, 1.0 ],
        "textcolor": [ 1.0, 1.0, 1.0, 0.67 ],
        "patchlinecolor": [ 0.109803921568627, 0.109803921568627, 0.109803921568627, 0.450980392156863 ],
        "bgcolor": [ 0.384313725490196, 0.384313725490196, 0.384313725490196, 1.0 ],
        "editing_bgcolor": [ 0.454901960784314, 0.454901960784314, 0.454901960784314, 1.0 ],
        "saved_attribute_attributes": {
            "editing_bgcolor": {
                "expression": ""
            },
            "locked_bgcolor": {
                "expression": ""
            },
            "patchlinecolor": {
                "expression": ""
            }
        }
    }
}