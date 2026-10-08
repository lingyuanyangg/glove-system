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
      1250,
      820
    ],
    "openinpresentation": 1,
    "default_fontsize": 10,
    "default_fontname": "Arial",
    "devicewidth": 664,
    "enablehscroll": 0,
    "enablevscroll": 0,
    "boxes": [
      {
        "box": {
          "id": "engine",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            220,
            145,
            22
          ],
          "text": "js glove_midi_trigger.js",
          "varname": "engine",
          "numinlets": 2,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ]
        }
      },
      {
        "box": {
          "id": "device",
          "maxclass": "newobj",
          "patching_rect": [
            175,
            220,
            145,
            22
          ],
          "text": "live.thisdevice",
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "bang",
            "int",
            "int"
          ]
        }
      },
      {
        "box": {
          "id": "init",
          "maxclass": "newobj",
          "patching_rect": [
            330,
            220,
            145,
            22
          ],
          "text": "t b b b"
        }
      },
      {
        "box": {
          "id": "start",
          "maxclass": "message",
          "patching_rect": [
            485,
            220,
            145,
            22
          ],
          "text": "start"
        }
      },
      {
        "box": {
          "id": "finishinit",
          "maxclass": "message",
          "patching_rect": [
            640,
            220,
            145,
            22
          ],
          "text": "finishinit"
        }
      },
      {
        "box": {
          "id": "device_state",
          "maxclass": "newobj",
          "patching_rect": [
            795,
            220,
            145,
            22
          ],
          "text": "prepend device"
        }
      },
      {
        "box": {
          "id": "free",
          "maxclass": "newobj",
          "patching_rect": [
            950,
            220,
            145,
            22
          ],
          "text": "freebang"
        }
      },
      {
        "box": {
          "id": "stop",
          "maxclass": "message",
          "patching_rect": [
            1105,
            220,
            145,
            22
          ],
          "text": "stop"
        }
      },
      {
        "box": {
          "id": "midiin",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            258,
            145,
            22
          ],
          "text": "midiin",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "int"
          ]
        }
      },
      {
        "box": {
          "id": "midiout",
          "maxclass": "newobj",
          "patching_rect": [
            175,
            258,
            145,
            22
          ],
          "text": "midiout",
          "numinlets": 1,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "title",
          "maxclass": "live.comment",
          "patching_rect": [
            330,
            258,
            145,
            22
          ],
          "text": "GLOVE / MIDI TRIGGER",
          "presentation": 1,
          "presentation_rect": [
            8,
            3,
            154,
            17
          ],
          "fontsize": 11,
          "numinlets": 1,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "root_label",
          "maxclass": "live.comment",
          "patching_rect": [
            485,
            258,
            145,
            22
          ],
          "text": "Root",
          "presentation": 1,
          "presentation_rect": [
            170,
            3,
            32,
            16
          ],
          "fontsize": 9,
          "numinlets": 1,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "root",
          "maxclass": "live.menu",
          "patching_rect": [
            640,
            258,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            206,
            3,
            42,
            17
          ],
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "root",
          "fontsize": 9,
          "annotation": "",
          "items": [
            "C",
            "C#",
            "D",
            "D#",
            "E",
            "F",
            "F#",
            "G",
            "G#",
            "A",
            "A#",
            "B"
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Global Root",
              "parameter_shortname": "Global Root",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 11,
              "parameter_initial": [
                0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "C",
                "C#",
                "D",
                "D#",
                "E",
                "F",
                "F#",
                "G",
                "G#",
                "A",
                "A#",
                "B"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "root_send",
          "maxclass": "newobj",
          "patching_rect": [
            795,
            258,
            145,
            22
          ],
          "text": "prepend setting root"
        }
      },
      {
        "box": {
          "id": "scale_label",
          "maxclass": "live.comment",
          "patching_rect": [
            950,
            258,
            145,
            22
          ],
          "text": "Scale",
          "presentation": 1,
          "presentation_rect": [
            258,
            3,
            35,
            16
          ],
          "fontsize": 9,
          "numinlets": 1,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "scale",
          "maxclass": "live.menu",
          "patching_rect": [
            1105,
            258,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            297,
            3,
            102,
            17
          ],
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "scale",
          "fontsize": 9,
          "annotation": "",
          "items": [
            "Chromatic",
            "Major",
            "Minor",
            "Dorian",
            "Phrygian",
            "Lydian",
            "Mixolydian",
            "Locrian",
            "Maj pent",
            "Min pent",
            "Blues",
            "Whole tone"
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Global Scale",
              "parameter_shortname": "Global Scale",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 11,
              "parameter_initial": [
                1
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "Chromatic",
                "Major",
                "Minor",
                "Dorian",
                "Phrygian",
                "Lydian",
                "Mixolydian",
                "Locrian",
                "Maj pent",
                "Min pent",
                "Blues",
                "Whole tone"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "scale_send",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            296,
            145,
            22
          ],
          "text": "prepend setting scale"
        }
      },
      {
        "box": {
          "id": "calibrate",
          "maxclass": "live.text",
          "patching_rect": [
            175,
            296,
            145,
            22
          ],
          "text": "Calibrate 8 s",
          "presentation": 1,
          "presentation_rect": [
            520,
            3,
            80,
            17
          ],
          "texton": "Calibrate 8 s",
          "mode": 0,
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 0,
          "varname": "calibrate",
          "fontsize": 9
        }
      },
      {
        "box": {
          "id": "calibrate_bang",
          "maxclass": "newobj",
          "patching_rect": [
            330,
            296,
            145,
            22
          ],
          "text": "t b"
        }
      },
      {
        "box": {
          "id": "calibrate_command",
          "maxclass": "message",
          "patching_rect": [
            485,
            296,
            145,
            22
          ],
          "text": "calibrate"
        }
      },
      {
        "box": {
          "id": "panic",
          "maxclass": "live.text",
          "patching_rect": [
            640,
            296,
            145,
            22
          ],
          "text": "Panic",
          "presentation": 1,
          "presentation_rect": [
            610,
            3,
            46,
            17
          ],
          "texton": "Panic",
          "mode": 0,
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 0,
          "varname": "panic",
          "fontsize": 9
        }
      },
      {
        "box": {
          "id": "panic_bang",
          "maxclass": "newobj",
          "patching_rect": [
            795,
            296,
            145,
            22
          ],
          "text": "t b"
        }
      },
      {
        "box": {
          "id": "panic_command",
          "maxclass": "message",
          "patching_rect": [
            950,
            296,
            145,
            22
          ],
          "text": "panic"
        }
      },
      {
        "box": {
          "id": "octave_hint",
          "maxclass": "live.comment",
          "patching_rect": [
            1105,
            296,
            145,
            22
          ],
          "text": "C3 = MIDI 60",
          "presentation": 1,
          "presentation_rect": [
            410,
            3,
            102,
            17
          ],
          "fontsize": 9,
          "numinlets": 1,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "markov_label",
          "maxclass": "live.comment",
          "patching_rect": [
            20,
            334,
            145,
            22
          ],
          "text": "Markov",
          "presentation": 1,
          "presentation_rect": [
            153,
            43,
            45,
            13
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "markov",
          "maxclass": "live.menu",
          "patching_rect": [
            175,
            334,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            202,
            42,
            120,
            16
          ],
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "markov",
          "fontsize": 9,
          "annotation": "",
          "items": [
            "Stepwise",
            "Upward",
            "Downward",
            "Leaps",
            "Tonic Pull",
            "Balanced"
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Global Markov preset",
              "parameter_shortname": "Global Markov preset",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 5,
              "parameter_initial": [
                0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "Stepwise",
                "Upward",
                "Downward",
                "Leaps",
                "Tonic Pull",
                "Balanced"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "markov_send",
          "maxclass": "newobj",
          "patching_rect": [
            330,
            334,
            145,
            22
          ],
          "text": "prepend setting markov"
        }
      },
      {
        "box": {
          "id": "sensitivity_label",
          "maxclass": "live.comment",
          "patching_rect": [
            485,
            334,
            145,
            22
          ],
          "text": "Sens %",
          "presentation": 1,
          "presentation_rect": [
            8,
            24,
            39,
            13
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "sensitivity",
          "maxclass": "live.numbox",
          "patching_rect": [
            640,
            334,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            50,
            23,
            47,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "sensitivity",
          "fontsize": 9,
          "annotation": "",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Global Sens %",
              "parameter_shortname": "Global Sens %",
              "parameter_type": 1,
              "parameter_mmin": 10,
              "parameter_mmax": 400,
              "parameter_initial": [
                100
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 0
            }
          }
        }
      },
      {
        "box": {
          "id": "sensitivity_send",
          "maxclass": "newobj",
          "patching_rect": [
            795,
            334,
            145,
            22
          ],
          "text": "prepend setting sensitivity"
        }
      },
      {
        "box": {
          "id": "threshold_label",
          "maxclass": "live.comment",
          "patching_rect": [
            950,
            334,
            145,
            22
          ],
          "text": "Threshold",
          "presentation": 1,
          "presentation_rect": [
            106,
            24,
            50,
            13
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "threshold",
          "maxclass": "live.numbox",
          "patching_rect": [
            1105,
            334,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            159,
            23,
            43,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "threshold",
          "fontsize": 9,
          "annotation": "",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Global Threshold",
              "parameter_shortname": "Global Threshold",
              "parameter_type": 0,
              "parameter_mmin": 0.05,
              "parameter_mmax": 0.95,
              "parameter_initial": [
                0.25
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 9,
              "parameter_units": "%0.2f"
            }
          }
        }
      },
      {
        "box": {
          "id": "threshold_send",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            372,
            145,
            22
          ],
          "text": "prepend setting threshold"
        }
      },
      {
        "box": {
          "id": "length_label",
          "maxclass": "live.comment",
          "patching_rect": [
            175,
            372,
            145,
            22
          ],
          "text": "Length ms",
          "presentation": 1,
          "presentation_rect": [
            210,
            24,
            44,
            13
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "length",
          "maxclass": "live.numbox",
          "patching_rect": [
            330,
            372,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            257,
            23,
            44,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "length",
          "fontsize": 9,
          "annotation": "",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Global Length ms",
              "parameter_shortname": "Global Length ms",
              "parameter_type": 1,
              "parameter_mmin": 10,
              "parameter_mmax": 2000,
              "parameter_initial": [
                120
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 0
            }
          }
        }
      },
      {
        "box": {
          "id": "length_send",
          "maxclass": "newobj",
          "patching_rect": [
            485,
            372,
            145,
            22
          ],
          "text": "prepend setting length"
        }
      },
      {
        "box": {
          "id": "gap_label",
          "maxclass": "live.comment",
          "patching_rect": [
            640,
            372,
            145,
            22
          ],
          "text": "Retrig ms",
          "presentation": 1,
          "presentation_rect": [
            308,
            24,
            46,
            13
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "gap",
          "maxclass": "live.numbox",
          "patching_rect": [
            795,
            372,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            357,
            23,
            44,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "gap",
          "fontsize": 9,
          "annotation": "",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Global Retrig ms",
              "parameter_shortname": "Global Retrig ms",
              "parameter_type": 1,
              "parameter_mmin": 20,
              "parameter_mmax": 2000,
              "parameter_initial": [
                40
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 0
            }
          }
        }
      },
      {
        "box": {
          "id": "gap_send",
          "maxclass": "newobj",
          "patching_rect": [
            950,
            372,
            145,
            22
          ],
          "text": "prepend setting gap"
        }
      },
      {
        "box": {
          "id": "vmin_label",
          "maxclass": "live.comment",
          "patching_rect": [
            1105,
            372,
            145,
            22
          ],
          "text": "V Min",
          "presentation": 1,
          "presentation_rect": [
            410,
            24,
            41,
            13
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "vmin",
          "maxclass": "live.numbox",
          "patching_rect": [
            20,
            410,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            454,
            23,
            44,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "vmin",
          "fontsize": 9,
          "annotation": "",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Global V Min",
              "parameter_shortname": "Global V Min",
              "parameter_type": 1,
              "parameter_mmin": 1,
              "parameter_mmax": 127,
              "parameter_initial": [
                20
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 0
            }
          }
        }
      },
      {
        "box": {
          "id": "vmin_send",
          "maxclass": "newobj",
          "patching_rect": [
            175,
            410,
            145,
            22
          ],
          "text": "prepend setting vmin"
        }
      },
      {
        "box": {
          "id": "vmax_label",
          "maxclass": "live.comment",
          "patching_rect": [
            330,
            410,
            145,
            22
          ],
          "text": "V Max",
          "presentation": 1,
          "presentation_rect": [
            507,
            24,
            42,
            13
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "vmax",
          "maxclass": "live.numbox",
          "patching_rect": [
            485,
            410,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            552,
            23,
            44,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "vmax",
          "fontsize": 9,
          "annotation": "",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Global V Max",
              "parameter_shortname": "Global V Max",
              "parameter_type": 1,
              "parameter_mmin": 1,
              "parameter_mmax": 127,
              "parameter_initial": [
                127
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 0
            }
          }
        }
      },
      {
        "box": {
          "id": "vmax_send",
          "maxclass": "newobj",
          "patching_rect": [
            640,
            410,
            145,
            22
          ],
          "text": "prepend setting vmax"
        }
      },
      {
        "box": {
          "id": "channel_label",
          "maxclass": "live.comment",
          "patching_rect": [
            795,
            410,
            145,
            22
          ],
          "text": "Ch",
          "presentation": 1,
          "presentation_rect": [
            602,
            24,
            21,
            13
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "channel",
          "maxclass": "live.numbox",
          "patching_rect": [
            950,
            410,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            626,
            23,
            30,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "channel",
          "fontsize": 9,
          "annotation": "",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Global Ch",
              "parameter_shortname": "Global Ch",
              "parameter_type": 1,
              "parameter_mmin": 1,
              "parameter_mmax": 16,
              "parameter_initial": [
                1
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 0
            }
          }
        }
      },
      {
        "box": {
          "id": "channel_send",
          "maxclass": "newobj",
          "patching_rect": [
            1105,
            410,
            145,
            22
          ],
          "text": "prepend setting channel"
        }
      },
      {
        "box": {
          "id": "reference_label",
          "maxclass": "live.comment",
          "patching_rect": [
            20,
            448,
            145,
            22
          ],
          "text": "Cal ref / s²",
          "presentation": 1,
          "presentation_rect": [
            8,
            43,
            66,
            13
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "reference",
          "maxclass": "live.numbox",
          "patching_rect": [
            175,
            448,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            77,
            42,
            62,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "reference",
          "fontsize": 9,
          "annotation": "",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Global Cal ref / s²",
              "parameter_shortname": "Global Cal ref / s²",
              "parameter_type": 0,
              "parameter_mmin": 0.1,
              "parameter_mmax": 10000,
              "parameter_initial": [
                50
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 9,
              "parameter_units": "%0.2f"
            }
          }
        }
      },
      {
        "box": {
          "id": "reference_send",
          "maxclass": "newobj",
          "patching_rect": [
            330,
            448,
            145,
            22
          ],
          "text": "prepend setting reference"
        }
      },
      {
        "box": {
          "id": "notice",
          "maxclass": "live.comment",
          "patching_rect": [
            485,
            448,
            145,
            22
          ],
          "text": "Accel: flex to strike · lift to re-arm.",
          "presentation": 1,
          "presentation_rect": [
            334,
            42,
            322,
            14
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "ui_route",
          "maxclass": "newobj",
          "patching_rect": [
            640,
            448,
            145,
            22
          ],
          "text": "route status finger notice"
        }
      },
      {
        "box": {
          "id": "hand_route",
          "maxclass": "newobj",
          "patching_rect": [
            795,
            448,
            145,
            22
          ],
          "text": "route 0 1"
        }
      },
      {
        "box": {
          "id": "finger_route",
          "maxclass": "newobj",
          "patching_rect": [
            950,
            448,
            145,
            22
          ],
          "text": "route 0 1 2 3 4 5 6 7 8 9"
        }
      },
      {
        "box": {
          "id": "notice_set",
          "maxclass": "newobj",
          "patching_rect": [
            1105,
            448,
            145,
            22
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "reference_route",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            486,
            145,
            22
          ],
          "text": "route reference"
        }
      },
      {
        "box": {
          "id": "reference_set",
          "maxclass": "newobj",
          "patching_rect": [
            175,
            486,
            145,
            22
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "Left_title",
          "maxclass": "live.comment",
          "patching_rect": [
            330,
            486,
            145,
            22
          ],
          "text": "LEFT",
          "presentation": 1,
          "presentation_rect": [
            8,
            57,
            47,
            14
          ],
          "fontsize": 10,
          "numinlets": 1,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "Left_status",
          "maxclass": "live.comment",
          "patching_rect": [
            485,
            486,
            145,
            22
          ],
          "text": "WAIT",
          "presentation": 1,
          "presentation_rect": [
            63,
            57,
            48,
            14
          ],
          "fontsize": 9,
          "numinlets": 1,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "Left_bus",
          "maxclass": "live.comment",
          "patching_rect": [
            640,
            486,
            145,
            22
          ],
          "text": "GLeft · fresh frames",
          "presentation": 1,
          "presentation_rect": [
            128,
            58,
            190,
            13
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "Left_set",
          "maxclass": "newobj",
          "patching_rect": [
            795,
            486,
            145,
            22
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "Left_receive",
          "maxclass": "newobj",
          "patching_rect": [
            950,
            486,
            145,
            22
          ],
          "text": "r GLeft"
        }
      },
      {
        "box": {
          "id": "Left_input",
          "maxclass": "newobj",
          "patching_rect": [
            1105,
            486,
            145,
            22
          ],
          "text": "prepend left"
        }
      },
      {
        "box": {
          "id": "Left_header_finger",
          "maxclass": "live.comment",
          "patching_rect": [
            20,
            524,
            145,
            22
          ],
          "text": "FINGER",
          "presentation": 1,
          "presentation_rect": [
            8,
            73,
            47,
            12
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0,
          "varname": "Left_header_finger"
        }
      },
      {
        "box": {
          "id": "Left_header_on",
          "maxclass": "live.comment",
          "patching_rect": [
            175,
            524,
            145,
            22
          ],
          "text": "ON",
          "presentation": 1,
          "presentation_rect": [
            57,
            73,
            18,
            12
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0,
          "varname": "Left_header_on"
        }
      },
      {
        "box": {
          "id": "Left_header_mode",
          "maxclass": "live.comment",
          "patching_rect": [
            330,
            524,
            145,
            22
          ],
          "text": "TRIGGER",
          "presentation": 1,
          "presentation_rect": [
            77,
            73,
            45,
            12
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0,
          "varname": "Left_header_mode"
        }
      },
      {
        "box": {
          "id": "Left_header_pitchmode",
          "maxclass": "live.comment",
          "patching_rect": [
            485,
            524,
            145,
            22
          ],
          "text": "PITCH",
          "presentation": 1,
          "presentation_rect": [
            124,
            73,
            47,
            12
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0,
          "varname": "Left_header_pitchmode"
        }
      },
      {
        "box": {
          "id": "Left_header_note",
          "maxclass": "live.comment",
          "patching_rect": [
            640,
            524,
            145,
            22
          ],
          "text": "NOTE",
          "presentation": 1,
          "presentation_rect": [
            173,
            73,
            48,
            12
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0,
          "varname": "Left_header_note"
        }
      },
      {
        "box": {
          "id": "Left_header_low",
          "maxclass": "live.comment",
          "patching_rect": [
            795,
            524,
            145,
            22
          ],
          "text": "LOW",
          "presentation": 1,
          "presentation_rect": [
            223,
            73,
            48,
            12
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0,
          "varname": "Left_header_low"
        }
      },
      {
        "box": {
          "id": "Left_header_high",
          "maxclass": "live.comment",
          "patching_rect": [
            950,
            524,
            145,
            22
          ],
          "text": "HIGH",
          "presentation": 1,
          "presentation_rect": [
            273,
            73,
            48,
            12
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0,
          "varname": "Left_header_high"
        }
      },
      {
        "box": {
          "id": "Left_Pinky",
          "maxclass": "live.comment",
          "patching_rect": [
            1105,
            524,
            145,
            22
          ],
          "text": "Pinky",
          "presentation": 1,
          "presentation_rect": [
            8,
            87,
            47,
            14
          ],
          "fontsize": 9,
          "numinlets": 1,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "Left_Pinky_set",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            562,
            145,
            22
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "Left_Pinky_on",
          "maxclass": "live.toggle",
          "patching_rect": [
            175,
            562,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            57,
            87,
            18,
            14
          ],
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "parameter_enable": 1,
          "varname": "Left_Pinky_on",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Pinky on",
              "parameter_shortname": "Left Pinky on",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 1,
              "parameter_initial": [
                1
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "Off",
                "On"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "Left_Pinky_on_send",
          "maxclass": "newobj",
          "patching_rect": [
            330,
            562,
            145,
            22
          ],
          "text": "prepend config 0 on"
        }
      },
      {
        "box": {
          "id": "Left_Pinky_mode",
          "maxclass": "live.menu",
          "patching_rect": [
            485,
            562,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            77,
            87,
            45,
            14
          ],
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Left_Pinky_mode",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "items": [
            "Accel",
            "Toggle"
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Pinky mode",
              "parameter_shortname": "Left Pinky mode",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 1,
              "parameter_initial": [
                0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "Accel",
                "Toggle"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "Left_Pinky_mode_send",
          "maxclass": "newobj",
          "patching_rect": [
            640,
            562,
            145,
            22
          ],
          "text": "prepend config 0 mode"
        }
      },
      {
        "box": {
          "id": "Left_Pinky_pitchmode",
          "maxclass": "live.menu",
          "patching_rect": [
            795,
            562,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            124,
            87,
            47,
            14
          ],
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Left_Pinky_pitchmode",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "items": [
            "Fixed",
            "Random",
            "Markov"
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Pinky pitchmode",
              "parameter_shortname": "Left Pinky pitchmode",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 2,
              "parameter_initial": [
                0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "Fixed",
                "Random",
                "Markov"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "Left_Pinky_pitchmode_send",
          "maxclass": "newobj",
          "patching_rect": [
            950,
            562,
            145,
            22
          ],
          "text": "prepend config 0 pitchmode"
        }
      },
      {
        "box": {
          "id": "Left_Pinky_note",
          "maxclass": "live.numbox",
          "patching_rect": [
            1105,
            562,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            173,
            87,
            48,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Left_Pinky_note",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Pinky note",
              "parameter_shortname": "Left Pinky note",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 127,
              "parameter_initial": [
                60
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 8
            }
          }
        }
      },
      {
        "box": {
          "id": "Left_Pinky_note_send",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            600,
            145,
            22
          ],
          "text": "prepend config 0 note"
        }
      },
      {
        "box": {
          "id": "Left_Pinky_low",
          "maxclass": "live.numbox",
          "patching_rect": [
            175,
            600,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            223,
            87,
            48,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Left_Pinky_low",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Pinky low",
              "parameter_shortname": "Left Pinky low",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 127,
              "parameter_initial": [
                48
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 8
            }
          }
        }
      },
      {
        "box": {
          "id": "Left_Pinky_low_send",
          "maxclass": "newobj",
          "patching_rect": [
            330,
            600,
            145,
            22
          ],
          "text": "prepend config 0 low"
        }
      },
      {
        "box": {
          "id": "Left_Pinky_high",
          "maxclass": "live.numbox",
          "patching_rect": [
            485,
            600,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            273,
            87,
            48,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Left_Pinky_high",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Pinky high",
              "parameter_shortname": "Left Pinky high",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 127,
              "parameter_initial": [
                84
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 8
            }
          }
        }
      },
      {
        "box": {
          "id": "Left_Pinky_high_send",
          "maxclass": "newobj",
          "patching_rect": [
            640,
            600,
            145,
            22
          ],
          "text": "prepend config 0 high"
        }
      },
      {
        "box": {
          "id": "Left_Ring",
          "maxclass": "live.comment",
          "patching_rect": [
            795,
            600,
            145,
            22
          ],
          "text": "Ring",
          "presentation": 1,
          "presentation_rect": [
            8,
            103,
            47,
            14
          ],
          "fontsize": 9,
          "numinlets": 1,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "Left_Ring_set",
          "maxclass": "newobj",
          "patching_rect": [
            950,
            600,
            145,
            22
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "Left_Ring_on",
          "maxclass": "live.toggle",
          "patching_rect": [
            1105,
            600,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            57,
            103,
            18,
            14
          ],
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "parameter_enable": 1,
          "varname": "Left_Ring_on",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Ring on",
              "parameter_shortname": "Left Ring on",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 1,
              "parameter_initial": [
                1
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "Off",
                "On"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "Left_Ring_on_send",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            638,
            145,
            22
          ],
          "text": "prepend config 1 on"
        }
      },
      {
        "box": {
          "id": "Left_Ring_mode",
          "maxclass": "live.menu",
          "patching_rect": [
            175,
            638,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            77,
            103,
            45,
            14
          ],
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Left_Ring_mode",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "items": [
            "Accel",
            "Toggle"
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Ring mode",
              "parameter_shortname": "Left Ring mode",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 1,
              "parameter_initial": [
                0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "Accel",
                "Toggle"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "Left_Ring_mode_send",
          "maxclass": "newobj",
          "patching_rect": [
            330,
            638,
            145,
            22
          ],
          "text": "prepend config 1 mode"
        }
      },
      {
        "box": {
          "id": "Left_Ring_pitchmode",
          "maxclass": "live.menu",
          "patching_rect": [
            485,
            638,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            124,
            103,
            47,
            14
          ],
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Left_Ring_pitchmode",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "items": [
            "Fixed",
            "Random",
            "Markov"
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Ring pitchmode",
              "parameter_shortname": "Left Ring pitchmode",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 2,
              "parameter_initial": [
                0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "Fixed",
                "Random",
                "Markov"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "Left_Ring_pitchmode_send",
          "maxclass": "newobj",
          "patching_rect": [
            640,
            638,
            145,
            22
          ],
          "text": "prepend config 1 pitchmode"
        }
      },
      {
        "box": {
          "id": "Left_Ring_note",
          "maxclass": "live.numbox",
          "patching_rect": [
            795,
            638,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            173,
            103,
            48,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Left_Ring_note",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Ring note",
              "parameter_shortname": "Left Ring note",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 127,
              "parameter_initial": [
                61
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 8
            }
          }
        }
      },
      {
        "box": {
          "id": "Left_Ring_note_send",
          "maxclass": "newobj",
          "patching_rect": [
            950,
            638,
            145,
            22
          ],
          "text": "prepend config 1 note"
        }
      },
      {
        "box": {
          "id": "Left_Ring_low",
          "maxclass": "live.numbox",
          "patching_rect": [
            1105,
            638,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            223,
            103,
            48,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Left_Ring_low",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Ring low",
              "parameter_shortname": "Left Ring low",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 127,
              "parameter_initial": [
                48
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 8
            }
          }
        }
      },
      {
        "box": {
          "id": "Left_Ring_low_send",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            676,
            145,
            22
          ],
          "text": "prepend config 1 low"
        }
      },
      {
        "box": {
          "id": "Left_Ring_high",
          "maxclass": "live.numbox",
          "patching_rect": [
            175,
            676,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            273,
            103,
            48,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Left_Ring_high",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Ring high",
              "parameter_shortname": "Left Ring high",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 127,
              "parameter_initial": [
                84
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 8
            }
          }
        }
      },
      {
        "box": {
          "id": "Left_Ring_high_send",
          "maxclass": "newobj",
          "patching_rect": [
            330,
            676,
            145,
            22
          ],
          "text": "prepend config 1 high"
        }
      },
      {
        "box": {
          "id": "Left_Middle",
          "maxclass": "live.comment",
          "patching_rect": [
            485,
            676,
            145,
            22
          ],
          "text": "Middle",
          "presentation": 1,
          "presentation_rect": [
            8,
            119,
            47,
            14
          ],
          "fontsize": 9,
          "numinlets": 1,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "Left_Middle_set",
          "maxclass": "newobj",
          "patching_rect": [
            640,
            676,
            145,
            22
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "Left_Middle_on",
          "maxclass": "live.toggle",
          "patching_rect": [
            795,
            676,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            57,
            119,
            18,
            14
          ],
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "parameter_enable": 1,
          "varname": "Left_Middle_on",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Middle on",
              "parameter_shortname": "Left Middle on",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 1,
              "parameter_initial": [
                1
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "Off",
                "On"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "Left_Middle_on_send",
          "maxclass": "newobj",
          "patching_rect": [
            950,
            676,
            145,
            22
          ],
          "text": "prepend config 2 on"
        }
      },
      {
        "box": {
          "id": "Left_Middle_mode",
          "maxclass": "live.menu",
          "patching_rect": [
            1105,
            676,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            77,
            119,
            45,
            14
          ],
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Left_Middle_mode",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "items": [
            "Accel",
            "Toggle"
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Middle mode",
              "parameter_shortname": "Left Middle mode",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 1,
              "parameter_initial": [
                0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "Accel",
                "Toggle"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "Left_Middle_mode_send",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            714,
            145,
            22
          ],
          "text": "prepend config 2 mode"
        }
      },
      {
        "box": {
          "id": "Left_Middle_pitchmode",
          "maxclass": "live.menu",
          "patching_rect": [
            175,
            714,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            124,
            119,
            47,
            14
          ],
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Left_Middle_pitchmode",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "items": [
            "Fixed",
            "Random",
            "Markov"
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Middle pitchmode",
              "parameter_shortname": "Left Middle pitchmode",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 2,
              "parameter_initial": [
                0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "Fixed",
                "Random",
                "Markov"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "Left_Middle_pitchmode_send",
          "maxclass": "newobj",
          "patching_rect": [
            330,
            714,
            145,
            22
          ],
          "text": "prepend config 2 pitchmode"
        }
      },
      {
        "box": {
          "id": "Left_Middle_note",
          "maxclass": "live.numbox",
          "patching_rect": [
            485,
            714,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            173,
            119,
            48,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Left_Middle_note",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Middle note",
              "parameter_shortname": "Left Middle note",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 127,
              "parameter_initial": [
                62
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 8
            }
          }
        }
      },
      {
        "box": {
          "id": "Left_Middle_note_send",
          "maxclass": "newobj",
          "patching_rect": [
            640,
            714,
            145,
            22
          ],
          "text": "prepend config 2 note"
        }
      },
      {
        "box": {
          "id": "Left_Middle_low",
          "maxclass": "live.numbox",
          "patching_rect": [
            795,
            714,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            223,
            119,
            48,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Left_Middle_low",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Middle low",
              "parameter_shortname": "Left Middle low",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 127,
              "parameter_initial": [
                48
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 8
            }
          }
        }
      },
      {
        "box": {
          "id": "Left_Middle_low_send",
          "maxclass": "newobj",
          "patching_rect": [
            950,
            714,
            145,
            22
          ],
          "text": "prepend config 2 low"
        }
      },
      {
        "box": {
          "id": "Left_Middle_high",
          "maxclass": "live.numbox",
          "patching_rect": [
            1105,
            714,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            273,
            119,
            48,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Left_Middle_high",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Middle high",
              "parameter_shortname": "Left Middle high",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 127,
              "parameter_initial": [
                84
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 8
            }
          }
        }
      },
      {
        "box": {
          "id": "Left_Middle_high_send",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            752,
            145,
            22
          ],
          "text": "prepend config 2 high"
        }
      },
      {
        "box": {
          "id": "Left_Index",
          "maxclass": "live.comment",
          "patching_rect": [
            175,
            752,
            145,
            22
          ],
          "text": "Index",
          "presentation": 1,
          "presentation_rect": [
            8,
            135,
            47,
            14
          ],
          "fontsize": 9,
          "numinlets": 1,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "Left_Index_set",
          "maxclass": "newobj",
          "patching_rect": [
            330,
            752,
            145,
            22
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "Left_Index_on",
          "maxclass": "live.toggle",
          "patching_rect": [
            485,
            752,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            57,
            135,
            18,
            14
          ],
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "parameter_enable": 1,
          "varname": "Left_Index_on",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Index on",
              "parameter_shortname": "Left Index on",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 1,
              "parameter_initial": [
                1
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "Off",
                "On"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "Left_Index_on_send",
          "maxclass": "newobj",
          "patching_rect": [
            640,
            752,
            145,
            22
          ],
          "text": "prepend config 3 on"
        }
      },
      {
        "box": {
          "id": "Left_Index_mode",
          "maxclass": "live.menu",
          "patching_rect": [
            795,
            752,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            77,
            135,
            45,
            14
          ],
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Left_Index_mode",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "items": [
            "Accel",
            "Toggle"
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Index mode",
              "parameter_shortname": "Left Index mode",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 1,
              "parameter_initial": [
                0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "Accel",
                "Toggle"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "Left_Index_mode_send",
          "maxclass": "newobj",
          "patching_rect": [
            950,
            752,
            145,
            22
          ],
          "text": "prepend config 3 mode"
        }
      },
      {
        "box": {
          "id": "Left_Index_pitchmode",
          "maxclass": "live.menu",
          "patching_rect": [
            1105,
            752,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            124,
            135,
            47,
            14
          ],
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Left_Index_pitchmode",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "items": [
            "Fixed",
            "Random",
            "Markov"
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Index pitchmode",
              "parameter_shortname": "Left Index pitchmode",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 2,
              "parameter_initial": [
                0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "Fixed",
                "Random",
                "Markov"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "Left_Index_pitchmode_send",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            790,
            145,
            22
          ],
          "text": "prepend config 3 pitchmode"
        }
      },
      {
        "box": {
          "id": "Left_Index_note",
          "maxclass": "live.numbox",
          "patching_rect": [
            175,
            790,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            173,
            135,
            48,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Left_Index_note",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Index note",
              "parameter_shortname": "Left Index note",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 127,
              "parameter_initial": [
                63
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 8
            }
          }
        }
      },
      {
        "box": {
          "id": "Left_Index_note_send",
          "maxclass": "newobj",
          "patching_rect": [
            330,
            790,
            145,
            22
          ],
          "text": "prepend config 3 note"
        }
      },
      {
        "box": {
          "id": "Left_Index_low",
          "maxclass": "live.numbox",
          "patching_rect": [
            485,
            790,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            223,
            135,
            48,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Left_Index_low",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Index low",
              "parameter_shortname": "Left Index low",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 127,
              "parameter_initial": [
                48
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 8
            }
          }
        }
      },
      {
        "box": {
          "id": "Left_Index_low_send",
          "maxclass": "newobj",
          "patching_rect": [
            640,
            790,
            145,
            22
          ],
          "text": "prepend config 3 low"
        }
      },
      {
        "box": {
          "id": "Left_Index_high",
          "maxclass": "live.numbox",
          "patching_rect": [
            795,
            790,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            273,
            135,
            48,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Left_Index_high",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Index high",
              "parameter_shortname": "Left Index high",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 127,
              "parameter_initial": [
                84
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 8
            }
          }
        }
      },
      {
        "box": {
          "id": "Left_Index_high_send",
          "maxclass": "newobj",
          "patching_rect": [
            950,
            790,
            145,
            22
          ],
          "text": "prepend config 3 high"
        }
      },
      {
        "box": {
          "id": "Left_Thumb",
          "maxclass": "live.comment",
          "patching_rect": [
            1105,
            790,
            145,
            22
          ],
          "text": "Thumb",
          "presentation": 1,
          "presentation_rect": [
            8,
            151,
            47,
            14
          ],
          "fontsize": 9,
          "numinlets": 1,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "Left_Thumb_set",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            828,
            145,
            22
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "Left_Thumb_on",
          "maxclass": "live.toggle",
          "patching_rect": [
            175,
            828,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            57,
            151,
            18,
            14
          ],
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "parameter_enable": 1,
          "varname": "Left_Thumb_on",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Thumb on",
              "parameter_shortname": "Left Thumb on",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 1,
              "parameter_initial": [
                1
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "Off",
                "On"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "Left_Thumb_on_send",
          "maxclass": "newobj",
          "patching_rect": [
            330,
            828,
            145,
            22
          ],
          "text": "prepend config 4 on"
        }
      },
      {
        "box": {
          "id": "Left_Thumb_mode",
          "maxclass": "live.menu",
          "patching_rect": [
            485,
            828,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            77,
            151,
            45,
            14
          ],
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Left_Thumb_mode",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "items": [
            "Accel",
            "Toggle"
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Thumb mode",
              "parameter_shortname": "Left Thumb mode",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 1,
              "parameter_initial": [
                0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "Accel",
                "Toggle"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "Left_Thumb_mode_send",
          "maxclass": "newobj",
          "patching_rect": [
            640,
            828,
            145,
            22
          ],
          "text": "prepend config 4 mode"
        }
      },
      {
        "box": {
          "id": "Left_Thumb_pitchmode",
          "maxclass": "live.menu",
          "patching_rect": [
            795,
            828,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            124,
            151,
            47,
            14
          ],
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Left_Thumb_pitchmode",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "items": [
            "Fixed",
            "Random",
            "Markov"
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Thumb pitchmode",
              "parameter_shortname": "Left Thumb pitchmode",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 2,
              "parameter_initial": [
                0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "Fixed",
                "Random",
                "Markov"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "Left_Thumb_pitchmode_send",
          "maxclass": "newobj",
          "patching_rect": [
            950,
            828,
            145,
            22
          ],
          "text": "prepend config 4 pitchmode"
        }
      },
      {
        "box": {
          "id": "Left_Thumb_note",
          "maxclass": "live.numbox",
          "patching_rect": [
            1105,
            828,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            173,
            151,
            48,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Left_Thumb_note",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Thumb note",
              "parameter_shortname": "Left Thumb note",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 127,
              "parameter_initial": [
                64
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 8
            }
          }
        }
      },
      {
        "box": {
          "id": "Left_Thumb_note_send",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            866,
            145,
            22
          ],
          "text": "prepend config 4 note"
        }
      },
      {
        "box": {
          "id": "Left_Thumb_low",
          "maxclass": "live.numbox",
          "patching_rect": [
            175,
            866,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            223,
            151,
            48,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Left_Thumb_low",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Thumb low",
              "parameter_shortname": "Left Thumb low",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 127,
              "parameter_initial": [
                48
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 8
            }
          }
        }
      },
      {
        "box": {
          "id": "Left_Thumb_low_send",
          "maxclass": "newobj",
          "patching_rect": [
            330,
            866,
            145,
            22
          ],
          "text": "prepend config 4 low"
        }
      },
      {
        "box": {
          "id": "Left_Thumb_high",
          "maxclass": "live.numbox",
          "patching_rect": [
            485,
            866,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            273,
            151,
            48,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Left_Thumb_high",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Left Thumb high",
              "parameter_shortname": "Left Thumb high",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 127,
              "parameter_initial": [
                84
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 8
            }
          }
        }
      },
      {
        "box": {
          "id": "Left_Thumb_high_send",
          "maxclass": "newobj",
          "patching_rect": [
            640,
            866,
            145,
            22
          ],
          "text": "prepend config 4 high"
        }
      },
      {
        "box": {
          "id": "Right_title",
          "maxclass": "live.comment",
          "patching_rect": [
            795,
            866,
            145,
            22
          ],
          "text": "RIGHT",
          "presentation": 1,
          "presentation_rect": [
            340,
            57,
            47,
            14
          ],
          "fontsize": 10,
          "numinlets": 1,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "Right_status",
          "maxclass": "live.comment",
          "patching_rect": [
            950,
            866,
            145,
            22
          ],
          "text": "WAIT",
          "presentation": 1,
          "presentation_rect": [
            395,
            57,
            48,
            14
          ],
          "fontsize": 9,
          "numinlets": 1,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "Right_bus",
          "maxclass": "live.comment",
          "patching_rect": [
            1105,
            866,
            145,
            22
          ],
          "text": "GRight · fresh frames",
          "presentation": 1,
          "presentation_rect": [
            460,
            58,
            190,
            13
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "Right_set",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            904,
            145,
            22
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "Right_receive",
          "maxclass": "newobj",
          "patching_rect": [
            175,
            904,
            145,
            22
          ],
          "text": "r GRight"
        }
      },
      {
        "box": {
          "id": "Right_input",
          "maxclass": "newobj",
          "patching_rect": [
            330,
            904,
            145,
            22
          ],
          "text": "prepend right"
        }
      },
      {
        "box": {
          "id": "Right_header_finger",
          "maxclass": "live.comment",
          "patching_rect": [
            485,
            904,
            145,
            22
          ],
          "text": "FINGER",
          "presentation": 1,
          "presentation_rect": [
            340,
            73,
            47,
            12
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0,
          "varname": "Right_header_finger"
        }
      },
      {
        "box": {
          "id": "Right_header_on",
          "maxclass": "live.comment",
          "patching_rect": [
            640,
            904,
            145,
            22
          ],
          "text": "ON",
          "presentation": 1,
          "presentation_rect": [
            389,
            73,
            18,
            12
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0,
          "varname": "Right_header_on"
        }
      },
      {
        "box": {
          "id": "Right_header_mode",
          "maxclass": "live.comment",
          "patching_rect": [
            795,
            904,
            145,
            22
          ],
          "text": "TRIGGER",
          "presentation": 1,
          "presentation_rect": [
            409,
            73,
            45,
            12
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0,
          "varname": "Right_header_mode"
        }
      },
      {
        "box": {
          "id": "Right_header_pitchmode",
          "maxclass": "live.comment",
          "patching_rect": [
            950,
            904,
            145,
            22
          ],
          "text": "PITCH",
          "presentation": 1,
          "presentation_rect": [
            456,
            73,
            47,
            12
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0,
          "varname": "Right_header_pitchmode"
        }
      },
      {
        "box": {
          "id": "Right_header_note",
          "maxclass": "live.comment",
          "patching_rect": [
            1105,
            904,
            145,
            22
          ],
          "text": "NOTE",
          "presentation": 1,
          "presentation_rect": [
            505,
            73,
            48,
            12
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0,
          "varname": "Right_header_note"
        }
      },
      {
        "box": {
          "id": "Right_header_low",
          "maxclass": "live.comment",
          "patching_rect": [
            20,
            942,
            145,
            22
          ],
          "text": "LOW",
          "presentation": 1,
          "presentation_rect": [
            555,
            73,
            48,
            12
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0,
          "varname": "Right_header_low"
        }
      },
      {
        "box": {
          "id": "Right_header_high",
          "maxclass": "live.comment",
          "patching_rect": [
            175,
            942,
            145,
            22
          ],
          "text": "HIGH",
          "presentation": 1,
          "presentation_rect": [
            605,
            73,
            48,
            12
          ],
          "fontsize": 8,
          "numinlets": 1,
          "numoutlets": 0,
          "varname": "Right_header_high"
        }
      },
      {
        "box": {
          "id": "Right_Pinky",
          "maxclass": "live.comment",
          "patching_rect": [
            330,
            942,
            145,
            22
          ],
          "text": "Pinky",
          "presentation": 1,
          "presentation_rect": [
            340,
            87,
            47,
            14
          ],
          "fontsize": 9,
          "numinlets": 1,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "Right_Pinky_set",
          "maxclass": "newobj",
          "patching_rect": [
            485,
            942,
            145,
            22
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "Right_Pinky_on",
          "maxclass": "live.toggle",
          "patching_rect": [
            640,
            942,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            389,
            87,
            18,
            14
          ],
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "parameter_enable": 1,
          "varname": "Right_Pinky_on",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Pinky on",
              "parameter_shortname": "Right Pinky on",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 1,
              "parameter_initial": [
                1
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "Off",
                "On"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "Right_Pinky_on_send",
          "maxclass": "newobj",
          "patching_rect": [
            795,
            942,
            145,
            22
          ],
          "text": "prepend config 5 on"
        }
      },
      {
        "box": {
          "id": "Right_Pinky_mode",
          "maxclass": "live.menu",
          "patching_rect": [
            950,
            942,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            409,
            87,
            45,
            14
          ],
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Right_Pinky_mode",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "items": [
            "Accel",
            "Toggle"
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Pinky mode",
              "parameter_shortname": "Right Pinky mode",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 1,
              "parameter_initial": [
                0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "Accel",
                "Toggle"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "Right_Pinky_mode_send",
          "maxclass": "newobj",
          "patching_rect": [
            1105,
            942,
            145,
            22
          ],
          "text": "prepend config 5 mode"
        }
      },
      {
        "box": {
          "id": "Right_Pinky_pitchmode",
          "maxclass": "live.menu",
          "patching_rect": [
            20,
            980,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            456,
            87,
            47,
            14
          ],
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Right_Pinky_pitchmode",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "items": [
            "Fixed",
            "Random",
            "Markov"
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Pinky pitchmode",
              "parameter_shortname": "Right Pinky pitchmode",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 2,
              "parameter_initial": [
                0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "Fixed",
                "Random",
                "Markov"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "Right_Pinky_pitchmode_send",
          "maxclass": "newobj",
          "patching_rect": [
            175,
            980,
            145,
            22
          ],
          "text": "prepend config 5 pitchmode"
        }
      },
      {
        "box": {
          "id": "Right_Pinky_note",
          "maxclass": "live.numbox",
          "patching_rect": [
            330,
            980,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            505,
            87,
            48,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Right_Pinky_note",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Pinky note",
              "parameter_shortname": "Right Pinky note",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 127,
              "parameter_initial": [
                65
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 8
            }
          }
        }
      },
      {
        "box": {
          "id": "Right_Pinky_note_send",
          "maxclass": "newobj",
          "patching_rect": [
            485,
            980,
            145,
            22
          ],
          "text": "prepend config 5 note"
        }
      },
      {
        "box": {
          "id": "Right_Pinky_low",
          "maxclass": "live.numbox",
          "patching_rect": [
            640,
            980,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            555,
            87,
            48,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Right_Pinky_low",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Pinky low",
              "parameter_shortname": "Right Pinky low",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 127,
              "parameter_initial": [
                48
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 8
            }
          }
        }
      },
      {
        "box": {
          "id": "Right_Pinky_low_send",
          "maxclass": "newobj",
          "patching_rect": [
            795,
            980,
            145,
            22
          ],
          "text": "prepend config 5 low"
        }
      },
      {
        "box": {
          "id": "Right_Pinky_high",
          "maxclass": "live.numbox",
          "patching_rect": [
            950,
            980,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            605,
            87,
            48,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Right_Pinky_high",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Pinky high",
              "parameter_shortname": "Right Pinky high",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 127,
              "parameter_initial": [
                84
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 8
            }
          }
        }
      },
      {
        "box": {
          "id": "Right_Pinky_high_send",
          "maxclass": "newobj",
          "patching_rect": [
            1105,
            980,
            145,
            22
          ],
          "text": "prepend config 5 high"
        }
      },
      {
        "box": {
          "id": "Right_Ring",
          "maxclass": "live.comment",
          "patching_rect": [
            20,
            1018,
            145,
            22
          ],
          "text": "Ring",
          "presentation": 1,
          "presentation_rect": [
            340,
            103,
            47,
            14
          ],
          "fontsize": 9,
          "numinlets": 1,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "Right_Ring_set",
          "maxclass": "newobj",
          "patching_rect": [
            175,
            1018,
            145,
            22
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "Right_Ring_on",
          "maxclass": "live.toggle",
          "patching_rect": [
            330,
            1018,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            389,
            103,
            18,
            14
          ],
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "parameter_enable": 1,
          "varname": "Right_Ring_on",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Ring on",
              "parameter_shortname": "Right Ring on",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 1,
              "parameter_initial": [
                1
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "Off",
                "On"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "Right_Ring_on_send",
          "maxclass": "newobj",
          "patching_rect": [
            485,
            1018,
            145,
            22
          ],
          "text": "prepend config 6 on"
        }
      },
      {
        "box": {
          "id": "Right_Ring_mode",
          "maxclass": "live.menu",
          "patching_rect": [
            640,
            1018,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            409,
            103,
            45,
            14
          ],
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Right_Ring_mode",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "items": [
            "Accel",
            "Toggle"
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Ring mode",
              "parameter_shortname": "Right Ring mode",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 1,
              "parameter_initial": [
                0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "Accel",
                "Toggle"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "Right_Ring_mode_send",
          "maxclass": "newobj",
          "patching_rect": [
            795,
            1018,
            145,
            22
          ],
          "text": "prepend config 6 mode"
        }
      },
      {
        "box": {
          "id": "Right_Ring_pitchmode",
          "maxclass": "live.menu",
          "patching_rect": [
            950,
            1018,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            456,
            103,
            47,
            14
          ],
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Right_Ring_pitchmode",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "items": [
            "Fixed",
            "Random",
            "Markov"
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Ring pitchmode",
              "parameter_shortname": "Right Ring pitchmode",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 2,
              "parameter_initial": [
                0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "Fixed",
                "Random",
                "Markov"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "Right_Ring_pitchmode_send",
          "maxclass": "newobj",
          "patching_rect": [
            1105,
            1018,
            145,
            22
          ],
          "text": "prepend config 6 pitchmode"
        }
      },
      {
        "box": {
          "id": "Right_Ring_note",
          "maxclass": "live.numbox",
          "patching_rect": [
            20,
            1056,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            505,
            103,
            48,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Right_Ring_note",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Ring note",
              "parameter_shortname": "Right Ring note",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 127,
              "parameter_initial": [
                66
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 8
            }
          }
        }
      },
      {
        "box": {
          "id": "Right_Ring_note_send",
          "maxclass": "newobj",
          "patching_rect": [
            175,
            1056,
            145,
            22
          ],
          "text": "prepend config 6 note"
        }
      },
      {
        "box": {
          "id": "Right_Ring_low",
          "maxclass": "live.numbox",
          "patching_rect": [
            330,
            1056,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            555,
            103,
            48,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Right_Ring_low",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Ring low",
              "parameter_shortname": "Right Ring low",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 127,
              "parameter_initial": [
                48
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 8
            }
          }
        }
      },
      {
        "box": {
          "id": "Right_Ring_low_send",
          "maxclass": "newobj",
          "patching_rect": [
            485,
            1056,
            145,
            22
          ],
          "text": "prepend config 6 low"
        }
      },
      {
        "box": {
          "id": "Right_Ring_high",
          "maxclass": "live.numbox",
          "patching_rect": [
            640,
            1056,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            605,
            103,
            48,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Right_Ring_high",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Ring high",
              "parameter_shortname": "Right Ring high",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 127,
              "parameter_initial": [
                84
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 8
            }
          }
        }
      },
      {
        "box": {
          "id": "Right_Ring_high_send",
          "maxclass": "newobj",
          "patching_rect": [
            795,
            1056,
            145,
            22
          ],
          "text": "prepend config 6 high"
        }
      },
      {
        "box": {
          "id": "Right_Middle",
          "maxclass": "live.comment",
          "patching_rect": [
            950,
            1056,
            145,
            22
          ],
          "text": "Middle",
          "presentation": 1,
          "presentation_rect": [
            340,
            119,
            47,
            14
          ],
          "fontsize": 9,
          "numinlets": 1,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "Right_Middle_set",
          "maxclass": "newobj",
          "patching_rect": [
            1105,
            1056,
            145,
            22
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "Right_Middle_on",
          "maxclass": "live.toggle",
          "patching_rect": [
            20,
            1094,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            389,
            119,
            18,
            14
          ],
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "parameter_enable": 1,
          "varname": "Right_Middle_on",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Middle on",
              "parameter_shortname": "Right Middle on",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 1,
              "parameter_initial": [
                1
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "Off",
                "On"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "Right_Middle_on_send",
          "maxclass": "newobj",
          "patching_rect": [
            175,
            1094,
            145,
            22
          ],
          "text": "prepend config 7 on"
        }
      },
      {
        "box": {
          "id": "Right_Middle_mode",
          "maxclass": "live.menu",
          "patching_rect": [
            330,
            1094,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            409,
            119,
            45,
            14
          ],
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Right_Middle_mode",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "items": [
            "Accel",
            "Toggle"
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Middle mode",
              "parameter_shortname": "Right Middle mode",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 1,
              "parameter_initial": [
                0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "Accel",
                "Toggle"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "Right_Middle_mode_send",
          "maxclass": "newobj",
          "patching_rect": [
            485,
            1094,
            145,
            22
          ],
          "text": "prepend config 7 mode"
        }
      },
      {
        "box": {
          "id": "Right_Middle_pitchmode",
          "maxclass": "live.menu",
          "patching_rect": [
            640,
            1094,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            456,
            119,
            47,
            14
          ],
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Right_Middle_pitchmode",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "items": [
            "Fixed",
            "Random",
            "Markov"
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Middle pitchmode",
              "parameter_shortname": "Right Middle pitchmode",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 2,
              "parameter_initial": [
                0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "Fixed",
                "Random",
                "Markov"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "Right_Middle_pitchmode_send",
          "maxclass": "newobj",
          "patching_rect": [
            795,
            1094,
            145,
            22
          ],
          "text": "prepend config 7 pitchmode"
        }
      },
      {
        "box": {
          "id": "Right_Middle_note",
          "maxclass": "live.numbox",
          "patching_rect": [
            950,
            1094,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            505,
            119,
            48,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Right_Middle_note",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Middle note",
              "parameter_shortname": "Right Middle note",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 127,
              "parameter_initial": [
                67
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 8
            }
          }
        }
      },
      {
        "box": {
          "id": "Right_Middle_note_send",
          "maxclass": "newobj",
          "patching_rect": [
            1105,
            1094,
            145,
            22
          ],
          "text": "prepend config 7 note"
        }
      },
      {
        "box": {
          "id": "Right_Middle_low",
          "maxclass": "live.numbox",
          "patching_rect": [
            20,
            1132,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            555,
            119,
            48,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Right_Middle_low",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Middle low",
              "parameter_shortname": "Right Middle low",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 127,
              "parameter_initial": [
                48
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 8
            }
          }
        }
      },
      {
        "box": {
          "id": "Right_Middle_low_send",
          "maxclass": "newobj",
          "patching_rect": [
            175,
            1132,
            145,
            22
          ],
          "text": "prepend config 7 low"
        }
      },
      {
        "box": {
          "id": "Right_Middle_high",
          "maxclass": "live.numbox",
          "patching_rect": [
            330,
            1132,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            605,
            119,
            48,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Right_Middle_high",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Middle high",
              "parameter_shortname": "Right Middle high",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 127,
              "parameter_initial": [
                84
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 8
            }
          }
        }
      },
      {
        "box": {
          "id": "Right_Middle_high_send",
          "maxclass": "newobj",
          "patching_rect": [
            485,
            1132,
            145,
            22
          ],
          "text": "prepend config 7 high"
        }
      },
      {
        "box": {
          "id": "Right_Index",
          "maxclass": "live.comment",
          "patching_rect": [
            640,
            1132,
            145,
            22
          ],
          "text": "Index",
          "presentation": 1,
          "presentation_rect": [
            340,
            135,
            47,
            14
          ],
          "fontsize": 9,
          "numinlets": 1,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "Right_Index_set",
          "maxclass": "newobj",
          "patching_rect": [
            795,
            1132,
            145,
            22
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "Right_Index_on",
          "maxclass": "live.toggle",
          "patching_rect": [
            950,
            1132,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            389,
            135,
            18,
            14
          ],
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "parameter_enable": 1,
          "varname": "Right_Index_on",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Index on",
              "parameter_shortname": "Right Index on",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 1,
              "parameter_initial": [
                1
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "Off",
                "On"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "Right_Index_on_send",
          "maxclass": "newobj",
          "patching_rect": [
            1105,
            1132,
            145,
            22
          ],
          "text": "prepend config 8 on"
        }
      },
      {
        "box": {
          "id": "Right_Index_mode",
          "maxclass": "live.menu",
          "patching_rect": [
            20,
            1170,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            409,
            135,
            45,
            14
          ],
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Right_Index_mode",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "items": [
            "Accel",
            "Toggle"
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Index mode",
              "parameter_shortname": "Right Index mode",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 1,
              "parameter_initial": [
                0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "Accel",
                "Toggle"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "Right_Index_mode_send",
          "maxclass": "newobj",
          "patching_rect": [
            175,
            1170,
            145,
            22
          ],
          "text": "prepend config 8 mode"
        }
      },
      {
        "box": {
          "id": "Right_Index_pitchmode",
          "maxclass": "live.menu",
          "patching_rect": [
            330,
            1170,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            456,
            135,
            47,
            14
          ],
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Right_Index_pitchmode",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "items": [
            "Fixed",
            "Random",
            "Markov"
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Index pitchmode",
              "parameter_shortname": "Right Index pitchmode",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 2,
              "parameter_initial": [
                0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "Fixed",
                "Random",
                "Markov"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "Right_Index_pitchmode_send",
          "maxclass": "newobj",
          "patching_rect": [
            485,
            1170,
            145,
            22
          ],
          "text": "prepend config 8 pitchmode"
        }
      },
      {
        "box": {
          "id": "Right_Index_note",
          "maxclass": "live.numbox",
          "patching_rect": [
            640,
            1170,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            505,
            135,
            48,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Right_Index_note",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Index note",
              "parameter_shortname": "Right Index note",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 127,
              "parameter_initial": [
                68
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 8
            }
          }
        }
      },
      {
        "box": {
          "id": "Right_Index_note_send",
          "maxclass": "newobj",
          "patching_rect": [
            795,
            1170,
            145,
            22
          ],
          "text": "prepend config 8 note"
        }
      },
      {
        "box": {
          "id": "Right_Index_low",
          "maxclass": "live.numbox",
          "patching_rect": [
            950,
            1170,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            555,
            135,
            48,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Right_Index_low",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Index low",
              "parameter_shortname": "Right Index low",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 127,
              "parameter_initial": [
                48
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 8
            }
          }
        }
      },
      {
        "box": {
          "id": "Right_Index_low_send",
          "maxclass": "newobj",
          "patching_rect": [
            1105,
            1170,
            145,
            22
          ],
          "text": "prepend config 8 low"
        }
      },
      {
        "box": {
          "id": "Right_Index_high",
          "maxclass": "live.numbox",
          "patching_rect": [
            20,
            1208,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            605,
            135,
            48,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Right_Index_high",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Index high",
              "parameter_shortname": "Right Index high",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 127,
              "parameter_initial": [
                84
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 8
            }
          }
        }
      },
      {
        "box": {
          "id": "Right_Index_high_send",
          "maxclass": "newobj",
          "patching_rect": [
            175,
            1208,
            145,
            22
          ],
          "text": "prepend config 8 high"
        }
      },
      {
        "box": {
          "id": "Right_Thumb",
          "maxclass": "live.comment",
          "patching_rect": [
            330,
            1208,
            145,
            22
          ],
          "text": "Thumb",
          "presentation": 1,
          "presentation_rect": [
            340,
            151,
            47,
            14
          ],
          "fontsize": 9,
          "numinlets": 1,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "Right_Thumb_set",
          "maxclass": "newobj",
          "patching_rect": [
            485,
            1208,
            145,
            22
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "Right_Thumb_on",
          "maxclass": "live.toggle",
          "patching_rect": [
            640,
            1208,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            389,
            151,
            18,
            14
          ],
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "parameter_enable": 1,
          "varname": "Right_Thumb_on",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Thumb on",
              "parameter_shortname": "Right Thumb on",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 1,
              "parameter_initial": [
                1
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "Off",
                "On"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "Right_Thumb_on_send",
          "maxclass": "newobj",
          "patching_rect": [
            795,
            1208,
            145,
            22
          ],
          "text": "prepend config 9 on"
        }
      },
      {
        "box": {
          "id": "Right_Thumb_mode",
          "maxclass": "live.menu",
          "patching_rect": [
            950,
            1208,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            409,
            151,
            45,
            14
          ],
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Right_Thumb_mode",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "items": [
            "Accel",
            "Toggle"
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Thumb mode",
              "parameter_shortname": "Right Thumb mode",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 1,
              "parameter_initial": [
                0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "Accel",
                "Toggle"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "Right_Thumb_mode_send",
          "maxclass": "newobj",
          "patching_rect": [
            1105,
            1208,
            145,
            22
          ],
          "text": "prepend config 9 mode"
        }
      },
      {
        "box": {
          "id": "Right_Thumb_pitchmode",
          "maxclass": "live.menu",
          "patching_rect": [
            20,
            1246,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            456,
            151,
            47,
            14
          ],
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Right_Thumb_pitchmode",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "items": [
            "Fixed",
            "Random",
            "Markov"
          ],
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Thumb pitchmode",
              "parameter_shortname": "Right Thumb pitchmode",
              "parameter_type": 2,
              "parameter_mmin": 0,
              "parameter_mmax": 2,
              "parameter_initial": [
                0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_enum": [
                "Fixed",
                "Random",
                "Markov"
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "Right_Thumb_pitchmode_send",
          "maxclass": "newobj",
          "patching_rect": [
            175,
            1246,
            145,
            22
          ],
          "text": "prepend config 9 pitchmode"
        }
      },
      {
        "box": {
          "id": "Right_Thumb_note",
          "maxclass": "live.numbox",
          "patching_rect": [
            330,
            1246,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            505,
            151,
            48,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Right_Thumb_note",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Thumb note",
              "parameter_shortname": "Right Thumb note",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 127,
              "parameter_initial": [
                69
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 8
            }
          }
        }
      },
      {
        "box": {
          "id": "Right_Thumb_note_send",
          "maxclass": "newobj",
          "patching_rect": [
            485,
            1246,
            145,
            22
          ],
          "text": "prepend config 9 note"
        }
      },
      {
        "box": {
          "id": "Right_Thumb_low",
          "maxclass": "live.numbox",
          "patching_rect": [
            640,
            1246,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            555,
            151,
            48,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Right_Thumb_low",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Thumb low",
              "parameter_shortname": "Right Thumb low",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 127,
              "parameter_initial": [
                48
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 8
            }
          }
        }
      },
      {
        "box": {
          "id": "Right_Thumb_low_send",
          "maxclass": "newobj",
          "patching_rect": [
            795,
            1246,
            145,
            22
          ],
          "text": "prepend config 9 low"
        }
      },
      {
        "box": {
          "id": "Right_Thumb_high",
          "maxclass": "live.numbox",
          "patching_rect": [
            950,
            1246,
            145,
            22
          ],
          "presentation": 1,
          "presentation_rect": [
            605,
            151,
            48,
            14
          ],
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 1,
          "varname": "Right_Thumb_high",
          "fontsize": 9,
          "annotation": "Drag up/down to select pitch; type C2 / A4 and press Enter. C3 = MIDI 60. Random/Markov use global Root/Scale; Markov uses the global preset.",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Right Thumb high",
              "parameter_shortname": "Right Thumb high",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 127,
              "parameter_initial": [
                84
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 8
            }
          }
        }
      },
      {
        "box": {
          "id": "Right_Thumb_high_send",
          "maxclass": "newobj",
          "patching_rect": [
            1105,
            1246,
            145,
            22
          ],
          "text": "prepend config 9 high"
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
            "init",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "init",
            2
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
            "init",
            0
          ],
          "destination": [
            "finishinit",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "finishinit",
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
            1
          ],
          "destination": [
            "device_state",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "device_state",
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
            "free",
            0
          ],
          "destination": [
            "stop",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "stop",
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
            "midiin",
            0
          ],
          "destination": [
            "engine",
            1
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
            "midiout",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "root",
            0
          ],
          "destination": [
            "root_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "root_send",
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
            "init",
            1
          ],
          "destination": [
            "root",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "scale",
            0
          ],
          "destination": [
            "scale_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "scale_send",
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
            "init",
            1
          ],
          "destination": [
            "scale",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "calibrate",
            0
          ],
          "destination": [
            "calibrate_bang",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "calibrate_bang",
            0
          ],
          "destination": [
            "calibrate_command",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "calibrate_command",
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
            "panic",
            0
          ],
          "destination": [
            "panic_bang",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "panic_bang",
            0
          ],
          "destination": [
            "panic_command",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "panic_command",
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
            "markov",
            0
          ],
          "destination": [
            "markov_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "markov_send",
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
            "init",
            1
          ],
          "destination": [
            "markov",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "sensitivity",
            0
          ],
          "destination": [
            "sensitivity_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "sensitivity_send",
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
            "init",
            1
          ],
          "destination": [
            "sensitivity",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "threshold",
            0
          ],
          "destination": [
            "threshold_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "threshold_send",
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
            "init",
            1
          ],
          "destination": [
            "threshold",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "length",
            0
          ],
          "destination": [
            "length_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "length_send",
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
            "init",
            1
          ],
          "destination": [
            "length",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "gap",
            0
          ],
          "destination": [
            "gap_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "gap_send",
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
            "init",
            1
          ],
          "destination": [
            "gap",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "vmin",
            0
          ],
          "destination": [
            "vmin_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "vmin_send",
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
            "init",
            1
          ],
          "destination": [
            "vmin",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "vmax",
            0
          ],
          "destination": [
            "vmax_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "vmax_send",
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
            "init",
            1
          ],
          "destination": [
            "vmax",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "channel",
            0
          ],
          "destination": [
            "channel_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "channel_send",
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
            "init",
            1
          ],
          "destination": [
            "channel",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "reference",
            0
          ],
          "destination": [
            "reference_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "reference_send",
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
            "init",
            1
          ],
          "destination": [
            "reference",
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
            "ui_route",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui_route",
            0
          ],
          "destination": [
            "hand_route",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui_route",
            1
          ],
          "destination": [
            "finger_route",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui_route",
            2
          ],
          "destination": [
            "notice_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "notice_set",
            0
          ],
          "destination": [
            "notice",
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
            "reference_route",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "reference_route",
            0
          ],
          "destination": [
            "reference_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "reference_set",
            0
          ],
          "destination": [
            "reference",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "hand_route",
            0
          ],
          "destination": [
            "Left_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_set",
            0
          ],
          "destination": [
            "Left_status",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_receive",
            0
          ],
          "destination": [
            "Left_input",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_input",
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
            "finger_route",
            0
          ],
          "destination": [
            "Left_Pinky_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Pinky_set",
            0
          ],
          "destination": [
            "Left_Pinky",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Pinky_on",
            0
          ],
          "destination": [
            "Left_Pinky_on_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Pinky_on_send",
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
            "Left_Pinky_mode",
            0
          ],
          "destination": [
            "Left_Pinky_mode_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Pinky_mode_send",
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
            "init",
            1
          ],
          "destination": [
            "Left_Pinky_mode",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Pinky_pitchmode",
            0
          ],
          "destination": [
            "Left_Pinky_pitchmode_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Pinky_pitchmode_send",
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
            "init",
            1
          ],
          "destination": [
            "Left_Pinky_pitchmode",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Pinky_note",
            0
          ],
          "destination": [
            "Left_Pinky_note_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Pinky_note_send",
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
            "init",
            1
          ],
          "destination": [
            "Left_Pinky_note",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Pinky_low",
            0
          ],
          "destination": [
            "Left_Pinky_low_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Pinky_low_send",
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
            "init",
            1
          ],
          "destination": [
            "Left_Pinky_low",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Pinky_high",
            0
          ],
          "destination": [
            "Left_Pinky_high_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Pinky_high_send",
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
            "init",
            1
          ],
          "destination": [
            "Left_Pinky_high",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "finger_route",
            1
          ],
          "destination": [
            "Left_Ring_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Ring_set",
            0
          ],
          "destination": [
            "Left_Ring",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Ring_on",
            0
          ],
          "destination": [
            "Left_Ring_on_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Ring_on_send",
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
            "Left_Ring_mode",
            0
          ],
          "destination": [
            "Left_Ring_mode_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Ring_mode_send",
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
            "init",
            1
          ],
          "destination": [
            "Left_Ring_mode",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Ring_pitchmode",
            0
          ],
          "destination": [
            "Left_Ring_pitchmode_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Ring_pitchmode_send",
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
            "init",
            1
          ],
          "destination": [
            "Left_Ring_pitchmode",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Ring_note",
            0
          ],
          "destination": [
            "Left_Ring_note_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Ring_note_send",
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
            "init",
            1
          ],
          "destination": [
            "Left_Ring_note",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Ring_low",
            0
          ],
          "destination": [
            "Left_Ring_low_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Ring_low_send",
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
            "init",
            1
          ],
          "destination": [
            "Left_Ring_low",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Ring_high",
            0
          ],
          "destination": [
            "Left_Ring_high_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Ring_high_send",
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
            "init",
            1
          ],
          "destination": [
            "Left_Ring_high",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "finger_route",
            2
          ],
          "destination": [
            "Left_Middle_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Middle_set",
            0
          ],
          "destination": [
            "Left_Middle",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Middle_on",
            0
          ],
          "destination": [
            "Left_Middle_on_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Middle_on_send",
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
            "Left_Middle_mode",
            0
          ],
          "destination": [
            "Left_Middle_mode_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Middle_mode_send",
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
            "init",
            1
          ],
          "destination": [
            "Left_Middle_mode",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Middle_pitchmode",
            0
          ],
          "destination": [
            "Left_Middle_pitchmode_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Middle_pitchmode_send",
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
            "init",
            1
          ],
          "destination": [
            "Left_Middle_pitchmode",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Middle_note",
            0
          ],
          "destination": [
            "Left_Middle_note_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Middle_note_send",
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
            "init",
            1
          ],
          "destination": [
            "Left_Middle_note",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Middle_low",
            0
          ],
          "destination": [
            "Left_Middle_low_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Middle_low_send",
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
            "init",
            1
          ],
          "destination": [
            "Left_Middle_low",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Middle_high",
            0
          ],
          "destination": [
            "Left_Middle_high_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Middle_high_send",
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
            "init",
            1
          ],
          "destination": [
            "Left_Middle_high",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "finger_route",
            3
          ],
          "destination": [
            "Left_Index_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Index_set",
            0
          ],
          "destination": [
            "Left_Index",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Index_on",
            0
          ],
          "destination": [
            "Left_Index_on_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Index_on_send",
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
            "Left_Index_mode",
            0
          ],
          "destination": [
            "Left_Index_mode_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Index_mode_send",
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
            "init",
            1
          ],
          "destination": [
            "Left_Index_mode",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Index_pitchmode",
            0
          ],
          "destination": [
            "Left_Index_pitchmode_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Index_pitchmode_send",
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
            "init",
            1
          ],
          "destination": [
            "Left_Index_pitchmode",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Index_note",
            0
          ],
          "destination": [
            "Left_Index_note_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Index_note_send",
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
            "init",
            1
          ],
          "destination": [
            "Left_Index_note",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Index_low",
            0
          ],
          "destination": [
            "Left_Index_low_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Index_low_send",
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
            "init",
            1
          ],
          "destination": [
            "Left_Index_low",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Index_high",
            0
          ],
          "destination": [
            "Left_Index_high_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Index_high_send",
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
            "init",
            1
          ],
          "destination": [
            "Left_Index_high",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "finger_route",
            4
          ],
          "destination": [
            "Left_Thumb_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Thumb_set",
            0
          ],
          "destination": [
            "Left_Thumb",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Thumb_on",
            0
          ],
          "destination": [
            "Left_Thumb_on_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Thumb_on_send",
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
            "Left_Thumb_mode",
            0
          ],
          "destination": [
            "Left_Thumb_mode_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Thumb_mode_send",
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
            "init",
            1
          ],
          "destination": [
            "Left_Thumb_mode",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Thumb_pitchmode",
            0
          ],
          "destination": [
            "Left_Thumb_pitchmode_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Thumb_pitchmode_send",
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
            "init",
            1
          ],
          "destination": [
            "Left_Thumb_pitchmode",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Thumb_note",
            0
          ],
          "destination": [
            "Left_Thumb_note_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Thumb_note_send",
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
            "init",
            1
          ],
          "destination": [
            "Left_Thumb_note",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Thumb_low",
            0
          ],
          "destination": [
            "Left_Thumb_low_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Thumb_low_send",
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
            "init",
            1
          ],
          "destination": [
            "Left_Thumb_low",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Thumb_high",
            0
          ],
          "destination": [
            "Left_Thumb_high_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Left_Thumb_high_send",
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
            "init",
            1
          ],
          "destination": [
            "Left_Thumb_high",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "hand_route",
            1
          ],
          "destination": [
            "Right_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_set",
            0
          ],
          "destination": [
            "Right_status",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_receive",
            0
          ],
          "destination": [
            "Right_input",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_input",
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
            "finger_route",
            5
          ],
          "destination": [
            "Right_Pinky_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Pinky_set",
            0
          ],
          "destination": [
            "Right_Pinky",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Pinky_on",
            0
          ],
          "destination": [
            "Right_Pinky_on_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Pinky_on_send",
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
            "Right_Pinky_mode",
            0
          ],
          "destination": [
            "Right_Pinky_mode_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Pinky_mode_send",
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
            "init",
            1
          ],
          "destination": [
            "Right_Pinky_mode",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Pinky_pitchmode",
            0
          ],
          "destination": [
            "Right_Pinky_pitchmode_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Pinky_pitchmode_send",
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
            "init",
            1
          ],
          "destination": [
            "Right_Pinky_pitchmode",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Pinky_note",
            0
          ],
          "destination": [
            "Right_Pinky_note_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Pinky_note_send",
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
            "init",
            1
          ],
          "destination": [
            "Right_Pinky_note",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Pinky_low",
            0
          ],
          "destination": [
            "Right_Pinky_low_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Pinky_low_send",
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
            "init",
            1
          ],
          "destination": [
            "Right_Pinky_low",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Pinky_high",
            0
          ],
          "destination": [
            "Right_Pinky_high_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Pinky_high_send",
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
            "init",
            1
          ],
          "destination": [
            "Right_Pinky_high",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "finger_route",
            6
          ],
          "destination": [
            "Right_Ring_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Ring_set",
            0
          ],
          "destination": [
            "Right_Ring",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Ring_on",
            0
          ],
          "destination": [
            "Right_Ring_on_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Ring_on_send",
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
            "Right_Ring_mode",
            0
          ],
          "destination": [
            "Right_Ring_mode_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Ring_mode_send",
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
            "init",
            1
          ],
          "destination": [
            "Right_Ring_mode",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Ring_pitchmode",
            0
          ],
          "destination": [
            "Right_Ring_pitchmode_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Ring_pitchmode_send",
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
            "init",
            1
          ],
          "destination": [
            "Right_Ring_pitchmode",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Ring_note",
            0
          ],
          "destination": [
            "Right_Ring_note_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Ring_note_send",
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
            "init",
            1
          ],
          "destination": [
            "Right_Ring_note",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Ring_low",
            0
          ],
          "destination": [
            "Right_Ring_low_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Ring_low_send",
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
            "init",
            1
          ],
          "destination": [
            "Right_Ring_low",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Ring_high",
            0
          ],
          "destination": [
            "Right_Ring_high_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Ring_high_send",
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
            "init",
            1
          ],
          "destination": [
            "Right_Ring_high",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "finger_route",
            7
          ],
          "destination": [
            "Right_Middle_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Middle_set",
            0
          ],
          "destination": [
            "Right_Middle",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Middle_on",
            0
          ],
          "destination": [
            "Right_Middle_on_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Middle_on_send",
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
            "Right_Middle_mode",
            0
          ],
          "destination": [
            "Right_Middle_mode_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Middle_mode_send",
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
            "init",
            1
          ],
          "destination": [
            "Right_Middle_mode",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Middle_pitchmode",
            0
          ],
          "destination": [
            "Right_Middle_pitchmode_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Middle_pitchmode_send",
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
            "init",
            1
          ],
          "destination": [
            "Right_Middle_pitchmode",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Middle_note",
            0
          ],
          "destination": [
            "Right_Middle_note_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Middle_note_send",
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
            "init",
            1
          ],
          "destination": [
            "Right_Middle_note",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Middle_low",
            0
          ],
          "destination": [
            "Right_Middle_low_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Middle_low_send",
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
            "init",
            1
          ],
          "destination": [
            "Right_Middle_low",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Middle_high",
            0
          ],
          "destination": [
            "Right_Middle_high_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Middle_high_send",
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
            "init",
            1
          ],
          "destination": [
            "Right_Middle_high",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "finger_route",
            8
          ],
          "destination": [
            "Right_Index_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Index_set",
            0
          ],
          "destination": [
            "Right_Index",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Index_on",
            0
          ],
          "destination": [
            "Right_Index_on_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Index_on_send",
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
            "Right_Index_mode",
            0
          ],
          "destination": [
            "Right_Index_mode_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Index_mode_send",
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
            "init",
            1
          ],
          "destination": [
            "Right_Index_mode",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Index_pitchmode",
            0
          ],
          "destination": [
            "Right_Index_pitchmode_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Index_pitchmode_send",
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
            "init",
            1
          ],
          "destination": [
            "Right_Index_pitchmode",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Index_note",
            0
          ],
          "destination": [
            "Right_Index_note_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Index_note_send",
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
            "init",
            1
          ],
          "destination": [
            "Right_Index_note",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Index_low",
            0
          ],
          "destination": [
            "Right_Index_low_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Index_low_send",
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
            "init",
            1
          ],
          "destination": [
            "Right_Index_low",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Index_high",
            0
          ],
          "destination": [
            "Right_Index_high_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Index_high_send",
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
            "init",
            1
          ],
          "destination": [
            "Right_Index_high",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "finger_route",
            9
          ],
          "destination": [
            "Right_Thumb_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Thumb_set",
            0
          ],
          "destination": [
            "Right_Thumb",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Thumb_on",
            0
          ],
          "destination": [
            "Right_Thumb_on_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Thumb_on_send",
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
            "Right_Thumb_mode",
            0
          ],
          "destination": [
            "Right_Thumb_mode_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Thumb_mode_send",
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
            "init",
            1
          ],
          "destination": [
            "Right_Thumb_mode",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Thumb_pitchmode",
            0
          ],
          "destination": [
            "Right_Thumb_pitchmode_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Thumb_pitchmode_send",
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
            "init",
            1
          ],
          "destination": [
            "Right_Thumb_pitchmode",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Thumb_note",
            0
          ],
          "destination": [
            "Right_Thumb_note_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Thumb_note_send",
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
            "init",
            1
          ],
          "destination": [
            "Right_Thumb_note",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Thumb_low",
            0
          ],
          "destination": [
            "Right_Thumb_low_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Thumb_low_send",
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
            "init",
            1
          ],
          "destination": [
            "Right_Thumb_low",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Thumb_high",
            0
          ],
          "destination": [
            "Right_Thumb_high_send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "Right_Thumb_high_send",
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
            "init",
            1
          ],
          "destination": [
            "Right_Thumb_high",
            0
          ]
        }
      }
    ],
    "parameters": {
      "root": [
        "Global Root",
        "Global Root",
        0
      ],
      "scale": [
        "Global Scale",
        "Global Scale",
        0
      ],
      "markov": [
        "Global Markov preset",
        "Global Markov preset",
        0
      ],
      "sensitivity": [
        "Global Sens %",
        "Global Sens %",
        0
      ],
      "threshold": [
        "Global Threshold",
        "Global Threshold",
        0
      ],
      "length": [
        "Global Length ms",
        "Global Length ms",
        0
      ],
      "gap": [
        "Global Retrig ms",
        "Global Retrig ms",
        0
      ],
      "vmin": [
        "Global V Min",
        "Global V Min",
        0
      ],
      "vmax": [
        "Global V Max",
        "Global V Max",
        0
      ],
      "channel": [
        "Global Ch",
        "Global Ch",
        0
      ],
      "reference": [
        "Global Cal ref / s²",
        "Global Cal ref / s²",
        0
      ],
      "Left_Pinky_on": [
        "Left Pinky on",
        "Left Pinky on",
        0
      ],
      "Left_Pinky_mode": [
        "Left Pinky mode",
        "Left Pinky mode",
        0
      ],
      "Left_Pinky_pitchmode": [
        "Left Pinky pitchmode",
        "Left Pinky pitchmode",
        0
      ],
      "Left_Pinky_note": [
        "Left Pinky note",
        "Left Pinky note",
        0
      ],
      "Left_Pinky_low": [
        "Left Pinky low",
        "Left Pinky low",
        0
      ],
      "Left_Pinky_high": [
        "Left Pinky high",
        "Left Pinky high",
        0
      ],
      "Left_Ring_on": [
        "Left Ring on",
        "Left Ring on",
        0
      ],
      "Left_Ring_mode": [
        "Left Ring mode",
        "Left Ring mode",
        0
      ],
      "Left_Ring_pitchmode": [
        "Left Ring pitchmode",
        "Left Ring pitchmode",
        0
      ],
      "Left_Ring_note": [
        "Left Ring note",
        "Left Ring note",
        0
      ],
      "Left_Ring_low": [
        "Left Ring low",
        "Left Ring low",
        0
      ],
      "Left_Ring_high": [
        "Left Ring high",
        "Left Ring high",
        0
      ],
      "Left_Middle_on": [
        "Left Middle on",
        "Left Middle on",
        0
      ],
      "Left_Middle_mode": [
        "Left Middle mode",
        "Left Middle mode",
        0
      ],
      "Left_Middle_pitchmode": [
        "Left Middle pitchmode",
        "Left Middle pitchmode",
        0
      ],
      "Left_Middle_note": [
        "Left Middle note",
        "Left Middle note",
        0
      ],
      "Left_Middle_low": [
        "Left Middle low",
        "Left Middle low",
        0
      ],
      "Left_Middle_high": [
        "Left Middle high",
        "Left Middle high",
        0
      ],
      "Left_Index_on": [
        "Left Index on",
        "Left Index on",
        0
      ],
      "Left_Index_mode": [
        "Left Index mode",
        "Left Index mode",
        0
      ],
      "Left_Index_pitchmode": [
        "Left Index pitchmode",
        "Left Index pitchmode",
        0
      ],
      "Left_Index_note": [
        "Left Index note",
        "Left Index note",
        0
      ],
      "Left_Index_low": [
        "Left Index low",
        "Left Index low",
        0
      ],
      "Left_Index_high": [
        "Left Index high",
        "Left Index high",
        0
      ],
      "Left_Thumb_on": [
        "Left Thumb on",
        "Left Thumb on",
        0
      ],
      "Left_Thumb_mode": [
        "Left Thumb mode",
        "Left Thumb mode",
        0
      ],
      "Left_Thumb_pitchmode": [
        "Left Thumb pitchmode",
        "Left Thumb pitchmode",
        0
      ],
      "Left_Thumb_note": [
        "Left Thumb note",
        "Left Thumb note",
        0
      ],
      "Left_Thumb_low": [
        "Left Thumb low",
        "Left Thumb low",
        0
      ],
      "Left_Thumb_high": [
        "Left Thumb high",
        "Left Thumb high",
        0
      ],
      "Right_Pinky_on": [
        "Right Pinky on",
        "Right Pinky on",
        0
      ],
      "Right_Pinky_mode": [
        "Right Pinky mode",
        "Right Pinky mode",
        0
      ],
      "Right_Pinky_pitchmode": [
        "Right Pinky pitchmode",
        "Right Pinky pitchmode",
        0
      ],
      "Right_Pinky_note": [
        "Right Pinky note",
        "Right Pinky note",
        0
      ],
      "Right_Pinky_low": [
        "Right Pinky low",
        "Right Pinky low",
        0
      ],
      "Right_Pinky_high": [
        "Right Pinky high",
        "Right Pinky high",
        0
      ],
      "Right_Ring_on": [
        "Right Ring on",
        "Right Ring on",
        0
      ],
      "Right_Ring_mode": [
        "Right Ring mode",
        "Right Ring mode",
        0
      ],
      "Right_Ring_pitchmode": [
        "Right Ring pitchmode",
        "Right Ring pitchmode",
        0
      ],
      "Right_Ring_note": [
        "Right Ring note",
        "Right Ring note",
        0
      ],
      "Right_Ring_low": [
        "Right Ring low",
        "Right Ring low",
        0
      ],
      "Right_Ring_high": [
        "Right Ring high",
        "Right Ring high",
        0
      ],
      "Right_Middle_on": [
        "Right Middle on",
        "Right Middle on",
        0
      ],
      "Right_Middle_mode": [
        "Right Middle mode",
        "Right Middle mode",
        0
      ],
      "Right_Middle_pitchmode": [
        "Right Middle pitchmode",
        "Right Middle pitchmode",
        0
      ],
      "Right_Middle_note": [
        "Right Middle note",
        "Right Middle note",
        0
      ],
      "Right_Middle_low": [
        "Right Middle low",
        "Right Middle low",
        0
      ],
      "Right_Middle_high": [
        "Right Middle high",
        "Right Middle high",
        0
      ],
      "Right_Index_on": [
        "Right Index on",
        "Right Index on",
        0
      ],
      "Right_Index_mode": [
        "Right Index mode",
        "Right Index mode",
        0
      ],
      "Right_Index_pitchmode": [
        "Right Index pitchmode",
        "Right Index pitchmode",
        0
      ],
      "Right_Index_note": [
        "Right Index note",
        "Right Index note",
        0
      ],
      "Right_Index_low": [
        "Right Index low",
        "Right Index low",
        0
      ],
      "Right_Index_high": [
        "Right Index high",
        "Right Index high",
        0
      ],
      "Right_Thumb_on": [
        "Right Thumb on",
        "Right Thumb on",
        0
      ],
      "Right_Thumb_mode": [
        "Right Thumb mode",
        "Right Thumb mode",
        0
      ],
      "Right_Thumb_pitchmode": [
        "Right Thumb pitchmode",
        "Right Thumb pitchmode",
        0
      ],
      "Right_Thumb_note": [
        "Right Thumb note",
        "Right Thumb note",
        0
      ],
      "Right_Thumb_low": [
        "Right Thumb low",
        "Right Thumb low",
        0
      ],
      "Right_Thumb_high": [
        "Right Thumb high",
        "Right Thumb high",
        0
      ],
      "inherited_shortname": 1
    },
    "autosave": 0,
    "dependency_cache": [
      {
        "name": "glove_midi_trigger.js",
        "bootpath": ".",
        "patcherrelativepath": ".",
        "type": "TEXT",
        "implicit": 1
      }
    ]
  }
}
