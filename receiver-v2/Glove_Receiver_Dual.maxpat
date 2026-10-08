{
  "patcher": {
    "fileversion": 1,
    "appversion": {
      "major": 9,
      "minor": 1,
      "revision": 3,
      "architecture": "arm64",
      "modernui": 1
    },
    "classnamespace": "box",
    "rect": [
      70,
      90,
      1310,
      790
    ],
    "openinpresentation": 1,
    "default_fontsize": 11,
    "default_fontname": "Arial",
    "devicewidth": 648,
    "enablehscroll": 1,
    "enablevscroll": 1,
    "boxes": [
      {
        "box": {
          "id": "art",
          "maxclass": "jsui",
          "patching_rect": [
            30,
            35,
            648,
            122
          ],
          "presentation": 1,
          "presentation_rect": [
            0,
            0,
            648,
            122
          ],
          "filename": "glove_hands.js",
          "numinlets": 1,
          "numoutlets": 0,
          "jsarguments": [
            "glove_hands.js"
          ],
          "ignoreclick": 1,
          "border": 0,
          "parameter_enable": 0,
          "background": 1
        }
      },
      {
        "box": {
          "id": "left_title",
          "maxclass": "live.comment",
          "patching_rect": [
            20,
            224,
            145,
            22
          ],
          "text": "GLOVE  /  LEFT",
          "presentation": 1,
          "presentation_rect": [
            8,
            3,
            109,
            17
          ],
          "fontsize": 10,
          "numinlets": 1,
          "numoutlets": 0,
          "textjustification": 0
        }
      },
      {
        "box": {
          "id": "right_title",
          "maxclass": "live.comment",
          "patching_rect": [
            20,
            248,
            145,
            22
          ],
          "text": "GLOVE  /  RIGHT",
          "presentation": 1,
          "presentation_rect": [
            332,
            3,
            109,
            17
          ],
          "fontsize": 10,
          "numinlets": 1,
          "numoutlets": 0,
          "textjustification": 0
        }
      },
      {
        "box": {
          "id": "left_port",
          "maxclass": "live.comment",
          "patching_rect": [
            20,
            272,
            145,
            22
          ],
          "text": "IN 7000",
          "presentation": 1,
          "presentation_rect": [
            120,
            4,
            88,
            15
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0,
          "textjustification": 0
        }
      },
      {
        "box": {
          "id": "right_port",
          "maxclass": "live.comment",
          "patching_rect": [
            20,
            296,
            145,
            22
          ],
          "text": "IN 6000",
          "presentation": 1,
          "presentation_rect": [
            444,
            4,
            88,
            15
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0,
          "textjustification": 0
        }
      },
      {
        "box": {
          "id": "left_status",
          "maxclass": "live.comment",
          "patching_rect": [
            20,
            320,
            145,
            22
          ],
          "text": "WAIT",
          "presentation": 1,
          "presentation_rect": [
            282,
            4,
            36,
            15
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0,
          "textjustification": 0,
          "suppressinlet": 0
        }
      },
      {
        "box": {
          "id": "right_status",
          "maxclass": "live.comment",
          "patching_rect": [
            20,
            344,
            145,
            22
          ],
          "text": "WAIT",
          "presentation": 1,
          "presentation_rect": [
            606,
            4,
            36,
            15
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0,
          "textjustification": 0,
          "suppressinlet": 0
        }
      },
      {
        "box": {
          "id": "engine",
          "maxclass": "newobj",
          "patching_rect": [
            355,
            390,
            195,
            22
          ],
          "text": "js glove_dual_engine.js",
          "numinlets": 1,
          "numoutlets": 7,
          "outlettype": [
            "",
            "",
            "",
            "",
            "",
            "",
            ""
          ],
          "varname": "engine"
        }
      },
      {
        "box": {
          "id": "device",
          "maxclass": "newobj",
          "patching_rect": [
            30,
            850,
            95,
            22
          ],
          "text": "live.thisdevice"
        }
      },
      {
        "box": {
          "id": "start",
          "maxclass": "message",
          "patching_rect": [
            275,
            850,
            50,
            22
          ],
          "text": "start"
        }
      },
      {
        "box": {
          "id": "colors",
          "maxclass": "newobj",
          "patching_rect": [
            520,
            850,
            75,
            22
          ],
          "text": "live.colors"
        }
      },
      {
        "box": {
          "id": "query_colors",
          "maxclass": "message",
          "patching_rect": [
            765,
            850,
            70,
            22
          ],
          "text": "everything"
        }
      },
      {
        "box": {
          "id": "statusroute",
          "maxclass": "newobj",
          "patching_rect": [
            820,
            395,
            85,
            22
          ],
          "text": "route status calstatus caldata routing"
        }
      },
      {
        "box": {
          "id": "handroute",
          "maxclass": "newobj",
          "patching_rect": [
            820,
            428,
            70,
            22
          ],
          "text": "route 0 1"
        }
      },
      {
        "box": {
          "id": "calroute",
          "maxclass": "newobj",
          "patching_rect": [
            1010,
            850,
            145,
            22
          ],
          "text": "route 0 1"
        }
      },
      {
        "box": {
          "id": "caldataroute",
          "maxclass": "newobj",
          "patching_rect": [
            30,
            905,
            145,
            22
          ],
          "text": "route 0 1"
        }
      },
      {
        "box": {
          "id": "calreport",
          "maxclass": "message",
          "patching_rect": [
            275,
            905,
            145,
            22
          ],
          "text": "calreport"
        }
      },
      {
        "box": {
          "id": "left_udp",
          "maxclass": "newobj",
          "patching_rect": [
            30,
            250,
            130,
            22
          ],
          "text": "udpreceive 7000"
        }
      },
      {
        "box": {
          "id": "left_route",
          "maxclass": "newobj",
          "patching_rect": [
            30,
            290,
            210,
            22
          ],
          "text": "route /servos /GLeft"
        }
      },
      {
        "box": {
          "id": "left_input_gate",
          "maxclass": "newobj",
          "patching_rect": [
            250,
            250,
            80,
            22
          ],
          "text": "gate 1 1",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ]
        }
      },
      {
        "box": {
          "id": "left_raw",
          "maxclass": "newobj",
          "patching_rect": [
            30,
            330,
            120,
            22
          ],
          "text": "prepend rawleft"
        }
      },
      {
        "box": {
          "id": "left_norm",
          "maxclass": "newobj",
          "patching_rect": [
            200,
            330,
            125,
            22
          ],
          "text": "prepend normleft"
        }
      },
      {
        "box": {
          "id": "left_send",
          "maxclass": "newobj",
          "patching_rect": [
            30,
            440,
            80,
            22
          ],
          "text": "s GLeft"
        }
      },
      {
        "box": {
          "id": "left_control_send",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            752,
            145,
            22
          ],
          "text": "s GLeftControl"
        }
      },
      {
        "box": {
          "id": "left_monitor_unpack",
          "maxclass": "newobj",
          "patching_rect": [
            30,
            800,
            555,
            22
          ],
          "text": "unpack f f f f f",
          "numinlets": 1,
          "numoutlets": 5,
          "outlettype": [
            "float",
            "float",
            "float",
            "float",
            "float"
          ]
        }
      },
      {
        "box": {
          "id": "left_statusset",
          "maxclass": "newobj",
          "patching_rect": [
            280,
            440,
            95,
            22
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "left_art",
          "maxclass": "newobj",
          "patching_rect": [
            160,
            440,
            90,
            22
          ],
          "text": "prepend left"
        }
      },
      {
        "box": {
          "id": "left_pinky_label",
          "maxclass": "live.comment",
          "patching_rect": [
            30,
            540,
            90,
            14
          ],
          "text": "PINKY",
          "presentation": 1,
          "presentation_rect": [
            11,
            27,
            46,
            11
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0,
          "textjustification": 0
        }
      },
      {
        "box": {
          "id": "left_pinky",
          "maxclass": "live.numbox",
          "patching_rect": [
            30,
            602,
            46,
            16
          ],
          "presentation": 1,
          "presentation_rect": [
            11,
            40,
            46,
            16
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "parameter_enable": 1,
          "varname": "left_pinky",
          "fontsize": 10,
          "annotation": "Filtered normalized finger value, from 0 to 1.",
          "focusbordercolor": [
            1,
            0.71,
            0.196,
            1
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Pinky",
              "parameter_shortname": "Left Pinky",
              "parameter_type": 0,
              "parameter_mmin": 0.0,
              "parameter_mmax": 1.0,
              "parameter_initial": [
                0.0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 9,
              "parameter_units": "%0.3f",
              "parameter_invisible": 2
            }
          },
          "ignoreclick": 1,
          "parameter_mappable": 0
        }
      },
      {
        "box": {
          "id": "left_pinky_set",
          "maxclass": "newobj",
          "patching_rect": [
            30,
            565,
            90,
            22
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "left_ring_label",
          "maxclass": "live.comment",
          "patching_rect": [
            142,
            540,
            90,
            14
          ],
          "text": "RING",
          "presentation": 1,
          "presentation_rect": [
            70,
            27,
            46,
            11
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0,
          "textjustification": 0
        }
      },
      {
        "box": {
          "id": "left_ring",
          "maxclass": "live.numbox",
          "patching_rect": [
            142,
            602,
            46,
            16
          ],
          "presentation": 1,
          "presentation_rect": [
            70,
            40,
            46,
            16
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "parameter_enable": 1,
          "varname": "left_ring",
          "fontsize": 10,
          "annotation": "Filtered normalized finger value, from 0 to 1.",
          "focusbordercolor": [
            1,
            0.71,
            0.196,
            1
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Ring",
              "parameter_shortname": "Left Ring",
              "parameter_type": 0,
              "parameter_mmin": 0.0,
              "parameter_mmax": 1.0,
              "parameter_initial": [
                0.0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 9,
              "parameter_units": "%0.3f",
              "parameter_invisible": 2
            }
          },
          "ignoreclick": 1,
          "parameter_mappable": 0
        }
      },
      {
        "box": {
          "id": "left_ring_set",
          "maxclass": "newobj",
          "patching_rect": [
            142,
            565,
            90,
            22
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "left_middle_label",
          "maxclass": "live.comment",
          "patching_rect": [
            254,
            540,
            90,
            14
          ],
          "text": "MIDDLE",
          "presentation": 1,
          "presentation_rect": [
            129,
            27,
            46,
            11
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0,
          "textjustification": 0
        }
      },
      {
        "box": {
          "id": "left_middle",
          "maxclass": "live.numbox",
          "patching_rect": [
            254,
            602,
            46,
            16
          ],
          "presentation": 1,
          "presentation_rect": [
            129,
            40,
            46,
            16
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "parameter_enable": 1,
          "varname": "left_middle",
          "fontsize": 10,
          "annotation": "Filtered normalized finger value, from 0 to 1.",
          "focusbordercolor": [
            1,
            0.71,
            0.196,
            1
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Middle",
              "parameter_shortname": "Left Middle",
              "parameter_type": 0,
              "parameter_mmin": 0.0,
              "parameter_mmax": 1.0,
              "parameter_initial": [
                0.0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 9,
              "parameter_units": "%0.3f",
              "parameter_invisible": 2
            }
          },
          "ignoreclick": 1,
          "parameter_mappable": 0
        }
      },
      {
        "box": {
          "id": "left_middle_set",
          "maxclass": "newobj",
          "patching_rect": [
            254,
            565,
            90,
            22
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "left_index_label",
          "maxclass": "live.comment",
          "patching_rect": [
            366,
            540,
            90,
            14
          ],
          "text": "INDEX",
          "presentation": 1,
          "presentation_rect": [
            188,
            27,
            46,
            11
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0,
          "textjustification": 0
        }
      },
      {
        "box": {
          "id": "left_index",
          "maxclass": "live.numbox",
          "patching_rect": [
            366,
            602,
            46,
            16
          ],
          "presentation": 1,
          "presentation_rect": [
            188,
            40,
            46,
            16
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "parameter_enable": 1,
          "varname": "left_index",
          "fontsize": 10,
          "annotation": "Filtered normalized finger value, from 0 to 1.",
          "focusbordercolor": [
            1,
            0.71,
            0.196,
            1
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Index",
              "parameter_shortname": "Left Index",
              "parameter_type": 0,
              "parameter_mmin": 0.0,
              "parameter_mmax": 1.0,
              "parameter_initial": [
                0.0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 9,
              "parameter_units": "%0.3f",
              "parameter_invisible": 2
            }
          },
          "ignoreclick": 1,
          "parameter_mappable": 0
        }
      },
      {
        "box": {
          "id": "left_index_set",
          "maxclass": "newobj",
          "patching_rect": [
            366,
            565,
            90,
            22
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "left_thumb_label",
          "maxclass": "live.comment",
          "patching_rect": [
            478,
            540,
            90,
            14
          ],
          "text": "THUMB",
          "presentation": 1,
          "presentation_rect": [
            262,
            27,
            46,
            11
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0,
          "textjustification": 0
        }
      },
      {
        "box": {
          "id": "left_thumb",
          "maxclass": "live.numbox",
          "patching_rect": [
            478,
            602,
            46,
            16
          ],
          "presentation": 1,
          "presentation_rect": [
            262,
            40,
            46,
            16
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "parameter_enable": 1,
          "varname": "left_thumb",
          "fontsize": 10,
          "annotation": "Filtered normalized finger value, from 0 to 1.",
          "focusbordercolor": [
            1,
            0.71,
            0.196,
            1
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Thumb",
              "parameter_shortname": "Left Thumb",
              "parameter_type": 0,
              "parameter_mmin": 0.0,
              "parameter_mmax": 1.0,
              "parameter_initial": [
                0.0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 9,
              "parameter_units": "%0.3f",
              "parameter_invisible": 2
            }
          },
          "ignoreclick": 1,
          "parameter_mappable": 0
        }
      },
      {
        "box": {
          "id": "left_thumb_set",
          "maxclass": "newobj",
          "patching_rect": [
            478,
            565,
            90,
            22
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "left_calibrate",
          "maxclass": "live.text",
          "patching_rect": [
            20,
            1208,
            145,
            22
          ],
          "text": "Calibrate",
          "presentation": 1,
          "presentation_rect": [
            216,
            4,
            60,
            15
          ],
          "texton": "Calibrate",
          "mode": 0,
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "left_calibrate",
          "fontsize": 9,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Calibrate",
              "parameter_shortname": "Left Calibrate",
              "parameter_type": 2,
              "parameter_enum": [
                "Off",
                "On"
              ],
              "parameter_mmax": 1,
              "parameter_initial": [
                0
              ],
              "parameter_initial_enable": 1,
              "parameter_invisible": 2
            }
          }
        }
      },
      {
        "box": {
          "id": "left_cal_press",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            1232,
            145,
            22
          ],
          "text": "t b b"
        }
      },
      {
        "box": {
          "id": "left_cal_open",
          "maxclass": "message",
          "patching_rect": [
            20,
            1256,
            145,
            22
          ],
          "text": "open"
        }
      },
      {
        "box": {
          "id": "left_cal_control",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            1280,
            145,
            22
          ],
          "text": "pcontrol"
        }
      },
      {
        "box": {
          "id": "left_calibration",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            1304,
            145,
            22
          ],
          "text": "p Left_Calibration",
          "patcher": {
            "fileversion": 1,
            "appversion": {
              "major": 9,
              "minor": 1,
              "revision": 3,
              "architecture": "arm64",
              "modernui": 1
            },
            "classnamespace": "box",
            "rect": [
              120,
              160,
              440,
              222
            ],
            "openinpresentation": 1,
            "default_fontsize": 11,
            "default_fontname": "Arial",
            "devicewidth": 440,
            "enablehscroll": 0,
            "enablevscroll": 0,
            "boxes": [
              {
                "box": {
                  "id": "cal_title",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    200,
                    145,
                    22
                  ],
                  "text": "LEFT HAND  /  CALIBRATION",
                  "presentation": 1,
                  "presentation_rect": [
                    10,
                    7,
                    420,
                    18
                  ],
                  "fontsize": 11,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "cal_hint",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    224,
                    145,
                    22
                  ],
                  "text": "Hold each pose still for 0.3 seconds before capturing.",
                  "presentation": 1,
                  "presentation_rect": [
                    10,
                    29,
                    420,
                    16
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "cal_open",
                  "maxclass": "live.text",
                  "patching_rect": [
                    20,
                    248,
                    145,
                    22
                  ],
                  "text": "Open → 0",
                  "presentation": 1,
                  "presentation_rect": [
                    10,
                    51,
                    130,
                    22
                  ],
                  "texton": "Open → 0",
                  "mode": 0,
                  "numinlets": 1,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "parameter_enable": 1,
                  "varname": "cal_open",
                  "fontsize": 9,
                  "saved_attribute_attributes": {
                    "valueof": {
                      "parameter_longname": "Left Calibration open",
                      "parameter_shortname": "Left Calibration open",
                      "parameter_type": 2,
                      "parameter_enum": [
                        "Off",
                        "On"
                      ],
                      "parameter_mmax": 1,
                      "parameter_initial": [
                        0
                      ],
                      "parameter_initial_enable": 1,
                      "parameter_invisible": 2
                    }
                  }
                }
              },
              {
                "box": {
                  "id": "cal_open_bang",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    272,
                    145,
                    22
                  ],
                  "text": "t b"
                }
              },
              {
                "box": {
                  "id": "cal_open_command",
                  "maxclass": "message",
                  "patching_rect": [
                    20,
                    296,
                    145,
                    22
                  ],
                  "text": "capture 0 open"
                }
              },
              {
                "box": {
                  "id": "cal_fist",
                  "maxclass": "live.text",
                  "patching_rect": [
                    20,
                    320,
                    145,
                    22
                  ],
                  "text": "Fist → 0.9",
                  "presentation": 1,
                  "presentation_rect": [
                    150,
                    51,
                    130,
                    22
                  ],
                  "texton": "Fist → 0.9",
                  "mode": 0,
                  "numinlets": 1,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "parameter_enable": 1,
                  "varname": "cal_fist",
                  "fontsize": 9,
                  "saved_attribute_attributes": {
                    "valueof": {
                      "parameter_longname": "Left Calibration fist",
                      "parameter_shortname": "Left Calibration fist",
                      "parameter_type": 2,
                      "parameter_enum": [
                        "Off",
                        "On"
                      ],
                      "parameter_mmax": 1,
                      "parameter_initial": [
                        0
                      ],
                      "parameter_initial_enable": 1,
                      "parameter_invisible": 2
                    }
                  }
                }
              },
              {
                "box": {
                  "id": "cal_fist_bang",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    344,
                    145,
                    22
                  ],
                  "text": "t b"
                }
              },
              {
                "box": {
                  "id": "cal_fist_command",
                  "maxclass": "message",
                  "patching_rect": [
                    20,
                    368,
                    145,
                    22
                  ],
                  "text": "capture 0 fist"
                }
              },
              {
                "box": {
                  "id": "cal_clear",
                  "maxclass": "live.text",
                  "patching_rect": [
                    20,
                    392,
                    145,
                    22
                  ],
                  "text": "Reset",
                  "presentation": 1,
                  "presentation_rect": [
                    290,
                    51,
                    130,
                    22
                  ],
                  "texton": "Reset",
                  "mode": 0,
                  "numinlets": 1,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "parameter_enable": 1,
                  "varname": "cal_clear",
                  "fontsize": 9,
                  "saved_attribute_attributes": {
                    "valueof": {
                      "parameter_longname": "Left Calibration clear",
                      "parameter_shortname": "Left Calibration clear",
                      "parameter_type": 2,
                      "parameter_enum": [
                        "Off",
                        "On"
                      ],
                      "parameter_mmax": 1,
                      "parameter_initial": [
                        0
                      ],
                      "parameter_initial_enable": 1,
                      "parameter_invisible": 2
                    }
                  }
                }
              },
              {
                "box": {
                  "id": "cal_clear_bang",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    416,
                    145,
                    22
                  ],
                  "text": "t b"
                }
              },
              {
                "box": {
                  "id": "cal_clear_command",
                  "maxclass": "message",
                  "patching_rect": [
                    20,
                    440,
                    145,
                    22
                  ],
                  "text": "clearcal 0"
                }
              },
              {
                "box": {
                  "id": "cal_status",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    464,
                    145,
                    22
                  ],
                  "text": "Default range. Capture Open and Fist.",
                  "presentation": 1,
                  "presentation_rect": [
                    10,
                    80,
                    420,
                    17
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "cal_headroom",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    488,
                    145,
                    22
                  ],
                  "text": "Fist = 0.900; extra bend may rise to 1.000.",
                  "presentation": 1,
                  "presentation_rect": [
                    10,
                    102,
                    420,
                    16
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "input_label",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    512,
                    145,
                    22
                  ],
                  "text": "Input: no data",
                  "presentation": 1,
                  "presentation_rect": [
                    10,
                    124,
                    420,
                    16
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "raw_row_label",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    536,
                    145,
                    22
                  ],
                  "text": "Input",
                  "presentation": 1,
                  "presentation_rect": [
                    10,
                    161,
                    65,
                    17
                  ],
                  "fontsize": 9,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "open_label",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    560,
                    145,
                    22
                  ],
                  "text": "Open saved",
                  "presentation": 1,
                  "presentation_rect": [
                    10,
                    181,
                    75,
                    17
                  ],
                  "fontsize": 9,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "fist_label",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    584,
                    145,
                    22
                  ],
                  "text": "Fist saved",
                  "presentation": 1,
                  "presentation_rect": [
                    10,
                    201,
                    75,
                    17
                  ],
                  "fontsize": 9,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "inspect_finger_0",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    608,
                    145,
                    22
                  ],
                  "text": "PINKY",
                  "presentation": 1,
                  "presentation_rect": [
                    95,
                    145,
                    62,
                    12
                  ],
                  "fontsize": 8,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "input0",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    632,
                    145,
                    22
                  ],
                  "text": "—",
                  "presentation": 1,
                  "presentation_rect": [
                    95,
                    161,
                    62,
                    17
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "open0",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    656,
                    145,
                    22
                  ],
                  "text": "—",
                  "presentation": 1,
                  "presentation_rect": [
                    95,
                    181,
                    62,
                    17
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "fist0",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    680,
                    145,
                    22
                  ],
                  "text": "—",
                  "presentation": 1,
                  "presentation_rect": [
                    95,
                    201,
                    62,
                    17
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "inspect_finger_1",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    704,
                    145,
                    22
                  ],
                  "text": "RING",
                  "presentation": 1,
                  "presentation_rect": [
                    159,
                    145,
                    62,
                    12
                  ],
                  "fontsize": 8,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "input1",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    728,
                    145,
                    22
                  ],
                  "text": "—",
                  "presentation": 1,
                  "presentation_rect": [
                    159,
                    161,
                    62,
                    17
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "open1",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    752,
                    145,
                    22
                  ],
                  "text": "—",
                  "presentation": 1,
                  "presentation_rect": [
                    159,
                    181,
                    62,
                    17
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "fist1",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    776,
                    145,
                    22
                  ],
                  "text": "—",
                  "presentation": 1,
                  "presentation_rect": [
                    159,
                    201,
                    62,
                    17
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "inspect_finger_2",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    800,
                    145,
                    22
                  ],
                  "text": "MIDDLE",
                  "presentation": 1,
                  "presentation_rect": [
                    223,
                    145,
                    62,
                    12
                  ],
                  "fontsize": 8,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "input2",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    824,
                    145,
                    22
                  ],
                  "text": "—",
                  "presentation": 1,
                  "presentation_rect": [
                    223,
                    161,
                    62,
                    17
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "open2",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    848,
                    145,
                    22
                  ],
                  "text": "—",
                  "presentation": 1,
                  "presentation_rect": [
                    223,
                    181,
                    62,
                    17
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "fist2",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    872,
                    145,
                    22
                  ],
                  "text": "—",
                  "presentation": 1,
                  "presentation_rect": [
                    223,
                    201,
                    62,
                    17
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "inspect_finger_3",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    896,
                    145,
                    22
                  ],
                  "text": "INDEX",
                  "presentation": 1,
                  "presentation_rect": [
                    287,
                    145,
                    62,
                    12
                  ],
                  "fontsize": 8,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "input3",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    920,
                    145,
                    22
                  ],
                  "text": "—",
                  "presentation": 1,
                  "presentation_rect": [
                    287,
                    161,
                    62,
                    17
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "open3",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    944,
                    145,
                    22
                  ],
                  "text": "—",
                  "presentation": 1,
                  "presentation_rect": [
                    287,
                    181,
                    62,
                    17
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "fist3",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    968,
                    145,
                    22
                  ],
                  "text": "—",
                  "presentation": 1,
                  "presentation_rect": [
                    287,
                    201,
                    62,
                    17
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "inspect_finger_4",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    992,
                    145,
                    22
                  ],
                  "text": "THUMB",
                  "presentation": 1,
                  "presentation_rect": [
                    351,
                    145,
                    62,
                    12
                  ],
                  "fontsize": 8,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "input4",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    1016,
                    145,
                    22
                  ],
                  "text": "—",
                  "presentation": 1,
                  "presentation_rect": [
                    351,
                    161,
                    62,
                    17
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "open4",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    1040,
                    145,
                    22
                  ],
                  "text": "—",
                  "presentation": 1,
                  "presentation_rect": [
                    351,
                    181,
                    62,
                    17
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "fist4",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    1064,
                    145,
                    22
                  ],
                  "text": "—",
                  "presentation": 1,
                  "presentation_rect": [
                    351,
                    201,
                    62,
                    17
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "cal_input",
                  "maxclass": "inlet",
                  "patching_rect": [
                    20,
                    1088,
                    145,
                    22
                  ],
                  "numinlets": 0,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "cal_data_route",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1112,
                    145,
                    22
                  ],
                  "text": "route input_label open_label fist_label input0 input1 input2 input3 input4 open0 open1 open2 open3 open4 fist0 fist1 fist2 fist3 fist4",
                  "numinlets": 1,
                  "numoutlets": 19,
                  "outlettype": [
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    ""
                  ]
                }
              },
              {
                "box": {
                  "id": "input_label_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1136,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "open_label_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1160,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "fist_label_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1184,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "input0_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1208,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "input1_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1232,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "input2_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1256,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "input3_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1280,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "input4_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1304,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "open0_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1328,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "open1_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1352,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "open2_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1376,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "open3_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1400,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "open4_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1424,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "fist0_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1448,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "fist1_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1472,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "fist2_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1496,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "fist3_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1520,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "fist4_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1544,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "cal_output",
                  "maxclass": "outlet",
                  "patching_rect": [
                    20,
                    1568,
                    145,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 0
                }
              }
            ],
            "lines": [
              {
                "patchline": {
                  "source": [
                    "cal_open",
                    0
                  ],
                  "destination": [
                    "cal_open_bang",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_open_bang",
                    0
                  ],
                  "destination": [
                    "cal_open_command",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_open_command",
                    0
                  ],
                  "destination": [
                    "cal_output",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_fist",
                    0
                  ],
                  "destination": [
                    "cal_fist_bang",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_fist_bang",
                    0
                  ],
                  "destination": [
                    "cal_fist_command",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_fist_command",
                    0
                  ],
                  "destination": [
                    "cal_output",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_clear",
                    0
                  ],
                  "destination": [
                    "cal_clear_bang",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_clear_bang",
                    0
                  ],
                  "destination": [
                    "cal_clear_command",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_clear_command",
                    0
                  ],
                  "destination": [
                    "cal_output",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_input",
                    0
                  ],
                  "destination": [
                    "cal_data_route",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    0
                  ],
                  "destination": [
                    "input_label_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "input_label_set",
                    0
                  ],
                  "destination": [
                    "input_label",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    1
                  ],
                  "destination": [
                    "open_label_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "open_label_set",
                    0
                  ],
                  "destination": [
                    "open_label",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    2
                  ],
                  "destination": [
                    "fist_label_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "fist_label_set",
                    0
                  ],
                  "destination": [
                    "fist_label",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    3
                  ],
                  "destination": [
                    "input0_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "input0_set",
                    0
                  ],
                  "destination": [
                    "input0",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    4
                  ],
                  "destination": [
                    "input1_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "input1_set",
                    0
                  ],
                  "destination": [
                    "input1",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    5
                  ],
                  "destination": [
                    "input2_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "input2_set",
                    0
                  ],
                  "destination": [
                    "input2",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    6
                  ],
                  "destination": [
                    "input3_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "input3_set",
                    0
                  ],
                  "destination": [
                    "input3",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    7
                  ],
                  "destination": [
                    "input4_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "input4_set",
                    0
                  ],
                  "destination": [
                    "input4",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    8
                  ],
                  "destination": [
                    "open0_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "open0_set",
                    0
                  ],
                  "destination": [
                    "open0",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    9
                  ],
                  "destination": [
                    "open1_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "open1_set",
                    0
                  ],
                  "destination": [
                    "open1",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    10
                  ],
                  "destination": [
                    "open2_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "open2_set",
                    0
                  ],
                  "destination": [
                    "open2",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    11
                  ],
                  "destination": [
                    "open3_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "open3_set",
                    0
                  ],
                  "destination": [
                    "open3",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    12
                  ],
                  "destination": [
                    "open4_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "open4_set",
                    0
                  ],
                  "destination": [
                    "open4",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    13
                  ],
                  "destination": [
                    "fist0_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "fist0_set",
                    0
                  ],
                  "destination": [
                    "fist0",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    14
                  ],
                  "destination": [
                    "fist1_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "fist1_set",
                    0
                  ],
                  "destination": [
                    "fist1",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    15
                  ],
                  "destination": [
                    "fist2_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "fist2_set",
                    0
                  ],
                  "destination": [
                    "fist2",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    16
                  ],
                  "destination": [
                    "fist3_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "fist3_set",
                    0
                  ],
                  "destination": [
                    "fist3",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    17
                  ],
                  "destination": [
                    "fist4_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "fist4_set",
                    0
                  ],
                  "destination": [
                    "fist4",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    18
                  ],
                  "destination": [
                    "cal_status",
                    0
                  ]
                }
              }
            ],
            "parameters": {
              "cal_open": [
                "Left Calibration open",
                "Left Calibration open",
                0
              ],
              "cal_fist": [
                "Left Calibration fist",
                "Left Calibration fist",
                0
              ],
              "cal_clear": [
                "Left Calibration clear",
                "Left Calibration clear",
                0
              ]
            }
          },
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "varname": "left_calibration"
        }
      },
      {
        "box": {
          "id": "left_cal_statusset",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            1328,
            145,
            22
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "right_udp",
          "maxclass": "newobj",
          "patching_rect": [
            690,
            250,
            130,
            22
          ],
          "text": "udpreceive 6000"
        }
      },
      {
        "box": {
          "id": "right_route",
          "maxclass": "newobj",
          "patching_rect": [
            690,
            290,
            210,
            22
          ],
          "text": "route /servos /GRight"
        }
      },
      {
        "box": {
          "id": "right_input_gate",
          "maxclass": "newobj",
          "patching_rect": [
            910,
            250,
            80,
            22
          ],
          "text": "gate 1 1",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ]
        }
      },
      {
        "box": {
          "id": "right_raw",
          "maxclass": "newobj",
          "patching_rect": [
            690,
            330,
            120,
            22
          ],
          "text": "prepend rawright"
        }
      },
      {
        "box": {
          "id": "right_norm",
          "maxclass": "newobj",
          "patching_rect": [
            860,
            330,
            125,
            22
          ],
          "text": "prepend normright"
        }
      },
      {
        "box": {
          "id": "right_send",
          "maxclass": "newobj",
          "patching_rect": [
            690,
            440,
            80,
            22
          ],
          "text": "s GRight"
        }
      },
      {
        "box": {
          "id": "right_control_send",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            1496,
            145,
            22
          ],
          "text": "s GRightControl"
        }
      },
      {
        "box": {
          "id": "right_monitor_unpack",
          "maxclass": "newobj",
          "patching_rect": [
            690,
            800,
            555,
            22
          ],
          "text": "unpack f f f f f",
          "numinlets": 1,
          "numoutlets": 5,
          "outlettype": [
            "float",
            "float",
            "float",
            "float",
            "float"
          ]
        }
      },
      {
        "box": {
          "id": "right_statusset",
          "maxclass": "newobj",
          "patching_rect": [
            940,
            440,
            95,
            22
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "right_art",
          "maxclass": "newobj",
          "patching_rect": [
            820,
            440,
            90,
            22
          ],
          "text": "prepend right"
        }
      },
      {
        "box": {
          "id": "right_pinky_label",
          "maxclass": "live.comment",
          "patching_rect": [
            690,
            540,
            90,
            14
          ],
          "text": "PINKY",
          "presentation": 1,
          "presentation_rect": [
            591,
            27,
            46,
            11
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0,
          "textjustification": 0
        }
      },
      {
        "box": {
          "id": "right_pinky",
          "maxclass": "live.numbox",
          "patching_rect": [
            690,
            602,
            46,
            16
          ],
          "presentation": 1,
          "presentation_rect": [
            591,
            40,
            46,
            16
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "parameter_enable": 1,
          "varname": "right_pinky",
          "fontsize": 10,
          "annotation": "Filtered normalized finger value, from 0 to 1.",
          "focusbordercolor": [
            1,
            0.71,
            0.196,
            1
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Pinky",
              "parameter_shortname": "Right Pinky",
              "parameter_type": 0,
              "parameter_mmin": 0.0,
              "parameter_mmax": 1.0,
              "parameter_initial": [
                0.0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 9,
              "parameter_units": "%0.3f",
              "parameter_invisible": 2
            }
          },
          "ignoreclick": 1,
          "parameter_mappable": 0
        }
      },
      {
        "box": {
          "id": "right_pinky_set",
          "maxclass": "newobj",
          "patching_rect": [
            690,
            565,
            90,
            22
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "right_ring_label",
          "maxclass": "live.comment",
          "patching_rect": [
            802,
            540,
            90,
            14
          ],
          "text": "RING",
          "presentation": 1,
          "presentation_rect": [
            532,
            27,
            46,
            11
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0,
          "textjustification": 0
        }
      },
      {
        "box": {
          "id": "right_ring",
          "maxclass": "live.numbox",
          "patching_rect": [
            802,
            602,
            46,
            16
          ],
          "presentation": 1,
          "presentation_rect": [
            532,
            40,
            46,
            16
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "parameter_enable": 1,
          "varname": "right_ring",
          "fontsize": 10,
          "annotation": "Filtered normalized finger value, from 0 to 1.",
          "focusbordercolor": [
            1,
            0.71,
            0.196,
            1
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Ring",
              "parameter_shortname": "Right Ring",
              "parameter_type": 0,
              "parameter_mmin": 0.0,
              "parameter_mmax": 1.0,
              "parameter_initial": [
                0.0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 9,
              "parameter_units": "%0.3f",
              "parameter_invisible": 2
            }
          },
          "ignoreclick": 1,
          "parameter_mappable": 0
        }
      },
      {
        "box": {
          "id": "right_ring_set",
          "maxclass": "newobj",
          "patching_rect": [
            802,
            565,
            90,
            22
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "right_middle_label",
          "maxclass": "live.comment",
          "patching_rect": [
            914,
            540,
            90,
            14
          ],
          "text": "MIDDLE",
          "presentation": 1,
          "presentation_rect": [
            473,
            27,
            46,
            11
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0,
          "textjustification": 0
        }
      },
      {
        "box": {
          "id": "right_middle",
          "maxclass": "live.numbox",
          "patching_rect": [
            914,
            602,
            46,
            16
          ],
          "presentation": 1,
          "presentation_rect": [
            473,
            40,
            46,
            16
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "parameter_enable": 1,
          "varname": "right_middle",
          "fontsize": 10,
          "annotation": "Filtered normalized finger value, from 0 to 1.",
          "focusbordercolor": [
            1,
            0.71,
            0.196,
            1
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Middle",
              "parameter_shortname": "Right Middle",
              "parameter_type": 0,
              "parameter_mmin": 0.0,
              "parameter_mmax": 1.0,
              "parameter_initial": [
                0.0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 9,
              "parameter_units": "%0.3f",
              "parameter_invisible": 2
            }
          },
          "ignoreclick": 1,
          "parameter_mappable": 0
        }
      },
      {
        "box": {
          "id": "right_middle_set",
          "maxclass": "newobj",
          "patching_rect": [
            914,
            565,
            90,
            22
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "right_index_label",
          "maxclass": "live.comment",
          "patching_rect": [
            1026,
            540,
            90,
            14
          ],
          "text": "INDEX",
          "presentation": 1,
          "presentation_rect": [
            414,
            27,
            46,
            11
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0,
          "textjustification": 0
        }
      },
      {
        "box": {
          "id": "right_index",
          "maxclass": "live.numbox",
          "patching_rect": [
            1026,
            602,
            46,
            16
          ],
          "presentation": 1,
          "presentation_rect": [
            414,
            40,
            46,
            16
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "parameter_enable": 1,
          "varname": "right_index",
          "fontsize": 10,
          "annotation": "Filtered normalized finger value, from 0 to 1.",
          "focusbordercolor": [
            1,
            0.71,
            0.196,
            1
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Index",
              "parameter_shortname": "Right Index",
              "parameter_type": 0,
              "parameter_mmin": 0.0,
              "parameter_mmax": 1.0,
              "parameter_initial": [
                0.0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 9,
              "parameter_units": "%0.3f",
              "parameter_invisible": 2
            }
          },
          "ignoreclick": 1,
          "parameter_mappable": 0
        }
      },
      {
        "box": {
          "id": "right_index_set",
          "maxclass": "newobj",
          "patching_rect": [
            1026,
            565,
            90,
            22
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "right_thumb_label",
          "maxclass": "live.comment",
          "patching_rect": [
            1138,
            540,
            90,
            14
          ],
          "text": "THUMB",
          "presentation": 1,
          "presentation_rect": [
            340,
            27,
            46,
            11
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0,
          "textjustification": 0
        }
      },
      {
        "box": {
          "id": "right_thumb",
          "maxclass": "live.numbox",
          "patching_rect": [
            1138,
            602,
            46,
            16
          ],
          "presentation": 1,
          "presentation_rect": [
            340,
            40,
            46,
            16
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "parameter_enable": 1,
          "varname": "right_thumb",
          "fontsize": 10,
          "annotation": "Filtered normalized finger value, from 0 to 1.",
          "focusbordercolor": [
            1,
            0.71,
            0.196,
            1
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Thumb",
              "parameter_shortname": "Right Thumb",
              "parameter_type": 0,
              "parameter_mmin": 0.0,
              "parameter_mmax": 1.0,
              "parameter_initial": [
                0.0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 9,
              "parameter_units": "%0.3f",
              "parameter_invisible": 2
            }
          },
          "ignoreclick": 1,
          "parameter_mappable": 0
        }
      },
      {
        "box": {
          "id": "right_thumb_set",
          "maxclass": "newobj",
          "patching_rect": [
            1138,
            565,
            90,
            22
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "right_calibrate",
          "maxclass": "live.text",
          "patching_rect": [
            20,
            1952,
            145,
            22
          ],
          "text": "Calibrate",
          "presentation": 1,
          "presentation_rect": [
            540,
            4,
            60,
            15
          ],
          "texton": "Calibrate",
          "mode": 0,
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "right_calibrate",
          "fontsize": 9,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Calibrate",
              "parameter_shortname": "Right Calibrate",
              "parameter_type": 2,
              "parameter_enum": [
                "Off",
                "On"
              ],
              "parameter_mmax": 1,
              "parameter_initial": [
                0
              ],
              "parameter_initial_enable": 1,
              "parameter_invisible": 2
            }
          }
        }
      },
      {
        "box": {
          "id": "right_cal_press",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            1976,
            145,
            22
          ],
          "text": "t b b"
        }
      },
      {
        "box": {
          "id": "right_cal_open",
          "maxclass": "message",
          "patching_rect": [
            20,
            2000,
            145,
            22
          ],
          "text": "open"
        }
      },
      {
        "box": {
          "id": "right_cal_control",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            2024,
            145,
            22
          ],
          "text": "pcontrol"
        }
      },
      {
        "box": {
          "id": "right_calibration",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            2048,
            145,
            22
          ],
          "text": "p Right_Calibration",
          "patcher": {
            "fileversion": 1,
            "appversion": {
              "major": 9,
              "minor": 1,
              "revision": 3,
              "architecture": "arm64",
              "modernui": 1
            },
            "classnamespace": "box",
            "rect": [
              120,
              160,
              440,
              222
            ],
            "openinpresentation": 1,
            "default_fontsize": 11,
            "default_fontname": "Arial",
            "devicewidth": 440,
            "enablehscroll": 0,
            "enablevscroll": 0,
            "boxes": [
              {
                "box": {
                  "id": "cal_title",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    200,
                    145,
                    22
                  ],
                  "text": "RIGHT HAND  /  CALIBRATION",
                  "presentation": 1,
                  "presentation_rect": [
                    10,
                    7,
                    420,
                    18
                  ],
                  "fontsize": 11,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "cal_hint",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    224,
                    145,
                    22
                  ],
                  "text": "Hold each pose still for 0.3 seconds before capturing.",
                  "presentation": 1,
                  "presentation_rect": [
                    10,
                    29,
                    420,
                    16
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "cal_open",
                  "maxclass": "live.text",
                  "patching_rect": [
                    20,
                    248,
                    145,
                    22
                  ],
                  "text": "Open → 0",
                  "presentation": 1,
                  "presentation_rect": [
                    10,
                    51,
                    130,
                    22
                  ],
                  "texton": "Open → 0",
                  "mode": 0,
                  "numinlets": 1,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "parameter_enable": 1,
                  "varname": "cal_open",
                  "fontsize": 9,
                  "saved_attribute_attributes": {
                    "valueof": {
                      "parameter_longname": "Right Calibration open",
                      "parameter_shortname": "Right Calibration open",
                      "parameter_type": 2,
                      "parameter_enum": [
                        "Off",
                        "On"
                      ],
                      "parameter_mmax": 1,
                      "parameter_initial": [
                        0
                      ],
                      "parameter_initial_enable": 1,
                      "parameter_invisible": 2
                    }
                  }
                }
              },
              {
                "box": {
                  "id": "cal_open_bang",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    272,
                    145,
                    22
                  ],
                  "text": "t b"
                }
              },
              {
                "box": {
                  "id": "cal_open_command",
                  "maxclass": "message",
                  "patching_rect": [
                    20,
                    296,
                    145,
                    22
                  ],
                  "text": "capture 1 open"
                }
              },
              {
                "box": {
                  "id": "cal_fist",
                  "maxclass": "live.text",
                  "patching_rect": [
                    20,
                    320,
                    145,
                    22
                  ],
                  "text": "Fist → 0.9",
                  "presentation": 1,
                  "presentation_rect": [
                    150,
                    51,
                    130,
                    22
                  ],
                  "texton": "Fist → 0.9",
                  "mode": 0,
                  "numinlets": 1,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "parameter_enable": 1,
                  "varname": "cal_fist",
                  "fontsize": 9,
                  "saved_attribute_attributes": {
                    "valueof": {
                      "parameter_longname": "Right Calibration fist",
                      "parameter_shortname": "Right Calibration fist",
                      "parameter_type": 2,
                      "parameter_enum": [
                        "Off",
                        "On"
                      ],
                      "parameter_mmax": 1,
                      "parameter_initial": [
                        0
                      ],
                      "parameter_initial_enable": 1,
                      "parameter_invisible": 2
                    }
                  }
                }
              },
              {
                "box": {
                  "id": "cal_fist_bang",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    344,
                    145,
                    22
                  ],
                  "text": "t b"
                }
              },
              {
                "box": {
                  "id": "cal_fist_command",
                  "maxclass": "message",
                  "patching_rect": [
                    20,
                    368,
                    145,
                    22
                  ],
                  "text": "capture 1 fist"
                }
              },
              {
                "box": {
                  "id": "cal_clear",
                  "maxclass": "live.text",
                  "patching_rect": [
                    20,
                    392,
                    145,
                    22
                  ],
                  "text": "Reset",
                  "presentation": 1,
                  "presentation_rect": [
                    290,
                    51,
                    130,
                    22
                  ],
                  "texton": "Reset",
                  "mode": 0,
                  "numinlets": 1,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "parameter_enable": 1,
                  "varname": "cal_clear",
                  "fontsize": 9,
                  "saved_attribute_attributes": {
                    "valueof": {
                      "parameter_longname": "Right Calibration clear",
                      "parameter_shortname": "Right Calibration clear",
                      "parameter_type": 2,
                      "parameter_enum": [
                        "Off",
                        "On"
                      ],
                      "parameter_mmax": 1,
                      "parameter_initial": [
                        0
                      ],
                      "parameter_initial_enable": 1,
                      "parameter_invisible": 2
                    }
                  }
                }
              },
              {
                "box": {
                  "id": "cal_clear_bang",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    416,
                    145,
                    22
                  ],
                  "text": "t b"
                }
              },
              {
                "box": {
                  "id": "cal_clear_command",
                  "maxclass": "message",
                  "patching_rect": [
                    20,
                    440,
                    145,
                    22
                  ],
                  "text": "clearcal 1"
                }
              },
              {
                "box": {
                  "id": "cal_status",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    464,
                    145,
                    22
                  ],
                  "text": "Default range. Capture Open and Fist.",
                  "presentation": 1,
                  "presentation_rect": [
                    10,
                    80,
                    420,
                    17
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "cal_headroom",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    488,
                    145,
                    22
                  ],
                  "text": "Fist = 0.900; extra bend may rise to 1.000.",
                  "presentation": 1,
                  "presentation_rect": [
                    10,
                    102,
                    420,
                    16
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "input_label",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    512,
                    145,
                    22
                  ],
                  "text": "Input: no data",
                  "presentation": 1,
                  "presentation_rect": [
                    10,
                    124,
                    420,
                    16
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "raw_row_label",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    536,
                    145,
                    22
                  ],
                  "text": "Input",
                  "presentation": 1,
                  "presentation_rect": [
                    10,
                    161,
                    65,
                    17
                  ],
                  "fontsize": 9,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "open_label",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    560,
                    145,
                    22
                  ],
                  "text": "Open saved",
                  "presentation": 1,
                  "presentation_rect": [
                    10,
                    181,
                    75,
                    17
                  ],
                  "fontsize": 9,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "fist_label",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    584,
                    145,
                    22
                  ],
                  "text": "Fist saved",
                  "presentation": 1,
                  "presentation_rect": [
                    10,
                    201,
                    75,
                    17
                  ],
                  "fontsize": 9,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "inspect_finger_0",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    608,
                    145,
                    22
                  ],
                  "text": "PINKY",
                  "presentation": 1,
                  "presentation_rect": [
                    95,
                    145,
                    62,
                    12
                  ],
                  "fontsize": 8,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "input0",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    632,
                    145,
                    22
                  ],
                  "text": "—",
                  "presentation": 1,
                  "presentation_rect": [
                    95,
                    161,
                    62,
                    17
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "open0",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    656,
                    145,
                    22
                  ],
                  "text": "—",
                  "presentation": 1,
                  "presentation_rect": [
                    95,
                    181,
                    62,
                    17
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "fist0",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    680,
                    145,
                    22
                  ],
                  "text": "—",
                  "presentation": 1,
                  "presentation_rect": [
                    95,
                    201,
                    62,
                    17
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "inspect_finger_1",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    704,
                    145,
                    22
                  ],
                  "text": "RING",
                  "presentation": 1,
                  "presentation_rect": [
                    159,
                    145,
                    62,
                    12
                  ],
                  "fontsize": 8,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "input1",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    728,
                    145,
                    22
                  ],
                  "text": "—",
                  "presentation": 1,
                  "presentation_rect": [
                    159,
                    161,
                    62,
                    17
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "open1",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    752,
                    145,
                    22
                  ],
                  "text": "—",
                  "presentation": 1,
                  "presentation_rect": [
                    159,
                    181,
                    62,
                    17
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "fist1",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    776,
                    145,
                    22
                  ],
                  "text": "—",
                  "presentation": 1,
                  "presentation_rect": [
                    159,
                    201,
                    62,
                    17
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "inspect_finger_2",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    800,
                    145,
                    22
                  ],
                  "text": "MIDDLE",
                  "presentation": 1,
                  "presentation_rect": [
                    223,
                    145,
                    62,
                    12
                  ],
                  "fontsize": 8,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "input2",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    824,
                    145,
                    22
                  ],
                  "text": "—",
                  "presentation": 1,
                  "presentation_rect": [
                    223,
                    161,
                    62,
                    17
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "open2",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    848,
                    145,
                    22
                  ],
                  "text": "—",
                  "presentation": 1,
                  "presentation_rect": [
                    223,
                    181,
                    62,
                    17
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "fist2",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    872,
                    145,
                    22
                  ],
                  "text": "—",
                  "presentation": 1,
                  "presentation_rect": [
                    223,
                    201,
                    62,
                    17
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "inspect_finger_3",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    896,
                    145,
                    22
                  ],
                  "text": "INDEX",
                  "presentation": 1,
                  "presentation_rect": [
                    287,
                    145,
                    62,
                    12
                  ],
                  "fontsize": 8,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "input3",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    920,
                    145,
                    22
                  ],
                  "text": "—",
                  "presentation": 1,
                  "presentation_rect": [
                    287,
                    161,
                    62,
                    17
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "open3",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    944,
                    145,
                    22
                  ],
                  "text": "—",
                  "presentation": 1,
                  "presentation_rect": [
                    287,
                    181,
                    62,
                    17
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "fist3",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    968,
                    145,
                    22
                  ],
                  "text": "—",
                  "presentation": 1,
                  "presentation_rect": [
                    287,
                    201,
                    62,
                    17
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "inspect_finger_4",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    992,
                    145,
                    22
                  ],
                  "text": "THUMB",
                  "presentation": 1,
                  "presentation_rect": [
                    351,
                    145,
                    62,
                    12
                  ],
                  "fontsize": 8,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "input4",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    1016,
                    145,
                    22
                  ],
                  "text": "—",
                  "presentation": 1,
                  "presentation_rect": [
                    351,
                    161,
                    62,
                    17
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "open4",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    1040,
                    145,
                    22
                  ],
                  "text": "—",
                  "presentation": 1,
                  "presentation_rect": [
                    351,
                    181,
                    62,
                    17
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "fist4",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    1064,
                    145,
                    22
                  ],
                  "text": "—",
                  "presentation": 1,
                  "presentation_rect": [
                    351,
                    201,
                    62,
                    17
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "cal_input",
                  "maxclass": "inlet",
                  "patching_rect": [
                    20,
                    1088,
                    145,
                    22
                  ],
                  "numinlets": 0,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "cal_data_route",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1112,
                    145,
                    22
                  ],
                  "text": "route input_label open_label fist_label input0 input1 input2 input3 input4 open0 open1 open2 open3 open4 fist0 fist1 fist2 fist3 fist4",
                  "numinlets": 1,
                  "numoutlets": 19,
                  "outlettype": [
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    ""
                  ]
                }
              },
              {
                "box": {
                  "id": "input_label_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1136,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "open_label_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1160,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "fist_label_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1184,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "input0_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1208,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "input1_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1232,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "input2_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1256,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "input3_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1280,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "input4_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1304,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "open0_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1328,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "open1_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1352,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "open2_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1376,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "open3_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1400,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "open4_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1424,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "fist0_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1448,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "fist1_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1472,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "fist2_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1496,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "fist3_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1520,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "fist4_set",
                  "maxclass": "newobj",
                  "patching_rect": [
                    20,
                    1544,
                    145,
                    22
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "cal_output",
                  "maxclass": "outlet",
                  "patching_rect": [
                    20,
                    1568,
                    145,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 0
                }
              }
            ],
            "lines": [
              {
                "patchline": {
                  "source": [
                    "cal_open",
                    0
                  ],
                  "destination": [
                    "cal_open_bang",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_open_bang",
                    0
                  ],
                  "destination": [
                    "cal_open_command",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_open_command",
                    0
                  ],
                  "destination": [
                    "cal_output",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_fist",
                    0
                  ],
                  "destination": [
                    "cal_fist_bang",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_fist_bang",
                    0
                  ],
                  "destination": [
                    "cal_fist_command",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_fist_command",
                    0
                  ],
                  "destination": [
                    "cal_output",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_clear",
                    0
                  ],
                  "destination": [
                    "cal_clear_bang",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_clear_bang",
                    0
                  ],
                  "destination": [
                    "cal_clear_command",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_clear_command",
                    0
                  ],
                  "destination": [
                    "cal_output",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_input",
                    0
                  ],
                  "destination": [
                    "cal_data_route",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    0
                  ],
                  "destination": [
                    "input_label_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "input_label_set",
                    0
                  ],
                  "destination": [
                    "input_label",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    1
                  ],
                  "destination": [
                    "open_label_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "open_label_set",
                    0
                  ],
                  "destination": [
                    "open_label",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    2
                  ],
                  "destination": [
                    "fist_label_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "fist_label_set",
                    0
                  ],
                  "destination": [
                    "fist_label",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    3
                  ],
                  "destination": [
                    "input0_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "input0_set",
                    0
                  ],
                  "destination": [
                    "input0",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    4
                  ],
                  "destination": [
                    "input1_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "input1_set",
                    0
                  ],
                  "destination": [
                    "input1",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    5
                  ],
                  "destination": [
                    "input2_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "input2_set",
                    0
                  ],
                  "destination": [
                    "input2",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    6
                  ],
                  "destination": [
                    "input3_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "input3_set",
                    0
                  ],
                  "destination": [
                    "input3",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    7
                  ],
                  "destination": [
                    "input4_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "input4_set",
                    0
                  ],
                  "destination": [
                    "input4",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    8
                  ],
                  "destination": [
                    "open0_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "open0_set",
                    0
                  ],
                  "destination": [
                    "open0",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    9
                  ],
                  "destination": [
                    "open1_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "open1_set",
                    0
                  ],
                  "destination": [
                    "open1",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    10
                  ],
                  "destination": [
                    "open2_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "open2_set",
                    0
                  ],
                  "destination": [
                    "open2",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    11
                  ],
                  "destination": [
                    "open3_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "open3_set",
                    0
                  ],
                  "destination": [
                    "open3",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    12
                  ],
                  "destination": [
                    "open4_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "open4_set",
                    0
                  ],
                  "destination": [
                    "open4",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    13
                  ],
                  "destination": [
                    "fist0_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "fist0_set",
                    0
                  ],
                  "destination": [
                    "fist0",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    14
                  ],
                  "destination": [
                    "fist1_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "fist1_set",
                    0
                  ],
                  "destination": [
                    "fist1",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    15
                  ],
                  "destination": [
                    "fist2_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "fist2_set",
                    0
                  ],
                  "destination": [
                    "fist2",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    16
                  ],
                  "destination": [
                    "fist3_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "fist3_set",
                    0
                  ],
                  "destination": [
                    "fist3",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    17
                  ],
                  "destination": [
                    "fist4_set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "fist4_set",
                    0
                  ],
                  "destination": [
                    "fist4",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal_data_route",
                    18
                  ],
                  "destination": [
                    "cal_status",
                    0
                  ]
                }
              }
            ],
            "parameters": {
              "cal_open": [
                "Right Calibration open",
                "Right Calibration open",
                0
              ],
              "cal_fist": [
                "Right Calibration fist",
                "Right Calibration fist",
                0
              ],
              "cal_clear": [
                "Right Calibration clear",
                "Right Calibration clear",
                0
              ]
            }
          },
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "varname": "right_calibration"
        }
      },
      {
        "box": {
          "id": "right_cal_statusset",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            2072,
            145,
            22
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "calibration_state",
          "maxclass": "newobj",
          "patching_rect": [
            520,
            905,
            145,
            22
          ],
          "text": "pattr hand_calibration @bindto engine @initial none",
          "varname": "hand_calibration",
          "parameter_enable": 1,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Hand Calibration",
              "parameter_shortname": "Calibration",
              "parameter_type": 3,
              "parameter_invisible": 1,
              "parameter_initial": [
                "none"
              ],
              "parameter_initial_enable": 1
            }
          }
        }
      },
      {
        "box": {
          "id": "filter_enabled",
          "maxclass": "live.text",
          "patching_rect": [
            765,
            905,
            145,
            22
          ],
          "text": "Stabilize",
          "presentation": 1,
          "presentation_rect": [
            8,
            127,
            54,
            16
          ],
          "texton": "Stabilize",
          "mode": 1,
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "filter_enabled",
          "fontsize": 9,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Stabilize",
              "parameter_shortname": "Stabilize",
              "parameter_type": 2,
              "parameter_enum": [
                "Off",
                "On"
              ],
              "parameter_mmax": 1,
              "parameter_initial": [
                1
              ],
              "parameter_initial_enable": 1,
              "parameter_invisible": 1
            }
          }
        }
      },
      {
        "box": {
          "id": "smooth_label",
          "maxclass": "live.comment",
          "patching_rect": [
            1010,
            905,
            145,
            22
          ],
          "text": "Smooth",
          "presentation": 1,
          "presentation_rect": [
            72,
            126,
            39,
            17
          ],
          "fontsize": 9,
          "numinlets": 1,
          "numoutlets": 0,
          "textjustification": 0
        }
      },
      {
        "box": {
          "id": "smooth_ms",
          "maxclass": "live.numbox",
          "patching_rect": [
            30,
            960,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            113,
            127,
            46,
            16
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "parameter_enable": 1,
          "varname": "smooth_ms",
          "fontsize": 10,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Smooth ms",
              "parameter_shortname": "Smooth ms",
              "parameter_type": 0,
              "parameter_mmin": 0,
              "parameter_mmax": 500,
              "parameter_initial": [
                8
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 2
            }
          }
        }
      },
      {
        "box": {
          "id": "dead_label",
          "maxclass": "live.comment",
          "patching_rect": [
            275,
            960,
            145,
            22
          ],
          "text": "Deadband",
          "presentation": 1,
          "presentation_rect": [
            169,
            126,
            48,
            17
          ],
          "fontsize": 9,
          "numinlets": 1,
          "numoutlets": 0,
          "textjustification": 0
        }
      },
      {
        "box": {
          "id": "deadband",
          "maxclass": "live.numbox",
          "patching_rect": [
            520,
            960,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            222,
            127,
            52,
            16
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "parameter_enable": 1,
          "varname": "deadband",
          "fontsize": 10,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Deadband",
              "parameter_shortname": "Deadband",
              "parameter_type": 0,
              "parameter_mmin": 0,
              "parameter_mmax": 0.1,
              "parameter_initial": [
                0.003
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 9,
              "parameter_units": "%0.3f"
            }
          }
        }
      },
      {
        "box": {
          "id": "filter_enabled_prepend",
          "maxclass": "newobj",
          "patching_rect": [
            765,
            960,
            145,
            22
          ],
          "text": "prepend enabled"
        }
      },
      {
        "box": {
          "id": "smooth_ms_prepend",
          "maxclass": "newobj",
          "patching_rect": [
            1010,
            960,
            145,
            22
          ],
          "text": "prepend smooth"
        }
      },
      {
        "box": {
          "id": "deadband_prepend",
          "maxclass": "newobj",
          "patching_rect": [
            30,
            1015,
            145,
            22
          ],
          "text": "prepend deadband"
        }
      },
      {
        "box": {
          "id": "osc_enable",
          "maxclass": "live.text",
          "patching_rect": [
            275,
            1015,
            145,
            22
          ],
          "text": "OSC Out",
          "presentation": 1,
          "presentation_rect": [
            8,
            150,
            51,
            16
          ],
          "texton": "OSC Out",
          "mode": 1,
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "osc_enable",
          "fontsize": 9,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "OSC Out",
              "parameter_shortname": "OSC Out",
              "parameter_type": 2,
              "parameter_enum": [
                "Off",
                "On"
              ],
              "parameter_mmax": 1,
              "parameter_initial": [
                0
              ],
              "parameter_initial_enable": 1,
              "parameter_invisible": 1
            }
          }
        }
      },
      {
        "box": {
          "id": "ip_label",
          "maxclass": "live.comment",
          "patching_rect": [
            520,
            1015,
            145,
            22
          ],
          "text": "IP",
          "presentation": 1,
          "presentation_rect": [
            69,
            149,
            15,
            17
          ],
          "fontsize": 9,
          "numinlets": 1,
          "numoutlets": 0,
          "textjustification": 0
        }
      },
      {
        "box": {
          "id": "osc_host",
          "maxclass": "textedit",
          "patching_rect": [
            765,
            1015,
            145,
            22
          ],
          "text": "127.0.0.1",
          "presentation": 1,
          "presentation_rect": [
            88,
            149,
            174,
            17
          ],
          "varname": "osc_host",
          "numinlets": 1,
          "numoutlets": 4,
          "outlettype": [
            "",
            "int",
            "",
            ""
          ],
          "keymode": 1,
          "lines": 1,
          "wordwrap": 0,
          "fontsize": 10,
          "border": 0,
          "rounded": 0,
          "saved_attribute_attributes": {
            "bgcolor": {
              "expression": "themecolor.live_lcd_bg"
            },
            "textcolor": {
              "expression": "themecolor.live_lcd_control_fg"
            }
          }
        }
      },
      {
        "box": {
          "id": "host_state",
          "maxclass": "newobj",
          "patching_rect": [
            1010,
            1015,
            145,
            22
          ],
          "text": "pattr destination @bindto osc_host @initial 127.0.0.1",
          "varname": "destination",
          "parameter_enable": 1,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "OSC Destination",
              "parameter_shortname": "Destination",
              "parameter_type": 3,
              "parameter_invisible": 1,
              "parameter_initial": [
                "127.0.0.1"
              ],
              "parameter_initial_enable": 1
            }
          }
        }
      },
      {
        "box": {
          "id": "port_label",
          "maxclass": "live.comment",
          "patching_rect": [
            30,
            1070,
            145,
            22
          ],
          "text": "Port",
          "presentation": 1,
          "presentation_rect": [
            274,
            149,
            24,
            17
          ],
          "fontsize": 9,
          "numinlets": 1,
          "numoutlets": 0,
          "textjustification": 0
        }
      },
      {
        "box": {
          "id": "osc_port",
          "maxclass": "live.numbox",
          "patching_rect": [
            275,
            1070,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            302,
            150,
            58,
            16
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "parameter_enable": 1,
          "varname": "osc_port",
          "fontsize": 10,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "OSC Port",
              "parameter_shortname": "OSC Port",
              "parameter_type": 0,
              "parameter_mmin": 1,
              "parameter_mmax": 65535,
              "parameter_initial": [
                8000
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 0
            }
          }
        }
      },
      {
        "box": {
          "id": "apply",
          "maxclass": "live.text",
          "patching_rect": [
            520,
            1070,
            145,
            22
          ],
          "text": "Apply",
          "presentation": 1,
          "presentation_rect": [
            370,
            150,
            46,
            16
          ],
          "texton": "Apply",
          "mode": 0,
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "apply",
          "fontsize": 9,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Apply",
              "parameter_shortname": "Apply",
              "parameter_type": 2,
              "parameter_enum": [
                "Off",
                "On"
              ],
              "parameter_mmax": 1,
              "parameter_initial": [
                0
              ],
              "parameter_initial_enable": 1,
              "parameter_invisible": 2
            }
          }
        }
      },
      {
        "box": {
          "id": "host_route",
          "maxclass": "newobj",
          "patching_rect": [
            765,
            1070,
            145,
            22
          ],
          "text": "route text"
        }
      },
      {
        "box": {
          "id": "host_prepend",
          "maxclass": "newobj",
          "patching_rect": [
            1010,
            1070,
            145,
            22
          ],
          "text": "prepend host"
        }
      },
      {
        "box": {
          "id": "port_integer",
          "maxclass": "newobj",
          "patching_rect": [
            30,
            1125,
            145,
            22
          ],
          "text": "i"
        }
      },
      {
        "box": {
          "id": "port_prepend",
          "maxclass": "newobj",
          "patching_rect": [
            275,
            1125,
            145,
            22
          ],
          "text": "prepend port"
        }
      },
      {
        "box": {
          "id": "udpout",
          "maxclass": "newobj",
          "patching_rect": [
            520,
            1125,
            160,
            22
          ],
          "text": "udpsend 127.0.0.1 8000"
        }
      },
      {
        "box": {
          "id": "apply_bang",
          "maxclass": "newobj",
          "patching_rect": [
            765,
            1125,
            145,
            22
          ],
          "text": "t b b"
        }
      },
      {
        "box": {
          "id": "startup_destination",
          "maxclass": "newobj",
          "patching_rect": [
            1010,
            1125,
            145,
            22
          ],
          "text": "deferlow"
        }
      },
      {
        "box": {
          "id": "osc_switch",
          "maxclass": "newobj",
          "patching_rect": [
            30,
            1180,
            145,
            22
          ],
          "text": "t b i"
        }
      },
      {
        "box": {
          "id": "flush",
          "maxclass": "message",
          "patching_rect": [
            275,
            1180,
            145,
            22
          ],
          "text": "flush"
        }
      },
      {
        "box": {
          "id": "left_osc_gate",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            2696,
            145,
            22
          ],
          "text": "gate 1"
        }
      },
      {
        "box": {
          "id": "left_osc_prefix",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            2720,
            145,
            22
          ],
          "text": "prepend /GLeft"
        }
      },
      {
        "box": {
          "id": "right_osc_gate",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            2744,
            145,
            22
          ],
          "text": "gate 1"
        }
      },
      {
        "box": {
          "id": "right_osc_prefix",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            2768,
            145,
            22
          ],
          "text": "prepend /GRight"
        }
      },
      {
        "box": {
          "id": "host_flush",
          "maxclass": "newobj",
          "patching_rect": [
            520,
            1180,
            145,
            22
          ],
          "text": "deferlow"
        }
      },
      {
        "box": {
          "id": "audioin",
          "maxclass": "newobj",
          "patching_rect": [
            765,
            1180,
            75,
            22
          ],
          "text": "plugin~"
        }
      },
      {
        "box": {
          "id": "audioout",
          "maxclass": "newobj",
          "patching_rect": [
            1010,
            1180,
            75,
            22
          ],
          "text": "plugout~"
        }
      },
      {
        "box": {
          "id": "bus_hint",
          "maxclass": "live.comment",
          "patching_rect": [
            30,
            1235,
            145,
            22
          ],
          "text": "GLeft / GRight  →  Glove Mapper",
          "presentation": 1,
          "presentation_rect": [
            436,
            149,
            204,
            17
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0,
          "textjustification": 0
        }
      },
      {
        "box": {
          "id": "input_label",
          "maxclass": "live.comment",
          "patching_rect": [
            275,
            1235,
            145,
            22
          ],
          "text": "Input",
          "presentation": 1,
          "presentation_rect": [
            436,
            126,
            31,
            17
          ],
          "fontsize": 9,
          "numinlets": 1,
          "numoutlets": 0,
          "textjustification": 0
        }
      },
      {
        "box": {
          "id": "input_mode",
          "maxclass": "live.menu",
          "patching_rect": [
            520,
            1235,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            471,
            127,
            63,
            16
          ],
          "varname": "input_mode",
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "int",
            "",
            "float"
          ],
          "parameter_enable": 1,
          "fontsize": 10,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Input Mode",
              "parameter_shortname": "Input",
              "parameter_type": 2,
              "parameter_enum": [
                "OSC",
                "USB"
              ],
              "parameter_mmax": 1,
              "parameter_initial": [
                0
              ],
              "parameter_initial_enable": 1,
              "parameter_invisible": 1
            }
          }
        }
      },
      {
        "box": {
          "id": "usb_setup",
          "maxclass": "live.text",
          "patching_rect": [
            765,
            1235,
            145,
            22
          ],
          "text": "USB…",
          "presentation": 1,
          "presentation_rect": [
            544,
            127,
            96,
            16
          ],
          "texton": "USB…",
          "mode": 0,
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "usb_setup",
          "fontsize": 9,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "USB…",
              "parameter_shortname": "USB…",
              "parameter_type": 2,
              "parameter_enum": [
                "Off",
                "On"
              ],
              "parameter_mmax": 1,
              "parameter_initial": [
                0
              ],
              "parameter_initial_enable": 1,
              "parameter_invisible": 2
            }
          }
        }
      },
      {
        "box": {
          "id": "usb_setup_press",
          "maxclass": "newobj",
          "patching_rect": [
            1010,
            1235,
            145,
            22
          ],
          "text": "t b"
        }
      },
      {
        "box": {
          "id": "usb_setup_open",
          "maxclass": "message",
          "patching_rect": [
            30,
            1290,
            145,
            22
          ],
          "text": "open"
        }
      },
      {
        "box": {
          "id": "usb_setup_control",
          "maxclass": "newobj",
          "patching_rect": [
            275,
            1290,
            145,
            22
          ],
          "text": "pcontrol"
        }
      },
      {
        "box": {
          "id": "usb_settings",
          "maxclass": "newobj",
          "patching_rect": [
            520,
            1290,
            145,
            22
          ],
          "text": "p USB_Settings",
          "patcher": {
            "fileversion": 1,
            "appversion": {
              "major": 9,
              "minor": 1,
              "revision": 3,
              "architecture": "arm64",
              "modernui": 1
            },
            "classnamespace": "box",
            "rect": [
              120,
              160,
              580,
              80
            ],
            "openinpresentation": 1,
            "default_fontsize": 11,
            "default_fontname": "Arial",
            "devicewidth": 580,
            "enablehscroll": 0,
            "enablevscroll": 0,
            "boxes": [
              {
                "box": {
                  "id": "usb_port_label",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    150,
                    26,
                    18
                  ],
                  "text": "Port",
                  "presentation": 1,
                  "presentation_rect": [
                    8,
                    7,
                    26,
                    18
                  ],
                  "fontsize": 9,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "usb_ports",
                  "maxclass": "umenu",
                  "patching_rect": [
                    210,
                    150,
                    180,
                    18
                  ],
                  "presentation": 1,
                  "presentation_rect": [
                    40,
                    8,
                    286,
                    18
                  ],
                  "varname": "usb_ports",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "int",
                    "",
                    ""
                  ],
                  "items": [
                    "Choose USB port"
                  ],
                  "parameter_enable": 0,
                  "fontsize": 10,
                  "allowdrag": 0,
                  "saved_attribute_attributes": {
                    "bgfillcolor": {
                      "expression": "themecolor.live_lcd_bg"
                    },
                    "textcolor": {
                      "expression": "themecolor.live_lcd_control_fg"
                    }
                  }
                }
              },
              {
                "box": {
                  "id": "usb_refresh",
                  "maxclass": "live.text",
                  "patching_rect": [
                    400,
                    150,
                    57,
                    18
                  ],
                  "text": "Refresh",
                  "presentation": 1,
                  "presentation_rect": [
                    334,
                    8,
                    57,
                    18
                  ],
                  "texton": "Refresh",
                  "mode": 0,
                  "numinlets": 1,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "parameter_enable": 1,
                  "varname": "usb_refresh",
                  "fontsize": 9,
                  "saved_attribute_attributes": {
                    "valueof": {
                      "parameter_longname": "Refresh",
                      "parameter_shortname": "Refresh",
                      "parameter_type": 2,
                      "parameter_enum": [
                        "Off",
                        "On"
                      ],
                      "parameter_mmax": 1,
                      "parameter_initial": [
                        0
                      ],
                      "parameter_initial_enable": 1,
                      "parameter_invisible": 2
                    }
                  }
                }
              },
              {
                "box": {
                  "id": "usb_connect",
                  "maxclass": "live.text",
                  "patching_rect": [
                    20,
                    182,
                    50,
                    18
                  ],
                  "text": "Open",
                  "presentation": 1,
                  "presentation_rect": [
                    399,
                    8,
                    50,
                    18
                  ],
                  "texton": "Open",
                  "mode": 0,
                  "numinlets": 1,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "parameter_enable": 1,
                  "varname": "usb_connect",
                  "fontsize": 9,
                  "saved_attribute_attributes": {
                    "valueof": {
                      "parameter_longname": "Open",
                      "parameter_shortname": "Open",
                      "parameter_type": 2,
                      "parameter_enum": [
                        "Off",
                        "On"
                      ],
                      "parameter_mmax": 1,
                      "parameter_initial": [
                        0
                      ],
                      "parameter_initial_enable": 1,
                      "parameter_invisible": 2
                    }
                  }
                }
              },
              {
                "box": {
                  "id": "usb_close",
                  "maxclass": "live.text",
                  "patching_rect": [
                    210,
                    182,
                    50,
                    18
                  ],
                  "text": "Close",
                  "presentation": 1,
                  "presentation_rect": [
                    457,
                    8,
                    50,
                    18
                  ],
                  "texton": "Close",
                  "mode": 0,
                  "numinlets": 1,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "parameter_enable": 1,
                  "varname": "usb_close",
                  "fontsize": 9,
                  "saved_attribute_attributes": {
                    "valueof": {
                      "parameter_longname": "Close",
                      "parameter_shortname": "Close",
                      "parameter_type": 2,
                      "parameter_enum": [
                        "Off",
                        "On"
                      ],
                      "parameter_mmax": 1,
                      "parameter_initial": [
                        0
                      ],
                      "parameter_initial_enable": 1,
                      "parameter_invisible": 2
                    }
                  }
                }
              },
              {
                "box": {
                  "id": "swap_hands",
                  "maxclass": "live.text",
                  "patching_rect": [
                    400,
                    182,
                    57,
                    18
                  ],
                  "text": "Swap L/R",
                  "presentation": 1,
                  "presentation_rect": [
                    515,
                    8,
                    57,
                    18
                  ],
                  "texton": "Swap L/R",
                  "mode": 1,
                  "numinlets": 1,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "parameter_enable": 1,
                  "varname": "swap_hands",
                  "fontsize": 9,
                  "saved_attribute_attributes": {
                    "valueof": {
                      "parameter_longname": "Swap L/R",
                      "parameter_shortname": "Swap L/R",
                      "parameter_type": 2,
                      "parameter_enum": [
                        "Off",
                        "On"
                      ],
                      "parameter_mmax": 1,
                      "parameter_initial": [
                        0
                      ],
                      "parameter_initial_enable": 1,
                      "parameter_invisible": 1
                    }
                  }
                }
              },
              {
                "box": {
                  "id": "usb_hint",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    20,
                    214,
                    180,
                    16
                  ],
                  "text": "115200 · 8N1 · Close Arduino Serial Monitor before Open",
                  "presentation": 1,
                  "presentation_rect": [
                    8,
                    33,
                    564,
                    16
                  ],
                  "fontsize": 9,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "usb_status",
                  "maxclass": "live.comment",
                  "patching_rect": [
                    210,
                    214,
                    180,
                    18
                  ],
                  "text": "OSC · USB closed",
                  "presentation": 1,
                  "presentation_rect": [
                    8,
                    55,
                    564,
                    18
                  ],
                  "fontsize": 10,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "textjustification": 0
                }
              },
              {
                "box": {
                  "id": "usb_in_0",
                  "maxclass": "inlet",
                  "patching_rect": [
                    20,
                    110,
                    25,
                    25
                  ],
                  "numinlets": 0,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "usb_in_1",
                  "maxclass": "inlet",
                  "patching_rect": [
                    80,
                    110,
                    25,
                    25
                  ],
                  "numinlets": 0,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "usb_out_0",
                  "maxclass": "outlet",
                  "patching_rect": [
                    20,
                    280,
                    25,
                    25
                  ],
                  "numinlets": 1,
                  "numoutlets": 0
                }
              },
              {
                "box": {
                  "id": "usb_out_1",
                  "maxclass": "outlet",
                  "patching_rect": [
                    80,
                    280,
                    25,
                    25
                  ],
                  "numinlets": 1,
                  "numoutlets": 0
                }
              },
              {
                "box": {
                  "id": "usb_out_2",
                  "maxclass": "outlet",
                  "patching_rect": [
                    140,
                    280,
                    25,
                    25
                  ],
                  "numinlets": 1,
                  "numoutlets": 0
                }
              },
              {
                "box": {
                  "id": "usb_out_3",
                  "maxclass": "outlet",
                  "patching_rect": [
                    200,
                    280,
                    25,
                    25
                  ],
                  "numinlets": 1,
                  "numoutlets": 0
                }
              },
              {
                "box": {
                  "id": "usb_out_4",
                  "maxclass": "outlet",
                  "patching_rect": [
                    260,
                    280,
                    25,
                    25
                  ],
                  "numinlets": 1,
                  "numoutlets": 0
                }
              }
            ],
            "lines": [
              {
                "patchline": {
                  "source": [
                    "usb_in_0",
                    0
                  ],
                  "destination": [
                    "usb_ports",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "usb_in_1",
                    0
                  ],
                  "destination": [
                    "usb_status",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "usb_ports",
                    0
                  ],
                  "destination": [
                    "usb_out_0",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "usb_refresh",
                    0
                  ],
                  "destination": [
                    "usb_out_1",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "usb_connect",
                    0
                  ],
                  "destination": [
                    "usb_out_2",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "usb_close",
                    0
                  ],
                  "destination": [
                    "usb_out_3",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "swap_hands",
                    0
                  ],
                  "destination": [
                    "usb_out_4",
                    0
                  ]
                }
              }
            ],
            "parameters": {
              "usb_refresh": [
                "Refresh",
                "Refresh",
                0
              ],
              "usb_connect": [
                "Open",
                "Open",
                0
              ],
              "usb_close": [
                "Close",
                "Close",
                0
              ],
              "swap_hands": [
                "Swap L/R",
                "Swap L/R",
                0
              ]
            }
          },
          "numinlets": 2,
          "numoutlets": 5,
          "outlettype": [
            "int",
            "",
            "",
            "",
            "int"
          ],
          "varname": "usb_settings"
        }
      },
      {
        "box": {
          "id": "usb_controller",
          "maxclass": "newobj",
          "patching_rect": [
            765,
            1290,
            145,
            22
          ],
          "text": "js glove_usb_serial.js",
          "varname": "usb_controller",
          "numinlets": 1,
          "numoutlets": 7,
          "outlettype": [
            "",
            "",
            "",
            "",
            "",
            "",
            ""
          ]
        }
      },
      {
        "box": {
          "id": "swap_command",
          "maxclass": "newobj",
          "patching_rect": [
            1010,
            1290,
            145,
            22
          ],
          "text": "prepend swaphands"
        }
      },
      {
        "box": {
          "id": "swap_title",
          "maxclass": "newobj",
          "patching_rect": [
            30,
            1345,
            145,
            22
          ],
          "text": "prepend routeswap"
        }
      },
      {
        "box": {
          "id": "serial",
          "maxclass": "newobj",
          "patching_rect": [
            275,
            1345,
            145,
            22
          ],
          "text": "serial @baud 115200 @autoopen 0 @poll 0 @asyncread 1 @bufsize 2048 @chunk 0 @defer 0 @xonxoff 0",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "int",
            ""
          ]
        }
      },
      {
        "box": {
          "id": "serial_group",
          "maxclass": "newobj",
          "patching_rect": [
            520,
            1345,
            145,
            22
          ],
          "text": "zl group 1 @zlmaxsize 2048",
          "numinlets": 2,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ]
        }
      },
      {
        "box": {
          "id": "serial_route",
          "maxclass": "newobj",
          "patching_rect": [
            765,
            1345,
            145,
            22
          ],
          "text": "route read",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ]
        }
      },
      {
        "box": {
          "id": "serial_read_setup",
          "maxclass": "newobj",
          "patching_rect": [
            1010,
            1345,
            145,
            22
          ],
          "text": "t i b",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "int",
            "bang"
          ]
        }
      },
      {
        "box": {
          "id": "serial_group_clear",
          "maxclass": "message",
          "patching_rect": [
            30,
            1400,
            145,
            22
          ],
          "text": "zlclear",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ]
        }
      },
      {
        "box": {
          "id": "serial_group_size",
          "maxclass": "newobj",
          "patching_rect": [
            275,
            1400,
            145,
            22
          ],
          "text": "max 1",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "int"
          ]
        }
      },
      {
        "box": {
          "id": "serial_batch_defer",
          "maxclass": "newobj",
          "patching_rect": [
            520,
            1400,
            145,
            22
          ],
          "text": "deferlow",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ]
        }
      },
      {
        "box": {
          "id": "serial_info_defer",
          "maxclass": "newobj",
          "patching_rect": [
            765,
            1400,
            145,
            22
          ],
          "text": "deferlow",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ]
        }
      },
      {
        "box": {
          "id": "serial_info",
          "maxclass": "newobj",
          "patching_rect": [
            1010,
            1400,
            145,
            22
          ],
          "text": "prepend serialinfo",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ]
        }
      },
      {
        "box": {
          "id": "input_mode_command",
          "maxclass": "newobj",
          "patching_rect": [
            30,
            1455,
            145,
            22
          ],
          "text": "prepend mode"
        }
      },
      {
        "box": {
          "id": "usb_chooseport_command",
          "maxclass": "newobj",
          "patching_rect": [
            275,
            1455,
            145,
            22
          ],
          "text": "prepend chooseport"
        }
      },
      {
        "box": {
          "id": "usb_refresh_command",
          "maxclass": "newobj",
          "patching_rect": [
            520,
            1455,
            145,
            22
          ],
          "text": "prepend refresh"
        }
      },
      {
        "box": {
          "id": "usb_connect_command",
          "maxclass": "newobj",
          "patching_rect": [
            765,
            1455,
            145,
            22
          ],
          "text": "prepend connect"
        }
      },
      {
        "box": {
          "id": "usb_disconnect_command",
          "maxclass": "newobj",
          "patching_rect": [
            1010,
            1455,
            145,
            22
          ],
          "text": "prepend disconnect"
        }
      },
      {
        "box": {
          "id": "usb_init",
          "maxclass": "message",
          "patching_rect": [
            30,
            1510,
            145,
            22
          ],
          "text": "init"
        }
      },
      {
        "box": {
          "id": "usb_init_defer",
          "maxclass": "newobj",
          "patching_rect": [
            275,
            1510,
            145,
            22
          ],
          "text": "deferlow"
        }
      },
      {
        "box": {
          "id": "usb_saved_port",
          "maxclass": "newobj",
          "patching_rect": [
            520,
            1510,
            145,
            22
          ],
          "text": "pattr usb_port_name @bindto usb_controller @initial none",
          "varname": "usb_port_name",
          "parameter_enable": 1,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "USB Port Name",
              "parameter_shortname": "USB Port",
              "parameter_type": 3,
              "parameter_invisible": 1,
              "parameter_initial": [
                "none"
              ],
              "parameter_initial_enable": 1
            }
          }
        }
      }
    ],
    "lines": [
      {
        "patchline": {
          "source": [
            "device",
            0
          ],
          "destination": [
            "start",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "start",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "device",
            0
          ],
          "destination": [
            "query_colors",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "colors",
            1
          ],
          "destination": [
            "query_colors",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "query_colors",
            0
          ],
          "destination": [
            "colors",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "colors",
            0
          ],
          "destination": [
            "art",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "engine",
            2
          ],
          "destination": [
            "art",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "engine",
            2
          ],
          "destination": [
            "statusroute",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "statusroute",
            0
          ],
          "destination": [
            "handroute",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "statusroute",
            1
          ],
          "destination": [
            "calroute",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "statusroute",
            2
          ],
          "destination": [
            "caldataroute",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "device",
            0
          ],
          "destination": [
            "calreport",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "calreport",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "left_udp",
            0
          ],
          "destination": [
            "left_input_gate",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "left_input_gate",
            0
          ],
          "destination": [
            "left_route",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "left_route",
            0
          ],
          "destination": [
            "left_raw",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "left_raw",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "left_route",
            1
          ],
          "destination": [
            "left_norm",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "left_norm",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "engine",
            3
          ],
          "destination": [
            "left_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "engine",
            0
          ],
          "destination": [
            "left_control_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "engine",
            5
          ],
          "destination": [
            "left_monitor_unpack",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "handroute",
            0
          ],
          "destination": [
            "left_statusset",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "left_statusset",
            0
          ],
          "destination": [
            "left_status",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "engine",
            5
          ],
          "destination": [
            "left_art",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "left_art",
            0
          ],
          "destination": [
            "art",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "left_monitor_unpack",
            0
          ],
          "destination": [
            "left_pinky_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "left_pinky_set",
            0
          ],
          "destination": [
            "left_pinky",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "left_monitor_unpack",
            1
          ],
          "destination": [
            "left_ring_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "left_ring_set",
            0
          ],
          "destination": [
            "left_ring",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "left_monitor_unpack",
            2
          ],
          "destination": [
            "left_middle_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "left_middle_set",
            0
          ],
          "destination": [
            "left_middle",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "left_monitor_unpack",
            3
          ],
          "destination": [
            "left_index_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "left_index_set",
            0
          ],
          "destination": [
            "left_index",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "left_monitor_unpack",
            4
          ],
          "destination": [
            "left_thumb_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "left_thumb_set",
            0
          ],
          "destination": [
            "left_thumb",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "left_calibrate",
            0
          ],
          "destination": [
            "left_cal_press",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "left_cal_press",
            1
          ],
          "destination": [
            "calreport",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "left_cal_press",
            0
          ],
          "destination": [
            "left_cal_open",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "left_cal_open",
            0
          ],
          "destination": [
            "left_cal_control",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "left_cal_control",
            0
          ],
          "destination": [
            "left_calibration",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "left_calibration",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "calroute",
            0
          ],
          "destination": [
            "left_cal_statusset",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "left_cal_statusset",
            0
          ],
          "destination": [
            "left_calibration",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "caldataroute",
            0
          ],
          "destination": [
            "left_calibration",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "right_udp",
            0
          ],
          "destination": [
            "right_input_gate",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "right_input_gate",
            0
          ],
          "destination": [
            "right_route",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "right_route",
            0
          ],
          "destination": [
            "right_raw",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "right_raw",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "right_route",
            1
          ],
          "destination": [
            "right_norm",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "right_norm",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "engine",
            4
          ],
          "destination": [
            "right_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "engine",
            1
          ],
          "destination": [
            "right_control_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "engine",
            6
          ],
          "destination": [
            "right_monitor_unpack",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "handroute",
            1
          ],
          "destination": [
            "right_statusset",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "right_statusset",
            0
          ],
          "destination": [
            "right_status",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "engine",
            6
          ],
          "destination": [
            "right_art",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "right_art",
            0
          ],
          "destination": [
            "art",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "right_monitor_unpack",
            0
          ],
          "destination": [
            "right_pinky_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "right_pinky_set",
            0
          ],
          "destination": [
            "right_pinky",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "right_monitor_unpack",
            1
          ],
          "destination": [
            "right_ring_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "right_ring_set",
            0
          ],
          "destination": [
            "right_ring",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "right_monitor_unpack",
            2
          ],
          "destination": [
            "right_middle_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "right_middle_set",
            0
          ],
          "destination": [
            "right_middle",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "right_monitor_unpack",
            3
          ],
          "destination": [
            "right_index_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "right_index_set",
            0
          ],
          "destination": [
            "right_index",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "right_monitor_unpack",
            4
          ],
          "destination": [
            "right_thumb_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "right_thumb_set",
            0
          ],
          "destination": [
            "right_thumb",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "right_calibrate",
            0
          ],
          "destination": [
            "right_cal_press",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "right_cal_press",
            1
          ],
          "destination": [
            "calreport",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "right_cal_press",
            0
          ],
          "destination": [
            "right_cal_open",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "right_cal_open",
            0
          ],
          "destination": [
            "right_cal_control",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "right_cal_control",
            0
          ],
          "destination": [
            "right_calibration",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "right_calibration",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "calroute",
            1
          ],
          "destination": [
            "right_cal_statusset",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "right_cal_statusset",
            0
          ],
          "destination": [
            "right_calibration",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "caldataroute",
            1
          ],
          "destination": [
            "right_calibration",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "filter_enabled",
            0
          ],
          "destination": [
            "filter_enabled_prepend",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "filter_enabled_prepend",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "smooth_ms",
            0
          ],
          "destination": [
            "smooth_ms_prepend",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "smooth_ms_prepend",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "deadband",
            0
          ],
          "destination": [
            "deadband_prepend",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "deadband_prepend",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "osc_host",
            0
          ],
          "destination": [
            "host_route",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "host_route",
            0
          ],
          "destination": [
            "host_prepend",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "osc_port",
            0
          ],
          "destination": [
            "port_integer",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "port_integer",
            0
          ],
          "destination": [
            "port_prepend",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "host_prepend",
            0
          ],
          "destination": [
            "udpout",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "port_prepend",
            0
          ],
          "destination": [
            "udpout",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "apply",
            0
          ],
          "destination": [
            "apply_bang",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "apply_bang",
            1
          ],
          "destination": [
            "osc_host",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "apply_bang",
            0
          ],
          "destination": [
            "osc_port",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "device",
            0
          ],
          "destination": [
            "startup_destination",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "startup_destination",
            0
          ],
          "destination": [
            "apply_bang",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "osc_enable",
            0
          ],
          "destination": [
            "osc_switch",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "osc_switch",
            0
          ],
          "destination": [
            "flush",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "flush",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "osc_switch",
            1
          ],
          "destination": [
            "left_osc_gate",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "engine",
            0
          ],
          "destination": [
            "left_osc_gate",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "left_osc_gate",
            0
          ],
          "destination": [
            "left_osc_prefix",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "left_osc_prefix",
            0
          ],
          "destination": [
            "udpout",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "osc_switch",
            1
          ],
          "destination": [
            "right_osc_gate",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "engine",
            1
          ],
          "destination": [
            "right_osc_gate",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "right_osc_gate",
            0
          ],
          "destination": [
            "right_osc_prefix",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "right_osc_prefix",
            0
          ],
          "destination": [
            "udpout",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "host_route",
            0
          ],
          "destination": [
            "host_flush",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "port_prepend",
            0
          ],
          "destination": [
            "host_flush",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "host_flush",
            0
          ],
          "destination": [
            "flush",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "audioin",
            0
          ],
          "destination": [
            "audioout",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "audioin",
            1
          ],
          "destination": [
            "audioout",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "usb_setup",
            0
          ],
          "destination": [
            "usb_setup_press",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "usb_setup_press",
            0
          ],
          "destination": [
            "usb_setup_open",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "usb_setup_open",
            0
          ],
          "destination": [
            "usb_setup_control",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "usb_setup_control",
            0
          ],
          "destination": [
            "usb_settings",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "usb_settings",
            4
          ],
          "destination": [
            "swap_command",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "swap_command",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "statusroute",
            3
          ],
          "destination": [
            "swap_title",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "swap_title",
            0
          ],
          "destination": [
            "usb_controller",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "usb_controller",
            0
          ],
          "destination": [
            "serial",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "serial",
            0
          ],
          "destination": [
            "serial_group",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "serial",
            1
          ],
          "destination": [
            "serial_route",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "serial_route",
            0
          ],
          "destination": [
            "serial_read_setup",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "serial_read_setup",
            1
          ],
          "destination": [
            "serial_group_clear",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "serial_group_clear",
            0
          ],
          "destination": [
            "serial_group",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "serial_read_setup",
            0
          ],
          "destination": [
            "serial_group_size",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "serial_group_size",
            0
          ],
          "destination": [
            "serial_group",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "serial_group",
            0
          ],
          "destination": [
            "serial_batch_defer",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "serial_batch_defer",
            0
          ],
          "destination": [
            "usb_controller",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "serial_route",
            1
          ],
          "destination": [
            "serial_info",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "serial_info",
            0
          ],
          "destination": [
            "serial_info_defer",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "serial_info_defer",
            0
          ],
          "destination": [
            "usb_controller",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "usb_controller",
            1
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "usb_controller",
            2
          ],
          "destination": [
            "left_input_gate",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "usb_controller",
            2
          ],
          "destination": [
            "right_input_gate",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "usb_controller",
            3
          ],
          "destination": [
            "usb_settings",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "usb_controller",
            4
          ],
          "destination": [
            "usb_settings",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "usb_controller",
            5
          ],
          "destination": [
            "left_port",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "usb_controller",
            6
          ],
          "destination": [
            "right_port",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "input_mode",
            0
          ],
          "destination": [
            "input_mode_command",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "input_mode_command",
            0
          ],
          "destination": [
            "usb_controller",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "usb_settings",
            0
          ],
          "destination": [
            "usb_chooseport_command",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "usb_chooseport_command",
            0
          ],
          "destination": [
            "usb_controller",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "usb_settings",
            1
          ],
          "destination": [
            "usb_refresh_command",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "usb_refresh_command",
            0
          ],
          "destination": [
            "usb_controller",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "usb_settings",
            2
          ],
          "destination": [
            "usb_connect_command",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "usb_connect_command",
            0
          ],
          "destination": [
            "usb_controller",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "usb_settings",
            3
          ],
          "destination": [
            "usb_disconnect_command",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "usb_disconnect_command",
            0
          ],
          "destination": [
            "usb_controller",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "device",
            0
          ],
          "destination": [
            "usb_init_defer",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "usb_init_defer",
            0
          ],
          "destination": [
            "usb_init",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "usb_init",
            0
          ],
          "destination": [
            "usb_controller",
            0
          ]
        }
      }
    ],
    "parameters": {
      "left_pinky": [
        "Left Pinky",
        "Left Pinky",
        0
      ],
      "left_ring": [
        "Left Ring",
        "Left Ring",
        0
      ],
      "left_middle": [
        "Left Middle",
        "Left Middle",
        0
      ],
      "left_index": [
        "Left Index",
        "Left Index",
        0
      ],
      "left_thumb": [
        "Left Thumb",
        "Left Thumb",
        0
      ],
      "left_calibrate": [
        "Left Calibrate",
        "Left Calibrate",
        0
      ],
      "left_calibration::cal_open": [
        "Left Calibration open",
        "Left Calibration open",
        0
      ],
      "left_calibration::cal_fist": [
        "Left Calibration fist",
        "Left Calibration fist",
        0
      ],
      "left_calibration::cal_clear": [
        "Left Calibration clear",
        "Left Calibration clear",
        0
      ],
      "right_pinky": [
        "Right Pinky",
        "Right Pinky",
        0
      ],
      "right_ring": [
        "Right Ring",
        "Right Ring",
        0
      ],
      "right_middle": [
        "Right Middle",
        "Right Middle",
        0
      ],
      "right_index": [
        "Right Index",
        "Right Index",
        0
      ],
      "right_thumb": [
        "Right Thumb",
        "Right Thumb",
        0
      ],
      "right_calibrate": [
        "Right Calibrate",
        "Right Calibrate",
        0
      ],
      "right_calibration::cal_open": [
        "Right Calibration open",
        "Right Calibration open",
        0
      ],
      "right_calibration::cal_fist": [
        "Right Calibration fist",
        "Right Calibration fist",
        0
      ],
      "right_calibration::cal_clear": [
        "Right Calibration clear",
        "Right Calibration clear",
        0
      ],
      "calibration_state": [
        "Hand Calibration",
        "Calibration",
        0
      ],
      "filter_enabled": [
        "Stabilize",
        "Stabilize",
        0
      ],
      "smooth_ms": [
        "Smooth ms",
        "Smooth ms",
        0
      ],
      "deadband": [
        "Deadband",
        "Deadband",
        0
      ],
      "osc_enable": [
        "OSC Out",
        "OSC Out",
        0
      ],
      "host_state": [
        "OSC Destination",
        "Destination",
        0
      ],
      "osc_port": [
        "OSC Port",
        "OSC Port",
        0
      ],
      "apply": [
        "Apply",
        "Apply",
        0
      ],
      "input_mode": [
        "Input Mode",
        "Input",
        0
      ],
      "usb_setup": [
        "USB…",
        "USB…",
        0
      ],
      "usb_settings::usb_refresh": [
        "Refresh",
        "Refresh",
        0
      ],
      "usb_settings::usb_connect": [
        "Open",
        "Open",
        0
      ],
      "usb_settings::usb_close": [
        "Close",
        "Close",
        0
      ],
      "usb_settings::swap_hands": [
        "Swap L/R",
        "Swap L/R",
        0
      ],
      "usb_saved_port": [
        "USB Port Name",
        "USB Port",
        0
      ],
      "parameterbanks": {
        "0": {
          "index": 0,
          "name": "Receiver",
          "parameters": [
            "smooth_ms",
            "deadband",
            "filter_enabled",
            "osc_enable",
            "osc_port",
            "-",
            "-",
            "-"
          ]
        }
      },
      "inherited_shortname": 1
    },
    "dependency_cache": [
      {
        "name": "glove_dual_engine.js",
        "bootpath": ".",
        "patcherrelativepath": ".",
        "type": "TEXT",
        "implicit": 1
      },
      {
        "name": "glove_hands.js",
        "bootpath": ".",
        "patcherrelativepath": ".",
        "type": "TEXT",
        "implicit": 1
      },
      {
        "name": "glove_usb_serial.js",
        "bootpath": ".",
        "patcherrelativepath": ".",
        "type": "TEXT",
        "implicit": 1
      }
    ],
    "autosave": 0
  }
}