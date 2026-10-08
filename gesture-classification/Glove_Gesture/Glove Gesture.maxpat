{
  "patcher": {
    "fileversion": 1,
    "appversion": {
      "major": 9,
      "minor": 1,
      "revision": 5,
      "architecture": "arm64",
      "modernui": 1
    },
    "classnamespace": "box",
    "rect": [
      80,
      80,
      1100,
      900
    ],
    "openinpresentation": 1,
    "openrect": [
      0,
      0,
      800,
      169
    ],
    "devicewidth": 800,
    "enablehscroll": 0,
    "enablevscroll": 0,
    "bgcolor": [
      0.16,
      0.16,
      0.16,
      1
    ],
    "default_fontname": "Arial",
    "default_fontsize": 11,
    "boxes": [
      {
        "box": {
          "id": "web",
          "varname": "web",
          "maxclass": "jweb",
          "patching_rect": [
            0,
            0,
            800,
            169
          ],
          "presentation": 1,
          "presentation_rect": [
            0,
            0,
            800,
            169
          ],
          "numinlets": 1,
          "numoutlets": 1,
          "rendermode": 1
        }
      },
      {
        "box": {
          "id": "controller",
          "varname": "controller",
          "maxclass": "newobj",
          "patching_rect": [
            220,
            220,
            190,
            22
          ],
          "text": "js gesture_control.js #0",
          "numinlets": 1,
          "numoutlets": 4,
          "outlettype": [
            "",
            "",
            "",
            ""
          ]
        }
      },
      {
        "box": {
          "id": "mapping-pool",
          "varname": "mapping-pool",
          "maxclass": "newobj",
          "patching_rect": [
            420,
            220,
            190,
            22
          ],
          "text": "p mapping_pool",
          "patcher": {
            "fileversion": 1,
            "appversion": {
              "major": 9,
              "minor": 1,
              "revision": 5,
              "architecture": "arm64",
              "modernui": 1
            },
            "classnamespace": "box",
            "rect": [
              100,
              100,
              900,
              650
            ],
            "boxes": [
              {
                "box": {
                  "id": "learn-0",
                  "varname": "learn-0",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    20,
                    20,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-0",
                  "varname": "target-0",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    20,
                    68,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-1",
                  "varname": "learn-1",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    235,
                    20,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-1",
                  "varname": "target-1",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    235,
                    68,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-2",
                  "varname": "learn-2",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    450,
                    20,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-2",
                  "varname": "target-2",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    450,
                    68,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-3",
                  "varname": "learn-3",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    665,
                    20,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-3",
                  "varname": "target-3",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    665,
                    68,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-4",
                  "varname": "learn-4",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    20,
                    130,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-4",
                  "varname": "target-4",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    20,
                    178,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-5",
                  "varname": "learn-5",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    235,
                    130,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-5",
                  "varname": "target-5",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    235,
                    178,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-6",
                  "varname": "learn-6",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    450,
                    130,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-6",
                  "varname": "target-6",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    450,
                    178,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-7",
                  "varname": "learn-7",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    665,
                    130,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-7",
                  "varname": "target-7",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    665,
                    178,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-8",
                  "varname": "learn-8",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    20,
                    240,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-8",
                  "varname": "target-8",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    20,
                    288,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-9",
                  "varname": "learn-9",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    235,
                    240,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-9",
                  "varname": "target-9",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    235,
                    288,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-10",
                  "varname": "learn-10",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    450,
                    240,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-10",
                  "varname": "target-10",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    450,
                    288,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-11",
                  "varname": "learn-11",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    665,
                    240,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-11",
                  "varname": "target-11",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    665,
                    288,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-12",
                  "varname": "learn-12",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    20,
                    350,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-12",
                  "varname": "target-12",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    20,
                    398,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-13",
                  "varname": "learn-13",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    235,
                    350,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-13",
                  "varname": "target-13",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    235,
                    398,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-14",
                  "varname": "learn-14",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    450,
                    350,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-14",
                  "varname": "target-14",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    450,
                    398,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-15",
                  "varname": "learn-15",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    665,
                    350,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-15",
                  "varname": "target-15",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    665,
                    398,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-16",
                  "varname": "learn-16",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    20,
                    460,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-16",
                  "varname": "target-16",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    20,
                    508,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-17",
                  "varname": "learn-17",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    235,
                    460,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-17",
                  "varname": "target-17",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    235,
                    508,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-18",
                  "varname": "learn-18",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    450,
                    460,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-18",
                  "varname": "target-18",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    450,
                    508,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-19",
                  "varname": "learn-19",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    665,
                    460,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-19",
                  "varname": "target-19",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    665,
                    508,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-20",
                  "varname": "learn-20",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    20,
                    570,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-20",
                  "varname": "target-20",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    20,
                    618,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-21",
                  "varname": "learn-21",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    235,
                    570,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-21",
                  "varname": "target-21",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    235,
                    618,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-22",
                  "varname": "learn-22",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    450,
                    570,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-22",
                  "varname": "target-22",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    450,
                    618,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-23",
                  "varname": "learn-23",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    665,
                    570,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-23",
                  "varname": "target-23",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    665,
                    618,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-24",
                  "varname": "learn-24",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    20,
                    680,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-24",
                  "varname": "target-24",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    20,
                    728,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-25",
                  "varname": "learn-25",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    235,
                    680,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-25",
                  "varname": "target-25",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    235,
                    728,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-26",
                  "varname": "learn-26",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    450,
                    680,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-26",
                  "varname": "target-26",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    450,
                    728,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-27",
                  "varname": "learn-27",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    665,
                    680,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-27",
                  "varname": "target-27",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    665,
                    728,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-28",
                  "varname": "learn-28",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    20,
                    790,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-28",
                  "varname": "target-28",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    20,
                    838,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-29",
                  "varname": "learn-29",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    235,
                    790,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-29",
                  "varname": "target-29",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    235,
                    838,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-30",
                  "varname": "learn-30",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    450,
                    790,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-30",
                  "varname": "target-30",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    450,
                    838,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-31",
                  "varname": "learn-31",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    665,
                    790,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-31",
                  "varname": "target-31",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    665,
                    838,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-32",
                  "varname": "learn-32",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    20,
                    900,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-32",
                  "varname": "target-32",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    20,
                    948,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-33",
                  "varname": "learn-33",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    235,
                    900,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-33",
                  "varname": "target-33",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    235,
                    948,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-34",
                  "varname": "learn-34",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    450,
                    900,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-34",
                  "varname": "target-34",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    450,
                    948,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-35",
                  "varname": "learn-35",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    665,
                    900,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-35",
                  "varname": "target-35",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    665,
                    948,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-36",
                  "varname": "learn-36",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    20,
                    1010,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-36",
                  "varname": "target-36",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    20,
                    1058,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-37",
                  "varname": "learn-37",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    235,
                    1010,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-37",
                  "varname": "target-37",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    235,
                    1058,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-38",
                  "varname": "learn-38",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    450,
                    1010,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-38",
                  "varname": "target-38",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    450,
                    1058,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-39",
                  "varname": "learn-39",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    665,
                    1010,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-39",
                  "varname": "target-39",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    665,
                    1058,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-40",
                  "varname": "learn-40",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    20,
                    1120,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-40",
                  "varname": "target-40",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    20,
                    1168,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-41",
                  "varname": "learn-41",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    235,
                    1120,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-41",
                  "varname": "target-41",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    235,
                    1168,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-42",
                  "varname": "learn-42",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    450,
                    1120,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-42",
                  "varname": "target-42",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    450,
                    1168,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-43",
                  "varname": "learn-43",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    665,
                    1120,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-43",
                  "varname": "target-43",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    665,
                    1168,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-44",
                  "varname": "learn-44",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    20,
                    1230,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-44",
                  "varname": "target-44",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    20,
                    1278,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-45",
                  "varname": "learn-45",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    235,
                    1230,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-45",
                  "varname": "target-45",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    235,
                    1278,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-46",
                  "varname": "learn-46",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    450,
                    1230,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-46",
                  "varname": "target-46",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    450,
                    1278,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "learn-47",
                  "varname": "learn-47",
                  "maxclass": "newobj",
                  "text": "live.map @strict 1",
                  "patching_rect": [
                    665,
                    1230,
                    185,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 5,
                  "saved_object_attributes": {
                    "_persistence": 0
                  }
                }
              },
              {
                "box": {
                  "id": "target-47",
                  "varname": "target-47",
                  "maxclass": "newobj",
                  "text": "live.object",
                  "patching_rect": [
                    665,
                    1278,
                    185,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1,
                  "saved_object_attributes": {
                    "_persistence": 1
                  }
                }
              },
              {
                "box": {
                  "id": "pool-out",
                  "maxclass": "outlet",
                  "index": 1,
                  "patching_rect": [
                    20,
                    1440,
                    30,
                    30
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-0",
                  "maxclass": "newobj",
                  "text": "prepend learned 0",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-0",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 0",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-0",
                  "maxclass": "newobj",
                  "text": "prepend mapped 0",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-1",
                  "maxclass": "newobj",
                  "text": "prepend learned 1",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-1",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 1",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-1",
                  "maxclass": "newobj",
                  "text": "prepend mapped 1",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-2",
                  "maxclass": "newobj",
                  "text": "prepend learned 2",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-2",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 2",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-2",
                  "maxclass": "newobj",
                  "text": "prepend mapped 2",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-3",
                  "maxclass": "newobj",
                  "text": "prepend learned 3",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-3",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 3",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-3",
                  "maxclass": "newobj",
                  "text": "prepend mapped 3",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-4",
                  "maxclass": "newobj",
                  "text": "prepend learned 4",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-4",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 4",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-4",
                  "maxclass": "newobj",
                  "text": "prepend mapped 4",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-5",
                  "maxclass": "newobj",
                  "text": "prepend learned 5",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-5",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 5",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-5",
                  "maxclass": "newobj",
                  "text": "prepend mapped 5",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-6",
                  "maxclass": "newobj",
                  "text": "prepend learned 6",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-6",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 6",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-6",
                  "maxclass": "newobj",
                  "text": "prepend mapped 6",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-7",
                  "maxclass": "newobj",
                  "text": "prepend learned 7",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-7",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 7",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-7",
                  "maxclass": "newobj",
                  "text": "prepend mapped 7",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-8",
                  "maxclass": "newobj",
                  "text": "prepend learned 8",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-8",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 8",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-8",
                  "maxclass": "newobj",
                  "text": "prepend mapped 8",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-9",
                  "maxclass": "newobj",
                  "text": "prepend learned 9",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-9",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 9",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-9",
                  "maxclass": "newobj",
                  "text": "prepend mapped 9",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-10",
                  "maxclass": "newobj",
                  "text": "prepend learned 10",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-10",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 10",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-10",
                  "maxclass": "newobj",
                  "text": "prepend mapped 10",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-11",
                  "maxclass": "newobj",
                  "text": "prepend learned 11",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-11",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 11",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-11",
                  "maxclass": "newobj",
                  "text": "prepend mapped 11",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-12",
                  "maxclass": "newobj",
                  "text": "prepend learned 12",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-12",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 12",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-12",
                  "maxclass": "newobj",
                  "text": "prepend mapped 12",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-13",
                  "maxclass": "newobj",
                  "text": "prepend learned 13",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-13",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 13",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-13",
                  "maxclass": "newobj",
                  "text": "prepend mapped 13",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-14",
                  "maxclass": "newobj",
                  "text": "prepend learned 14",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-14",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 14",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-14",
                  "maxclass": "newobj",
                  "text": "prepend mapped 14",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-15",
                  "maxclass": "newobj",
                  "text": "prepend learned 15",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-15",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 15",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-15",
                  "maxclass": "newobj",
                  "text": "prepend mapped 15",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-16",
                  "maxclass": "newobj",
                  "text": "prepend learned 16",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-16",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 16",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-16",
                  "maxclass": "newobj",
                  "text": "prepend mapped 16",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-17",
                  "maxclass": "newobj",
                  "text": "prepend learned 17",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-17",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 17",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-17",
                  "maxclass": "newobj",
                  "text": "prepend mapped 17",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-18",
                  "maxclass": "newobj",
                  "text": "prepend learned 18",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-18",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 18",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-18",
                  "maxclass": "newobj",
                  "text": "prepend mapped 18",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-19",
                  "maxclass": "newobj",
                  "text": "prepend learned 19",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-19",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 19",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-19",
                  "maxclass": "newobj",
                  "text": "prepend mapped 19",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-20",
                  "maxclass": "newobj",
                  "text": "prepend learned 20",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-20",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 20",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-20",
                  "maxclass": "newobj",
                  "text": "prepend mapped 20",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-21",
                  "maxclass": "newobj",
                  "text": "prepend learned 21",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-21",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 21",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-21",
                  "maxclass": "newobj",
                  "text": "prepend mapped 21",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-22",
                  "maxclass": "newobj",
                  "text": "prepend learned 22",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-22",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 22",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-22",
                  "maxclass": "newobj",
                  "text": "prepend mapped 22",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-23",
                  "maxclass": "newobj",
                  "text": "prepend learned 23",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-23",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 23",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-23",
                  "maxclass": "newobj",
                  "text": "prepend mapped 23",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-24",
                  "maxclass": "newobj",
                  "text": "prepend learned 24",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-24",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 24",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-24",
                  "maxclass": "newobj",
                  "text": "prepend mapped 24",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-25",
                  "maxclass": "newobj",
                  "text": "prepend learned 25",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-25",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 25",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-25",
                  "maxclass": "newobj",
                  "text": "prepend mapped 25",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-26",
                  "maxclass": "newobj",
                  "text": "prepend learned 26",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-26",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 26",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-26",
                  "maxclass": "newobj",
                  "text": "prepend mapped 26",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-27",
                  "maxclass": "newobj",
                  "text": "prepend learned 27",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-27",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 27",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-27",
                  "maxclass": "newobj",
                  "text": "prepend mapped 27",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-28",
                  "maxclass": "newobj",
                  "text": "prepend learned 28",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-28",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 28",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-28",
                  "maxclass": "newobj",
                  "text": "prepend mapped 28",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-29",
                  "maxclass": "newobj",
                  "text": "prepend learned 29",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-29",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 29",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-29",
                  "maxclass": "newobj",
                  "text": "prepend mapped 29",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-30",
                  "maxclass": "newobj",
                  "text": "prepend learned 30",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-30",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 30",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-30",
                  "maxclass": "newobj",
                  "text": "prepend mapped 30",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-31",
                  "maxclass": "newobj",
                  "text": "prepend learned 31",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-31",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 31",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-31",
                  "maxclass": "newobj",
                  "text": "prepend mapped 31",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-32",
                  "maxclass": "newobj",
                  "text": "prepend learned 32",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-32",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 32",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-32",
                  "maxclass": "newobj",
                  "text": "prepend mapped 32",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-33",
                  "maxclass": "newobj",
                  "text": "prepend learned 33",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-33",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 33",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-33",
                  "maxclass": "newobj",
                  "text": "prepend mapped 33",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-34",
                  "maxclass": "newobj",
                  "text": "prepend learned 34",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-34",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 34",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-34",
                  "maxclass": "newobj",
                  "text": "prepend mapped 34",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-35",
                  "maxclass": "newobj",
                  "text": "prepend learned 35",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-35",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 35",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-35",
                  "maxclass": "newobj",
                  "text": "prepend mapped 35",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-36",
                  "maxclass": "newobj",
                  "text": "prepend learned 36",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-36",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 36",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-36",
                  "maxclass": "newobj",
                  "text": "prepend mapped 36",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-37",
                  "maxclass": "newobj",
                  "text": "prepend learned 37",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-37",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 37",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-37",
                  "maxclass": "newobj",
                  "text": "prepend mapped 37",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-38",
                  "maxclass": "newobj",
                  "text": "prepend learned 38",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-38",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 38",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-38",
                  "maxclass": "newobj",
                  "text": "prepend mapped 38",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-39",
                  "maxclass": "newobj",
                  "text": "prepend learned 39",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-39",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 39",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-39",
                  "maxclass": "newobj",
                  "text": "prepend mapped 39",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-40",
                  "maxclass": "newobj",
                  "text": "prepend learned 40",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-40",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 40",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-40",
                  "maxclass": "newobj",
                  "text": "prepend mapped 40",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-41",
                  "maxclass": "newobj",
                  "text": "prepend learned 41",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-41",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 41",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-41",
                  "maxclass": "newobj",
                  "text": "prepend mapped 41",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-42",
                  "maxclass": "newobj",
                  "text": "prepend learned 42",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-42",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 42",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-42",
                  "maxclass": "newobj",
                  "text": "prepend mapped 42",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-43",
                  "maxclass": "newobj",
                  "text": "prepend learned 43",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-43",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 43",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-43",
                  "maxclass": "newobj",
                  "text": "prepend mapped 43",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-44",
                  "maxclass": "newobj",
                  "text": "prepend learned 44",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-44",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 44",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-44",
                  "maxclass": "newobj",
                  "text": "prepend mapped 44",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-45",
                  "maxclass": "newobj",
                  "text": "prepend learned 45",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-45",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 45",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-45",
                  "maxclass": "newobj",
                  "text": "prepend mapped 45",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-46",
                  "maxclass": "newobj",
                  "text": "prepend learned 46",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-46",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 46",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-46",
                  "maxclass": "newobj",
                  "text": "prepend mapped 46",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learned-47",
                  "maxclass": "newobj",
                  "text": "prepend learned 47",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "learnstate-47",
                  "maxclass": "newobj",
                  "text": "prepend learnstate 47",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "mapped-47",
                  "maxclass": "newobj",
                  "text": "prepend mapped 47",
                  "patching_rect": [
                    20,
                    1400,
                    150,
                    22
                  ]
                }
              }
            ],
            "lines": [
              {
                "patchline": {
                  "source": [
                    "learn-0",
                    1
                  ],
                  "destination": [
                    "learned-0",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-0",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-0",
                    3
                  ],
                  "destination": [
                    "learnstate-0",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-0",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-0",
                    0
                  ],
                  "destination": [
                    "mapped-0",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-0",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-1",
                    1
                  ],
                  "destination": [
                    "learned-1",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-1",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-1",
                    3
                  ],
                  "destination": [
                    "learnstate-1",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-1",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-1",
                    0
                  ],
                  "destination": [
                    "mapped-1",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-1",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-2",
                    1
                  ],
                  "destination": [
                    "learned-2",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-2",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-2",
                    3
                  ],
                  "destination": [
                    "learnstate-2",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-2",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-2",
                    0
                  ],
                  "destination": [
                    "mapped-2",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-2",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-3",
                    1
                  ],
                  "destination": [
                    "learned-3",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-3",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-3",
                    3
                  ],
                  "destination": [
                    "learnstate-3",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-3",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-3",
                    0
                  ],
                  "destination": [
                    "mapped-3",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-3",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-4",
                    1
                  ],
                  "destination": [
                    "learned-4",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-4",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-4",
                    3
                  ],
                  "destination": [
                    "learnstate-4",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-4",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-4",
                    0
                  ],
                  "destination": [
                    "mapped-4",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-4",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-5",
                    1
                  ],
                  "destination": [
                    "learned-5",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-5",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-5",
                    3
                  ],
                  "destination": [
                    "learnstate-5",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-5",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-5",
                    0
                  ],
                  "destination": [
                    "mapped-5",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-5",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-6",
                    1
                  ],
                  "destination": [
                    "learned-6",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-6",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-6",
                    3
                  ],
                  "destination": [
                    "learnstate-6",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-6",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-6",
                    0
                  ],
                  "destination": [
                    "mapped-6",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-6",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-7",
                    1
                  ],
                  "destination": [
                    "learned-7",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-7",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-7",
                    3
                  ],
                  "destination": [
                    "learnstate-7",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-7",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-7",
                    0
                  ],
                  "destination": [
                    "mapped-7",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-7",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-8",
                    1
                  ],
                  "destination": [
                    "learned-8",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-8",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-8",
                    3
                  ],
                  "destination": [
                    "learnstate-8",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-8",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-8",
                    0
                  ],
                  "destination": [
                    "mapped-8",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-8",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-9",
                    1
                  ],
                  "destination": [
                    "learned-9",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-9",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-9",
                    3
                  ],
                  "destination": [
                    "learnstate-9",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-9",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-9",
                    0
                  ],
                  "destination": [
                    "mapped-9",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-9",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-10",
                    1
                  ],
                  "destination": [
                    "learned-10",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-10",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-10",
                    3
                  ],
                  "destination": [
                    "learnstate-10",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-10",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-10",
                    0
                  ],
                  "destination": [
                    "mapped-10",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-10",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-11",
                    1
                  ],
                  "destination": [
                    "learned-11",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-11",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-11",
                    3
                  ],
                  "destination": [
                    "learnstate-11",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-11",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-11",
                    0
                  ],
                  "destination": [
                    "mapped-11",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-11",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-12",
                    1
                  ],
                  "destination": [
                    "learned-12",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-12",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-12",
                    3
                  ],
                  "destination": [
                    "learnstate-12",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-12",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-12",
                    0
                  ],
                  "destination": [
                    "mapped-12",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-12",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-13",
                    1
                  ],
                  "destination": [
                    "learned-13",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-13",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-13",
                    3
                  ],
                  "destination": [
                    "learnstate-13",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-13",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-13",
                    0
                  ],
                  "destination": [
                    "mapped-13",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-13",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-14",
                    1
                  ],
                  "destination": [
                    "learned-14",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-14",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-14",
                    3
                  ],
                  "destination": [
                    "learnstate-14",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-14",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-14",
                    0
                  ],
                  "destination": [
                    "mapped-14",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-14",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-15",
                    1
                  ],
                  "destination": [
                    "learned-15",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-15",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-15",
                    3
                  ],
                  "destination": [
                    "learnstate-15",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-15",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-15",
                    0
                  ],
                  "destination": [
                    "mapped-15",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-15",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-16",
                    1
                  ],
                  "destination": [
                    "learned-16",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-16",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-16",
                    3
                  ],
                  "destination": [
                    "learnstate-16",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-16",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-16",
                    0
                  ],
                  "destination": [
                    "mapped-16",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-16",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-17",
                    1
                  ],
                  "destination": [
                    "learned-17",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-17",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-17",
                    3
                  ],
                  "destination": [
                    "learnstate-17",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-17",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-17",
                    0
                  ],
                  "destination": [
                    "mapped-17",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-17",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-18",
                    1
                  ],
                  "destination": [
                    "learned-18",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-18",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-18",
                    3
                  ],
                  "destination": [
                    "learnstate-18",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-18",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-18",
                    0
                  ],
                  "destination": [
                    "mapped-18",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-18",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-19",
                    1
                  ],
                  "destination": [
                    "learned-19",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-19",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-19",
                    3
                  ],
                  "destination": [
                    "learnstate-19",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-19",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-19",
                    0
                  ],
                  "destination": [
                    "mapped-19",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-19",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-20",
                    1
                  ],
                  "destination": [
                    "learned-20",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-20",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-20",
                    3
                  ],
                  "destination": [
                    "learnstate-20",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-20",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-20",
                    0
                  ],
                  "destination": [
                    "mapped-20",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-20",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-21",
                    1
                  ],
                  "destination": [
                    "learned-21",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-21",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-21",
                    3
                  ],
                  "destination": [
                    "learnstate-21",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-21",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-21",
                    0
                  ],
                  "destination": [
                    "mapped-21",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-21",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-22",
                    1
                  ],
                  "destination": [
                    "learned-22",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-22",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-22",
                    3
                  ],
                  "destination": [
                    "learnstate-22",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-22",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-22",
                    0
                  ],
                  "destination": [
                    "mapped-22",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-22",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-23",
                    1
                  ],
                  "destination": [
                    "learned-23",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-23",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-23",
                    3
                  ],
                  "destination": [
                    "learnstate-23",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-23",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-23",
                    0
                  ],
                  "destination": [
                    "mapped-23",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-23",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-24",
                    1
                  ],
                  "destination": [
                    "learned-24",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-24",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-24",
                    3
                  ],
                  "destination": [
                    "learnstate-24",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-24",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-24",
                    0
                  ],
                  "destination": [
                    "mapped-24",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-24",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-25",
                    1
                  ],
                  "destination": [
                    "learned-25",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-25",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-25",
                    3
                  ],
                  "destination": [
                    "learnstate-25",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-25",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-25",
                    0
                  ],
                  "destination": [
                    "mapped-25",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-25",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-26",
                    1
                  ],
                  "destination": [
                    "learned-26",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-26",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-26",
                    3
                  ],
                  "destination": [
                    "learnstate-26",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-26",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-26",
                    0
                  ],
                  "destination": [
                    "mapped-26",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-26",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-27",
                    1
                  ],
                  "destination": [
                    "learned-27",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-27",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-27",
                    3
                  ],
                  "destination": [
                    "learnstate-27",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-27",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-27",
                    0
                  ],
                  "destination": [
                    "mapped-27",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-27",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-28",
                    1
                  ],
                  "destination": [
                    "learned-28",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-28",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-28",
                    3
                  ],
                  "destination": [
                    "learnstate-28",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-28",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-28",
                    0
                  ],
                  "destination": [
                    "mapped-28",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-28",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-29",
                    1
                  ],
                  "destination": [
                    "learned-29",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-29",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-29",
                    3
                  ],
                  "destination": [
                    "learnstate-29",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-29",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-29",
                    0
                  ],
                  "destination": [
                    "mapped-29",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-29",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-30",
                    1
                  ],
                  "destination": [
                    "learned-30",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-30",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-30",
                    3
                  ],
                  "destination": [
                    "learnstate-30",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-30",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-30",
                    0
                  ],
                  "destination": [
                    "mapped-30",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-30",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-31",
                    1
                  ],
                  "destination": [
                    "learned-31",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-31",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-31",
                    3
                  ],
                  "destination": [
                    "learnstate-31",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-31",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-31",
                    0
                  ],
                  "destination": [
                    "mapped-31",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-31",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-32",
                    1
                  ],
                  "destination": [
                    "learned-32",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-32",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-32",
                    3
                  ],
                  "destination": [
                    "learnstate-32",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-32",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-32",
                    0
                  ],
                  "destination": [
                    "mapped-32",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-32",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-33",
                    1
                  ],
                  "destination": [
                    "learned-33",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-33",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-33",
                    3
                  ],
                  "destination": [
                    "learnstate-33",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-33",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-33",
                    0
                  ],
                  "destination": [
                    "mapped-33",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-33",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-34",
                    1
                  ],
                  "destination": [
                    "learned-34",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-34",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-34",
                    3
                  ],
                  "destination": [
                    "learnstate-34",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-34",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-34",
                    0
                  ],
                  "destination": [
                    "mapped-34",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-34",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-35",
                    1
                  ],
                  "destination": [
                    "learned-35",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-35",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-35",
                    3
                  ],
                  "destination": [
                    "learnstate-35",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-35",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-35",
                    0
                  ],
                  "destination": [
                    "mapped-35",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-35",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-36",
                    1
                  ],
                  "destination": [
                    "learned-36",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-36",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-36",
                    3
                  ],
                  "destination": [
                    "learnstate-36",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-36",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-36",
                    0
                  ],
                  "destination": [
                    "mapped-36",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-36",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-37",
                    1
                  ],
                  "destination": [
                    "learned-37",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-37",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-37",
                    3
                  ],
                  "destination": [
                    "learnstate-37",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-37",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-37",
                    0
                  ],
                  "destination": [
                    "mapped-37",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-37",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-38",
                    1
                  ],
                  "destination": [
                    "learned-38",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-38",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-38",
                    3
                  ],
                  "destination": [
                    "learnstate-38",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-38",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-38",
                    0
                  ],
                  "destination": [
                    "mapped-38",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-38",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-39",
                    1
                  ],
                  "destination": [
                    "learned-39",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-39",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-39",
                    3
                  ],
                  "destination": [
                    "learnstate-39",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-39",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-39",
                    0
                  ],
                  "destination": [
                    "mapped-39",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-39",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-40",
                    1
                  ],
                  "destination": [
                    "learned-40",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-40",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-40",
                    3
                  ],
                  "destination": [
                    "learnstate-40",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-40",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-40",
                    0
                  ],
                  "destination": [
                    "mapped-40",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-40",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-41",
                    1
                  ],
                  "destination": [
                    "learned-41",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-41",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-41",
                    3
                  ],
                  "destination": [
                    "learnstate-41",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-41",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-41",
                    0
                  ],
                  "destination": [
                    "mapped-41",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-41",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-42",
                    1
                  ],
                  "destination": [
                    "learned-42",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-42",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-42",
                    3
                  ],
                  "destination": [
                    "learnstate-42",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-42",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-42",
                    0
                  ],
                  "destination": [
                    "mapped-42",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-42",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-43",
                    1
                  ],
                  "destination": [
                    "learned-43",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-43",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-43",
                    3
                  ],
                  "destination": [
                    "learnstate-43",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-43",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-43",
                    0
                  ],
                  "destination": [
                    "mapped-43",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-43",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-44",
                    1
                  ],
                  "destination": [
                    "learned-44",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-44",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-44",
                    3
                  ],
                  "destination": [
                    "learnstate-44",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-44",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-44",
                    0
                  ],
                  "destination": [
                    "mapped-44",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-44",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-45",
                    1
                  ],
                  "destination": [
                    "learned-45",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-45",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-45",
                    3
                  ],
                  "destination": [
                    "learnstate-45",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-45",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-45",
                    0
                  ],
                  "destination": [
                    "mapped-45",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-45",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-46",
                    1
                  ],
                  "destination": [
                    "learned-46",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-46",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-46",
                    3
                  ],
                  "destination": [
                    "learnstate-46",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-46",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-46",
                    0
                  ],
                  "destination": [
                    "mapped-46",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-46",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-47",
                    1
                  ],
                  "destination": [
                    "learned-47",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learned-47",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learn-47",
                    3
                  ],
                  "destination": [
                    "learnstate-47",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "learnstate-47",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "target-47",
                    0
                  ],
                  "destination": [
                    "mapped-47",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "mapped-47",
                    0
                  ],
                  "destination": [
                    "pool-out",
                    0
                  ]
                }
              }
            ]
          }
        }
      },
      {
        "box": {
          "id": "mapping-pool-defer",
          "varname": "mapping-pool-defer",
          "maxclass": "newobj",
          "patching_rect": [
            620,
            220,
            190,
            22
          ],
          "text": "deferlow"
        }
      },
      {
        "box": {
          "id": "mapping-panel",
          "varname": "mapping-panel",
          "maxclass": "newobj",
          "patching_rect": [
            820,
            220,
            190,
            22
          ],
          "text": "p Gesture_Mapping",
          "patcher": {
            "fileversion": 1,
            "appversion": {
              "major": 9,
              "minor": 1,
              "revision": 5,
              "architecture": "arm64",
              "modernui": 1
            },
            "classnamespace": "box",
            "rect": [
              160,
              160,
              800,
              580
            ],
            "openinpresentation": 1,
            "boxes": [
              {
                "box": {
                  "id": "mapping-web",
                  "varname": "mapping-web",
                  "maxclass": "jweb",
                  "patching_rect": [
                    0,
                    0,
                    800,
                    580
                  ],
                  "presentation": 1,
                  "presentation_rect": [
                    0,
                    0,
                    800,
                    580
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "mapping-out",
                  "maxclass": "outlet",
                  "patching_rect": [
                    10,
                    620,
                    30,
                    30
                  ]
                }
              }
            ],
            "lines": [
              {
                "patchline": {
                  "source": [
                    "mapping-web",
                    0
                  ],
                  "destination": [
                    "mapping-out",
                    0
                  ]
                }
              }
            ]
          }
        }
      },
      {
        "box": {
          "id": "mapping-route",
          "varname": "mapping-route",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            262,
            190,
            22
          ],
          "text": "route command"
        }
      },
      {
        "box": {
          "id": "mapping-prefix",
          "varname": "mapping-prefix",
          "maxclass": "newobj",
          "patching_rect": [
            220,
            262,
            190,
            22
          ],
          "text": "prepend command"
        }
      },
      {
        "box": {
          "id": "mapping-defer",
          "varname": "mapping-defer",
          "maxclass": "newobj",
          "patching_rect": [
            420,
            262,
            190,
            22
          ],
          "text": "deferlow"
        }
      },
      {
        "box": {
          "id": "classifier-train",
          "varname": "classifier-train",
          "maxclass": "newobj",
          "patching_rect": [
            620,
            262,
            190,
            22
          ],
          "text": "fluid.mlpclassifier~ #0-gesture-trainer @hiddenlayers 8 @activation 3 @learnrate 0.01 @momentum 0.9 @batchsize 4 @validation 0 @maxiter 10",
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
          "id": "classifier-train-prefix",
          "varname": "classifier-train-prefix",
          "maxclass": "newobj",
          "patching_rect": [
            820,
            262,
            190,
            22
          ],
          "text": "prepend nativetrain"
        }
      },
      {
        "box": {
          "id": "classifier-train-defer",
          "varname": "classifier-train-defer",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            304,
            190,
            22
          ],
          "text": "deferlow"
        }
      },
      {
        "box": {
          "id": "classifier-infer",
          "varname": "classifier-infer",
          "maxclass": "newobj",
          "patching_rect": [
            220,
            304,
            190,
            22
          ],
          "text": "fluid.mlpclassifier~ #0-gesture-inference",
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
          "id": "classifier-infer-prefix",
          "varname": "classifier-infer-prefix",
          "maxclass": "newobj",
          "patching_rect": [
            420,
            304,
            190,
            22
          ],
          "text": "prepend nativeinfer"
        }
      },
      {
        "box": {
          "id": "classifier-infer-defer",
          "varname": "classifier-infer-defer",
          "maxclass": "newobj",
          "patching_rect": [
            620,
            304,
            190,
            22
          ],
          "text": "deferlow"
        }
      },
      {
        "box": {
          "id": "data-input",
          "varname": "data-input",
          "maxclass": "newobj",
          "patching_rect": [
            820,
            304,
            190,
            22
          ],
          "text": "fluid.dataset~ #0-gesture-x",
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
          "id": "data-input-prefix",
          "varname": "data-input-prefix",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            346,
            190,
            22
          ],
          "text": "prepend nativeinput"
        }
      },
      {
        "box": {
          "id": "data-input-defer",
          "varname": "data-input-defer",
          "maxclass": "newobj",
          "patching_rect": [
            220,
            346,
            190,
            22
          ],
          "text": "deferlow"
        }
      },
      {
        "box": {
          "id": "data-labels",
          "varname": "data-labels",
          "maxclass": "newobj",
          "patching_rect": [
            420,
            346,
            190,
            22
          ],
          "text": "fluid.labelset~ #0-gesture-labels",
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
          "id": "data-labels-prefix",
          "varname": "data-labels-prefix",
          "maxclass": "newobj",
          "patching_rect": [
            620,
            346,
            190,
            22
          ],
          "text": "prepend nativelabels"
        }
      },
      {
        "box": {
          "id": "data-labels-defer",
          "varname": "data-labels-defer",
          "maxclass": "newobj",
          "patching_rect": [
            820,
            346,
            190,
            22
          ],
          "text": "deferlow"
        }
      },
      {
        "box": {
          "id": "input-buffer",
          "varname": "input-buffer",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            388,
            190,
            22
          ],
          "text": "buffer~ #0-gesture-input @samps 5",
          "numinlets": 1,
          "numoutlets": 2
        }
      },
      {
        "box": {
          "id": "receive-left",
          "varname": "receive-left",
          "maxclass": "newobj",
          "patching_rect": [
            220,
            388,
            190,
            22
          ],
          "text": "r GLeft"
        }
      },
      {
        "box": {
          "id": "prefix-left",
          "varname": "prefix-left",
          "maxclass": "newobj",
          "patching_rect": [
            420,
            388,
            190,
            22
          ],
          "text": "prepend left"
        }
      },
      {
        "box": {
          "id": "defer-left",
          "varname": "defer-left",
          "maxclass": "newobj",
          "patching_rect": [
            620,
            388,
            190,
            22
          ],
          "text": "deferlow"
        }
      },
      {
        "box": {
          "id": "receive-right",
          "varname": "receive-right",
          "maxclass": "newobj",
          "patching_rect": [
            820,
            388,
            190,
            22
          ],
          "text": "r GRight"
        }
      },
      {
        "box": {
          "id": "prefix-right",
          "varname": "prefix-right",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            430,
            190,
            22
          ],
          "text": "prepend right"
        }
      },
      {
        "box": {
          "id": "defer-right",
          "varname": "defer-right",
          "maxclass": "newobj",
          "patching_rect": [
            220,
            430,
            190,
            22
          ],
          "text": "deferlow"
        }
      },
      {
        "box": {
          "id": "event-route",
          "varname": "event-route",
          "maxclass": "newobj",
          "patching_rect": [
            420,
            430,
            190,
            22
          ],
          "text": "route enter exit"
        }
      },
      {
        "box": {
          "id": "enter-route",
          "varname": "enter-route",
          "maxclass": "newobj",
          "patching_rect": [
            620,
            430,
            190,
            22
          ],
          "text": "route left right both"
        }
      },
      {
        "box": {
          "id": "enter-Left-prefix",
          "varname": "enter-Left-prefix",
          "maxclass": "newobj",
          "patching_rect": [
            820,
            430,
            190,
            22
          ],
          "text": "prepend enter"
        }
      },
      {
        "box": {
          "id": "enter-Left-send",
          "varname": "enter-Left-send",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            472,
            190,
            22
          ],
          "text": "s GGestureLeft"
        }
      },
      {
        "box": {
          "id": "enter-Right-prefix",
          "varname": "enter-Right-prefix",
          "maxclass": "newobj",
          "patching_rect": [
            220,
            472,
            190,
            22
          ],
          "text": "prepend enter"
        }
      },
      {
        "box": {
          "id": "enter-Right-send",
          "varname": "enter-Right-send",
          "maxclass": "newobj",
          "patching_rect": [
            420,
            472,
            190,
            22
          ],
          "text": "s GGestureRight"
        }
      },
      {
        "box": {
          "id": "enter-Both-prefix",
          "varname": "enter-Both-prefix",
          "maxclass": "newobj",
          "patching_rect": [
            620,
            472,
            190,
            22
          ],
          "text": "prepend enter"
        }
      },
      {
        "box": {
          "id": "enter-Both-send",
          "varname": "enter-Both-send",
          "maxclass": "newobj",
          "patching_rect": [
            820,
            472,
            190,
            22
          ],
          "text": "s GGestureBoth"
        }
      },
      {
        "box": {
          "id": "exit-route",
          "varname": "exit-route",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            514,
            190,
            22
          ],
          "text": "route left right both"
        }
      },
      {
        "box": {
          "id": "exit-Left-prefix",
          "varname": "exit-Left-prefix",
          "maxclass": "newobj",
          "patching_rect": [
            220,
            514,
            190,
            22
          ],
          "text": "prepend exit"
        }
      },
      {
        "box": {
          "id": "exit-Left-send",
          "varname": "exit-Left-send",
          "maxclass": "newobj",
          "patching_rect": [
            420,
            514,
            190,
            22
          ],
          "text": "s GGestureLeft"
        }
      },
      {
        "box": {
          "id": "exit-Right-prefix",
          "varname": "exit-Right-prefix",
          "maxclass": "newobj",
          "patching_rect": [
            620,
            514,
            190,
            22
          ],
          "text": "prepend exit"
        }
      },
      {
        "box": {
          "id": "exit-Right-send",
          "varname": "exit-Right-send",
          "maxclass": "newobj",
          "patching_rect": [
            820,
            514,
            190,
            22
          ],
          "text": "s GGestureRight"
        }
      },
      {
        "box": {
          "id": "exit-Both-prefix",
          "varname": "exit-Both-prefix",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            556,
            190,
            22
          ],
          "text": "prepend exit"
        }
      },
      {
        "box": {
          "id": "exit-Both-send",
          "varname": "exit-Both-send",
          "maxclass": "newobj",
          "patching_rect": [
            220,
            556,
            190,
            22
          ],
          "text": "s GGestureBoth"
        }
      },
      {
        "box": {
          "id": "route-ui",
          "varname": "route-ui",
          "maxclass": "newobj",
          "patching_rect": [
            420,
            556,
            190,
            22
          ],
          "text": "route command"
        }
      },
      {
        "box": {
          "id": "command-prefix",
          "varname": "command-prefix",
          "maxclass": "newobj",
          "patching_rect": [
            620,
            556,
            190,
            22
          ],
          "text": "prepend command"
        }
      },
      {
        "box": {
          "id": "defer-ui",
          "varname": "defer-ui",
          "maxclass": "newobj",
          "patching_rect": [
            820,
            556,
            190,
            22
          ],
          "text": "deferlow"
        }
      },
      {
        "box": {
          "id": "bank",
          "varname": "bank",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            598,
            190,
            22
          ],
          "text": "pattr gesture_bank",
          "numinlets": 1,
          "numoutlets": 3,
          "restore": [
            ""
          ],
          "saved_object_attributes": {
            "parameter_enable": 1
          },
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Glove Gesture Training Bank",
              "parameter_shortname": "Gesture Bank",
              "parameter_type": 3,
              "parameter_invisible": 1,
              "parameter_linknames": 0,
              "parameter_initial_enable": 0,
              "parameter_unitstyle": 10
            }
          }
        }
      },
      {
        "box": {
          "id": "restore-prefix",
          "varname": "restore-prefix",
          "maxclass": "newobj",
          "patching_rect": [
            220,
            598,
            190,
            22
          ],
          "text": "prepend restore"
        }
      },
      {
        "box": {
          "id": "restore-defer",
          "varname": "restore-defer",
          "maxclass": "newobj",
          "patching_rect": [
            420,
            598,
            190,
            22
          ],
          "text": "deferlow"
        }
      },
      {
        "box": {
          "id": "host",
          "varname": "host",
          "maxclass": "newobj",
          "patching_rect": [
            620,
            598,
            190,
            22
          ],
          "text": "live.thisdevice"
        }
      },
      {
        "box": {
          "id": "host-defer",
          "varname": "host-defer",
          "maxclass": "newobj",
          "patching_rect": [
            820,
            598,
            190,
            22
          ],
          "text": "deferlow"
        }
      },
      {
        "box": {
          "id": "load",
          "varname": "load",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            640,
            190,
            22
          ],
          "text": "loadbang"
        }
      },
      {
        "box": {
          "id": "load-defer",
          "varname": "load-defer",
          "maxclass": "newobj",
          "patching_rect": [
            220,
            640,
            190,
            22
          ],
          "text": "deferlow"
        }
      },
      {
        "box": {
          "id": "load-ui",
          "varname": "load-ui",
          "maxclass": "message",
          "patching_rect": [
            420,
            640,
            190,
            22
          ],
          "text": "loadbang"
        }
      },
      {
        "box": {
          "id": "colors",
          "varname": "colors",
          "maxclass": "newobj",
          "patching_rect": [
            620,
            640,
            190,
            22
          ],
          "text": "live.colors",
          "numinlets": 1,
          "numoutlets": 2
        }
      },
      {
        "box": {
          "id": "query-colors",
          "varname": "query-colors",
          "maxclass": "message",
          "patching_rect": [
            820,
            640,
            190,
            22
          ],
          "text": "everything"
        }
      },
      {
        "box": {
          "id": "theme-prefix",
          "varname": "theme-prefix",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            682,
            190,
            22
          ],
          "text": "prepend theme"
        }
      },
      {
        "box": {
          "id": "theme-defer",
          "varname": "theme-defer",
          "maxclass": "newobj",
          "patching_rect": [
            220,
            682,
            190,
            22
          ],
          "text": "deferlow"
        }
      },
      {
        "box": {
          "id": "dialog-route",
          "varname": "dialog-route",
          "maxclass": "newobj",
          "patching_rect": [
            420,
            682,
            190,
            22
          ],
          "text": "route import export help mapping"
        }
      },
      {
        "box": {
          "id": "import-dialog",
          "varname": "import-dialog",
          "maxclass": "newobj",
          "patching_rect": [
            620,
            682,
            190,
            22
          ],
          "text": "opendialog .json"
        }
      },
      {
        "box": {
          "id": "import-prefix",
          "varname": "import-prefix",
          "maxclass": "newobj",
          "patching_rect": [
            820,
            682,
            190,
            22
          ],
          "text": "prepend readmodel"
        }
      },
      {
        "box": {
          "id": "import-defer",
          "varname": "import-defer",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            724,
            190,
            22
          ],
          "text": "deferlow"
        }
      },
      {
        "box": {
          "id": "import-cancel",
          "varname": "import-cancel",
          "maxclass": "message",
          "patching_rect": [
            220,
            724,
            190,
            22
          ],
          "text": "dialogcancel import"
        }
      },
      {
        "box": {
          "id": "import-cancel-defer",
          "varname": "import-cancel-defer",
          "maxclass": "newobj",
          "patching_rect": [
            420,
            724,
            190,
            22
          ],
          "text": "deferlow"
        }
      },
      {
        "box": {
          "id": "export-dialog",
          "varname": "export-dialog",
          "maxclass": "newobj",
          "patching_rect": [
            620,
            724,
            190,
            22
          ],
          "text": "savedialog"
        }
      },
      {
        "box": {
          "id": "export-prefix",
          "varname": "export-prefix",
          "maxclass": "newobj",
          "patching_rect": [
            820,
            724,
            190,
            22
          ],
          "text": "prepend writemodel"
        }
      },
      {
        "box": {
          "id": "export-defer",
          "varname": "export-defer",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            766,
            190,
            22
          ],
          "text": "deferlow"
        }
      },
      {
        "box": {
          "id": "export-cancel",
          "varname": "export-cancel",
          "maxclass": "message",
          "patching_rect": [
            220,
            766,
            190,
            22
          ],
          "text": "dialogcancel export"
        }
      },
      {
        "box": {
          "id": "export-cancel-defer",
          "varname": "export-cancel-defer",
          "maxclass": "newobj",
          "patching_rect": [
            420,
            766,
            190,
            22
          ],
          "text": "deferlow"
        }
      },
      {
        "box": {
          "id": "mapping-open",
          "varname": "mapping-open",
          "maxclass": "message",
          "patching_rect": [
            620,
            766,
            190,
            22
          ],
          "text": "open"
        }
      },
      {
        "box": {
          "id": "mapping-control",
          "varname": "mapping-control",
          "maxclass": "newobj",
          "patching_rect": [
            820,
            766,
            190,
            22
          ],
          "text": "pcontrol"
        }
      },
      {
        "box": {
          "id": "help",
          "varname": "help",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            808,
            190,
            22
          ],
          "text": "p Gesture_Guide",
          "patcher": {
            "fileversion": 1,
            "appversion": {
              "major": 9,
              "minor": 1,
              "revision": 5,
              "architecture": "arm64",
              "modernui": 1
            },
            "classnamespace": "box",
            "rect": [
              180,
              180,
              650,
              600
            ],
            "openinpresentation": 1,
            "boxes": [
              {
                "box": {
                  "id": "help-web",
                  "maxclass": "jweb",
                  "varname": "help-web",
                  "patching_rect": [
                    0,
                    0,
                    650,
                    600
                  ],
                  "presentation": 1,
                  "presentation_rect": [
                    0,
                    0,
                    650,
                    600
                  ],
                  "numinlets": 1,
                  "numoutlets": 1,
                  "url": ""
                }
              },
              {
                "box": {
                  "id": "help-inlet",
                  "maxclass": "inlet",
                  "patching_rect": [
                    10,
                    625,
                    30,
                    30
                  ]
                }
              }
            ],
            "lines": [
              {
                "patchline": {
                  "source": [
                    "help-inlet",
                    0
                  ],
                  "destination": [
                    "help-web",
                    0
                  ]
                }
              }
            ]
          }
        }
      },
      {
        "box": {
          "id": "help-open",
          "varname": "help-open",
          "maxclass": "message",
          "patching_rect": [
            220,
            808,
            190,
            22
          ],
          "text": "open"
        }
      },
      {
        "box": {
          "id": "help-control",
          "varname": "help-control",
          "maxclass": "newobj",
          "patching_rect": [
            420,
            808,
            190,
            22
          ],
          "text": "pcontrol"
        }
      },
      {
        "box": {
          "id": "help-load",
          "varname": "help-load",
          "maxclass": "newobj",
          "patching_rect": [
            620,
            808,
            190,
            22
          ],
          "text": "js gesture_help_path.js"
        }
      },
      {
        "box": {
          "id": "audio-in",
          "varname": "audio-in",
          "maxclass": "newobj",
          "patching_rect": [
            820,
            808,
            190,
            22
          ],
          "text": "plugin~",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "signal",
            "signal"
          ]
        }
      },
      {
        "box": {
          "id": "audio-out",
          "varname": "audio-out",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            850,
            190,
            22
          ],
          "text": "plugout~",
          "numinlets": 2,
          "numoutlets": 0
        }
      }
    ],
    "lines": [
      {
        "patchline": {
          "source": [
            "mapping-pool",
            0
          ],
          "destination": [
            "mapping-pool-defer",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "mapping-pool-defer",
            0
          ],
          "destination": [
            "controller",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "mapping-panel",
            0
          ],
          "destination": [
            "mapping-route",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "mapping-route",
            0
          ],
          "destination": [
            "mapping-prefix",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "mapping-prefix",
            0
          ],
          "destination": [
            "mapping-defer",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "mapping-defer",
            0
          ],
          "destination": [
            "controller",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "classifier-train",
            0
          ],
          "destination": [
            "classifier-train-prefix",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "classifier-train",
            1
          ],
          "destination": [
            "classifier-train-prefix",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "classifier-train-prefix",
            0
          ],
          "destination": [
            "classifier-train-defer",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "classifier-train-defer",
            0
          ],
          "destination": [
            "controller",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "classifier-infer",
            0
          ],
          "destination": [
            "classifier-infer-prefix",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "classifier-infer",
            1
          ],
          "destination": [
            "classifier-infer-prefix",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "classifier-infer-prefix",
            0
          ],
          "destination": [
            "classifier-infer-defer",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "classifier-infer-defer",
            0
          ],
          "destination": [
            "controller",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "data-input",
            0
          ],
          "destination": [
            "data-input-prefix",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "data-input",
            1
          ],
          "destination": [
            "data-input-prefix",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "data-input-prefix",
            0
          ],
          "destination": [
            "data-input-defer",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "data-input-defer",
            0
          ],
          "destination": [
            "controller",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "data-labels",
            0
          ],
          "destination": [
            "data-labels-prefix",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "data-labels",
            1
          ],
          "destination": [
            "data-labels-prefix",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "data-labels-prefix",
            0
          ],
          "destination": [
            "data-labels-defer",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "data-labels-defer",
            0
          ],
          "destination": [
            "controller",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "receive-left",
            0
          ],
          "destination": [
            "prefix-left",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "prefix-left",
            0
          ],
          "destination": [
            "defer-left",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "defer-left",
            0
          ],
          "destination": [
            "controller",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "receive-right",
            0
          ],
          "destination": [
            "prefix-right",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "prefix-right",
            0
          ],
          "destination": [
            "defer-right",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "defer-right",
            0
          ],
          "destination": [
            "controller",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "controller",
            1
          ],
          "destination": [
            "event-route",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "event-route",
            0
          ],
          "destination": [
            "enter-route",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "enter-route",
            0
          ],
          "destination": [
            "enter-Left-prefix",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "enter-Left-prefix",
            0
          ],
          "destination": [
            "enter-Left-send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "enter-route",
            1
          ],
          "destination": [
            "enter-Right-prefix",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "enter-Right-prefix",
            0
          ],
          "destination": [
            "enter-Right-send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "enter-route",
            2
          ],
          "destination": [
            "enter-Both-prefix",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "enter-Both-prefix",
            0
          ],
          "destination": [
            "enter-Both-send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "event-route",
            1
          ],
          "destination": [
            "exit-route",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "exit-route",
            0
          ],
          "destination": [
            "exit-Left-prefix",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "exit-Left-prefix",
            0
          ],
          "destination": [
            "exit-Left-send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "exit-route",
            1
          ],
          "destination": [
            "exit-Right-prefix",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "exit-Right-prefix",
            0
          ],
          "destination": [
            "exit-Right-send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "exit-route",
            2
          ],
          "destination": [
            "exit-Both-prefix",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "exit-Both-prefix",
            0
          ],
          "destination": [
            "exit-Both-send",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "web",
            0
          ],
          "destination": [
            "route-ui",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "route-ui",
            0
          ],
          "destination": [
            "command-prefix",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "command-prefix",
            0
          ],
          "destination": [
            "defer-ui",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "defer-ui",
            0
          ],
          "destination": [
            "controller",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "controller",
            0
          ],
          "destination": [
            "web",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "controller",
            2
          ],
          "destination": [
            "bank",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "bank",
            0
          ],
          "destination": [
            "restore-prefix",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "restore-prefix",
            0
          ],
          "destination": [
            "restore-defer",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "restore-defer",
            0
          ],
          "destination": [
            "controller",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "host",
            0
          ],
          "destination": [
            "host-defer",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "host-defer",
            0
          ],
          "destination": [
            "controller",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "load",
            0
          ],
          "destination": [
            "load-defer",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "load-defer",
            0
          ],
          "destination": [
            "load-ui",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "load-ui",
            0
          ],
          "destination": [
            "controller",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "host",
            0
          ],
          "destination": [
            "query-colors",
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
            "query-colors",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "query-colors",
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
            "theme-prefix",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "theme-prefix",
            0
          ],
          "destination": [
            "theme-defer",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "theme-defer",
            0
          ],
          "destination": [
            "controller",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "controller",
            3
          ],
          "destination": [
            "dialog-route",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "dialog-route",
            0
          ],
          "destination": [
            "import-dialog",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "import-dialog",
            0
          ],
          "destination": [
            "import-prefix",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "import-prefix",
            0
          ],
          "destination": [
            "import-defer",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "import-defer",
            0
          ],
          "destination": [
            "controller",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "import-dialog",
            1
          ],
          "destination": [
            "import-cancel",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "import-cancel",
            0
          ],
          "destination": [
            "import-cancel-defer",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "import-cancel-defer",
            0
          ],
          "destination": [
            "controller",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "dialog-route",
            1
          ],
          "destination": [
            "export-dialog",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "export-dialog",
            0
          ],
          "destination": [
            "export-prefix",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "export-prefix",
            0
          ],
          "destination": [
            "export-defer",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "export-defer",
            0
          ],
          "destination": [
            "controller",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "export-dialog",
            1
          ],
          "destination": [
            "export-cancel",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "export-cancel",
            0
          ],
          "destination": [
            "export-cancel-defer",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "export-cancel-defer",
            0
          ],
          "destination": [
            "controller",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "dialog-route",
            3
          ],
          "destination": [
            "mapping-open",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "mapping-open",
            0
          ],
          "destination": [
            "mapping-control",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "mapping-control",
            0
          ],
          "destination": [
            "mapping-panel",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "dialog-route",
            2
          ],
          "destination": [
            "help-open",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "help-open",
            0
          ],
          "destination": [
            "help-control",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "help-control",
            0
          ],
          "destination": [
            "help",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "load-defer",
            0
          ],
          "destination": [
            "help-load",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "help-load",
            0
          ],
          "destination": [
            "help",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "audio-in",
            0
          ],
          "destination": [
            "audio-out",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "audio-in",
            1
          ],
          "destination": [
            "audio-out",
            1
          ]
        }
      }
    ],
    "parameters": {
      "bank": [
        "Glove Gesture Training Bank",
        "Gesture Bank",
        0
      ],
      "parameterbanks": {},
      "inherited_shortname": 1
    },
    "dependency_cache": [
      {
        "name": "fluid.mlpclassifier~.mxo",
        "type": "iLaX"
      },
      {
        "name": "fluid.dataset~.mxo",
        "type": "iLaX"
      },
      {
        "name": "fluid.labelset~.mxo",
        "type": "iLaX"
      },
      {
        "name": "gesture_control.js",
        "type": "TEXT",
        "implicit": 1
      },
      {
        "name": "gesture_ui.html",
        "type": "TEXT",
        "implicit": 1
      },
      {
        "name": "gesture_help.html",
        "type": "TEXT",
        "implicit": 1
      },
      {
        "name": "gesture_help_path.js",
        "type": "TEXT",
        "implicit": 1
      },
      {
        "name": "gesture_mapping.html",
        "type": "TEXT",
        "implicit": 1
      }
    ]
  }
}