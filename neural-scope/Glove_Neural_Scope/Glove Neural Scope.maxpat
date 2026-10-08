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
      70,
      70,
      1060,
      750
    ],
    "openinpresentation": 1,
    "openrect": [
      0,
      0,
      1060,
      169
    ],
    "devicewidth": 1060,
    "bgcolor": [
      0.09,
      0.11,
      0.115,
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
            1060,
            169
          ],
          "presentation": 1,
          "presentation_rect": [
            0,
            0,
            1060,
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
            185,
            220,
            155,
            22
          ],
          "text": "js neural_scope_control.js #0",
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
          "id": "mlp-train",
          "varname": "mlp-train",
          "maxclass": "newobj",
          "patching_rect": [
            350,
            220,
            155,
            22
          ],
          "text": "fluid.mlpregressor~ #0-glove-trainer @hiddenlayers 16 @activation 3 @outputactivation 0 @learnrate 0.01 @momentum 0.9 @batchsize 1 @validation 0 @maxiter 10",
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
          "id": "mlp-train-prefix",
          "varname": "mlp-train-prefix",
          "maxclass": "newobj",
          "patching_rect": [
            515,
            220,
            155,
            22
          ],
          "text": "prepend nativetrain"
        }
      },
      {
        "box": {
          "id": "mlp-train-defer",
          "varname": "mlp-train-defer",
          "maxclass": "newobj",
          "patching_rect": [
            680,
            220,
            155,
            22
          ],
          "text": "deferlow"
        }
      },
      {
        "box": {
          "id": "mlp-infer",
          "varname": "mlp-infer",
          "maxclass": "newobj",
          "patching_rect": [
            845,
            220,
            155,
            22
          ],
          "text": "fluid.mlpregressor~ #0-glove-inference",
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
          "id": "mlp-infer-prefix",
          "varname": "mlp-infer-prefix",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            264,
            155,
            22
          ],
          "text": "prepend nativeinfer"
        }
      },
      {
        "box": {
          "id": "mlp-infer-defer",
          "varname": "mlp-infer-defer",
          "maxclass": "newobj",
          "patching_rect": [
            185,
            264,
            155,
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
            350,
            264,
            155,
            22
          ],
          "text": "fluid.dataset~ #0-glove-x",
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
            515,
            264,
            155,
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
            680,
            264,
            155,
            22
          ],
          "text": "deferlow"
        }
      },
      {
        "box": {
          "id": "data-output",
          "varname": "data-output",
          "maxclass": "newobj",
          "patching_rect": [
            845,
            264,
            155,
            22
          ],
          "text": "fluid.dataset~ #0-glove-y",
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
          "id": "data-output-prefix",
          "varname": "data-output-prefix",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            308,
            155,
            22
          ],
          "text": "prepend nativeoutput"
        }
      },
      {
        "box": {
          "id": "data-output-defer",
          "varname": "data-output-defer",
          "maxclass": "newobj",
          "patching_rect": [
            185,
            308,
            155,
            22
          ],
          "text": "deferlow"
        }
      },
      {
        "box": {
          "id": "native-input-buffer",
          "varname": "native-input-buffer",
          "maxclass": "newobj",
          "patching_rect": [
            350,
            308,
            155,
            22
          ],
          "text": "buffer~ #0-glove-input @samps 5",
          "numinlets": 1,
          "numoutlets": 2
        }
      },
      {
        "box": {
          "id": "native-output-buffer",
          "varname": "native-output-buffer",
          "maxclass": "newobj",
          "patching_rect": [
            515,
            308,
            155,
            22
          ],
          "text": "buffer~ #0-glove-output @samps 1",
          "numinlets": 1,
          "numoutlets": 2
        }
      },
      {
        "box": {
          "id": "route-dialog",
          "varname": "route-dialog",
          "maxclass": "newobj",
          "patching_rect": [
            680,
            308,
            155,
            22
          ],
          "text": "route import export"
        }
      },
      {
        "box": {
          "id": "import-dialog",
          "varname": "import-dialog",
          "maxclass": "newobj",
          "patching_rect": [
            845,
            308,
            155,
            22
          ],
          "text": "opendialog .json",
          "numinlets": 1,
          "numoutlets": 2
        }
      },
      {
        "box": {
          "id": "import-path",
          "varname": "import-path",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            352,
            155,
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
            185,
            352,
            155,
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
            350,
            352,
            155,
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
            515,
            352,
            155,
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
            680,
            352,
            155,
            22
          ],
          "text": "savedialog",
          "numinlets": 1,
          "numoutlets": 2
        }
      },
      {
        "box": {
          "id": "export-path",
          "varname": "export-path",
          "maxclass": "newobj",
          "patching_rect": [
            845,
            352,
            155,
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
            396,
            155,
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
            185,
            396,
            155,
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
            350,
            396,
            155,
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
            515,
            396,
            155,
            22
          ],
          "text": "pattr neural_bank",
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
              "parameter_longname": "Glove Neural Training Bank",
              "parameter_shortname": "Training Bank",
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
            680,
            396,
            155,
            22
          ],
          "text": "prepend restore"
        }
      },
      {
        "box": {
          "id": "defer-restore",
          "varname": "defer-restore",
          "maxclass": "newobj",
          "patching_rect": [
            845,
            396,
            155,
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
            20,
            440,
            155,
            22
          ],
          "text": "live.thisdevice"
        }
      },
      {
        "box": {
          "id": "defer-host",
          "varname": "defer-host",
          "maxclass": "newobj",
          "patching_rect": [
            185,
            440,
            155,
            22
          ],
          "text": "deferlow"
        }
      },
      {
        "box": {
          "id": "colors",
          "varname": "colors",
          "maxclass": "newobj",
          "patching_rect": [
            350,
            440,
            155,
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
            515,
            440,
            155,
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
            680,
            440,
            155,
            22
          ],
          "text": "prepend theme"
        }
      },
      {
        "box": {
          "id": "defer-theme",
          "varname": "defer-theme",
          "maxclass": "newobj",
          "patching_rect": [
            845,
            440,
            155,
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
            484,
            155,
            22
          ],
          "text": "loadbang"
        }
      },
      {
        "box": {
          "id": "defer-load",
          "varname": "defer-load",
          "maxclass": "newobj",
          "patching_rect": [
            185,
            484,
            155,
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
            350,
            484,
            155,
            22
          ],
          "text": "loadbang"
        }
      },
      {
        "box": {
          "id": "route-ui",
          "varname": "route-ui",
          "maxclass": "newobj",
          "patching_rect": [
            515,
            484,
            155,
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
            680,
            484,
            155,
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
            845,
            484,
            155,
            22
          ],
          "text": "deferlow"
        }
      },
      {
        "box": {
          "id": "receive-left",
          "varname": "receive-left",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            528,
            155,
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
            185,
            528,
            155,
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
            350,
            528,
            155,
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
            515,
            528,
            155,
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
            680,
            528,
            155,
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
            845,
            528,
            155,
            22
          ],
          "text": "deferlow"
        }
      },
      {
        "box": {
          "id": "to-editor",
          "varname": "to-editor",
          "maxclass": "newobj",
          "patching_rect": [
            20,
            572,
            155,
            22
          ],
          "text": "s ---glove-neural-state"
        }
      },
      {
        "box": {
          "id": "from-editor",
          "varname": "from-editor",
          "maxclass": "newobj",
          "patching_rect": [
            185,
            572,
            155,
            22
          ],
          "text": "r ---glove-neural-command"
        }
      },
      {
        "box": {
          "id": "editor",
          "varname": "editor",
          "maxclass": "newobj",
          "patching_rect": [
            350,
            572,
            155,
            22
          ],
          "text": "p Glove_Neural_Editor",
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
              1060,
              650
            ],
            "openinpresentation": 1,
            "bgcolor": [
              0.09,
              0.11,
              0.115,
              1
            ],
            "boxes": [
              {
                "box": {
                  "id": "in",
                  "maxclass": "inlet",
                  "patching_rect": [
                    450,
                    670,
                    30,
                    30
                  ]
                }
              },
              {
                "box": {
                  "id": "editor-web",
                  "varname": "editor_web",
                  "maxclass": "jweb",
                  "patching_rect": [
                    0,
                    0,
                    1060,
                    650
                  ],
                  "presentation": 1,
                  "presentation_rect": [
                    0,
                    0,
                    1060,
                    650
                  ],
                  "numinlets": 1,
                  "numoutlets": 1,
                  "rendermode": 1
                }
              },
              {
                "box": {
                  "id": "receive",
                  "maxclass": "newobj",
                  "text": "r ---glove-neural-state",
                  "patching_rect": [
                    20,
                    670,
                    180,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "send",
                  "maxclass": "newobj",
                  "text": "s ---glove-neural-command",
                  "patching_rect": [
                    210,
                    670,
                    190,
                    22
                  ]
                }
              }
            ],
            "lines": [
              {
                "patchline": {
                  "source": [
                    "receive",
                    0
                  ],
                  "destination": [
                    "editor-web",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "editor-web",
                    0
                  ],
                  "destination": [
                    "send",
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
          "id": "editor-control",
          "varname": "editor-control",
          "maxclass": "newobj",
          "patching_rect": [
            515,
            572,
            155,
            22
          ],
          "text": "pcontrol"
        }
      },
      {
        "box": {
          "id": "remote-pool",
          "varname": "remote-pool",
          "maxclass": "newobj",
          "patching_rect": [
            680,
            572,
            155,
            22
          ],
          "text": "p remote_pool",
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
                  "id": "remote-0",
                  "varname": "remote-0",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    20,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-0",
                  "varname": "sender-0",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    46,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-1",
                  "varname": "remote-1",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    20,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-1",
                  "varname": "sender-1",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    46,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-2",
                  "varname": "remote-2",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    20,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-2",
                  "varname": "sender-2",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    46,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-3",
                  "varname": "remote-3",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    20,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-3",
                  "varname": "sender-3",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    46,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-4",
                  "varname": "remote-4",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    90,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-4",
                  "varname": "sender-4",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    116,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-5",
                  "varname": "remote-5",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    90,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-5",
                  "varname": "sender-5",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    116,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-6",
                  "varname": "remote-6",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    90,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-6",
                  "varname": "sender-6",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    116,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-7",
                  "varname": "remote-7",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    90,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-7",
                  "varname": "sender-7",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    116,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-8",
                  "varname": "remote-8",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    160,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-8",
                  "varname": "sender-8",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    186,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-9",
                  "varname": "remote-9",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    160,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-9",
                  "varname": "sender-9",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    186,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-10",
                  "varname": "remote-10",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    160,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-10",
                  "varname": "sender-10",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    186,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-11",
                  "varname": "remote-11",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    160,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-11",
                  "varname": "sender-11",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    186,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-12",
                  "varname": "remote-12",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    230,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-12",
                  "varname": "sender-12",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    256,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-13",
                  "varname": "remote-13",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    230,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-13",
                  "varname": "sender-13",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    256,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-14",
                  "varname": "remote-14",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    230,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-14",
                  "varname": "sender-14",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    256,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-15",
                  "varname": "remote-15",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    230,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-15",
                  "varname": "sender-15",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    256,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-16",
                  "varname": "remote-16",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    300,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-16",
                  "varname": "sender-16",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    326,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-17",
                  "varname": "remote-17",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    300,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-17",
                  "varname": "sender-17",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    326,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-18",
                  "varname": "remote-18",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    300,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-18",
                  "varname": "sender-18",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    326,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-19",
                  "varname": "remote-19",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    300,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-19",
                  "varname": "sender-19",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    326,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-20",
                  "varname": "remote-20",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    370,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-20",
                  "varname": "sender-20",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    396,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-21",
                  "varname": "remote-21",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    370,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-21",
                  "varname": "sender-21",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    396,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-22",
                  "varname": "remote-22",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    370,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-22",
                  "varname": "sender-22",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    396,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-23",
                  "varname": "remote-23",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    370,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-23",
                  "varname": "sender-23",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    396,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-24",
                  "varname": "remote-24",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    440,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-24",
                  "varname": "sender-24",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    466,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-25",
                  "varname": "remote-25",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    440,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-25",
                  "varname": "sender-25",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    466,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-26",
                  "varname": "remote-26",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    440,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-26",
                  "varname": "sender-26",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    466,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-27",
                  "varname": "remote-27",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    440,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-27",
                  "varname": "sender-27",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    466,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-28",
                  "varname": "remote-28",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    510,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-28",
                  "varname": "sender-28",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    536,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-29",
                  "varname": "remote-29",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    510,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-29",
                  "varname": "sender-29",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    536,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-30",
                  "varname": "remote-30",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    510,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-30",
                  "varname": "sender-30",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    536,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-31",
                  "varname": "remote-31",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    510,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-31",
                  "varname": "sender-31",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    536,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-32",
                  "varname": "remote-32",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    580,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-32",
                  "varname": "sender-32",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    606,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-33",
                  "varname": "remote-33",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    580,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-33",
                  "varname": "sender-33",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    606,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-34",
                  "varname": "remote-34",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    580,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-34",
                  "varname": "sender-34",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    606,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-35",
                  "varname": "remote-35",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    580,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-35",
                  "varname": "sender-35",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    606,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-36",
                  "varname": "remote-36",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    650,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-36",
                  "varname": "sender-36",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    676,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-37",
                  "varname": "remote-37",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    650,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-37",
                  "varname": "sender-37",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    676,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-38",
                  "varname": "remote-38",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    650,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-38",
                  "varname": "sender-38",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    676,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-39",
                  "varname": "remote-39",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    650,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-39",
                  "varname": "sender-39",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    676,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-40",
                  "varname": "remote-40",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    720,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-40",
                  "varname": "sender-40",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    746,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-41",
                  "varname": "remote-41",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    720,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-41",
                  "varname": "sender-41",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    746,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-42",
                  "varname": "remote-42",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    720,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-42",
                  "varname": "sender-42",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    746,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-43",
                  "varname": "remote-43",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    720,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-43",
                  "varname": "sender-43",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    746,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-44",
                  "varname": "remote-44",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    790,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-44",
                  "varname": "sender-44",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    816,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-45",
                  "varname": "remote-45",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    790,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-45",
                  "varname": "sender-45",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    816,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-46",
                  "varname": "remote-46",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    790,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-46",
                  "varname": "sender-46",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    816,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-47",
                  "varname": "remote-47",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    790,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-47",
                  "varname": "sender-47",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    816,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-48",
                  "varname": "remote-48",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    860,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-48",
                  "varname": "sender-48",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    886,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-49",
                  "varname": "remote-49",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    860,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-49",
                  "varname": "sender-49",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    886,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-50",
                  "varname": "remote-50",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    860,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-50",
                  "varname": "sender-50",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    886,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-51",
                  "varname": "remote-51",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    860,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-51",
                  "varname": "sender-51",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    886,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-52",
                  "varname": "remote-52",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    930,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-52",
                  "varname": "sender-52",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    956,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-53",
                  "varname": "remote-53",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    930,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-53",
                  "varname": "sender-53",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    956,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-54",
                  "varname": "remote-54",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    930,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-54",
                  "varname": "sender-54",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    956,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-55",
                  "varname": "remote-55",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    930,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-55",
                  "varname": "sender-55",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    956,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-56",
                  "varname": "remote-56",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    1000,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-56",
                  "varname": "sender-56",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    1026,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-57",
                  "varname": "remote-57",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    1000,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-57",
                  "varname": "sender-57",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    1026,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-58",
                  "varname": "remote-58",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    1000,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-58",
                  "varname": "sender-58",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    1026,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-59",
                  "varname": "remote-59",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    1000,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-59",
                  "varname": "sender-59",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    1026,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-60",
                  "varname": "remote-60",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    1070,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-60",
                  "varname": "sender-60",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    1096,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-61",
                  "varname": "remote-61",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    1070,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-61",
                  "varname": "sender-61",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    1096,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-62",
                  "varname": "remote-62",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    1070,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-62",
                  "varname": "sender-62",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    1096,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-63",
                  "varname": "remote-63",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    1070,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-63",
                  "varname": "sender-63",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    1096,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-64",
                  "varname": "remote-64",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    1140,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-64",
                  "varname": "sender-64",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    1166,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-65",
                  "varname": "remote-65",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    1140,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-65",
                  "varname": "sender-65",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    1166,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-66",
                  "varname": "remote-66",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    1140,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-66",
                  "varname": "sender-66",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    1166,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-67",
                  "varname": "remote-67",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    1140,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-67",
                  "varname": "sender-67",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    1166,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-68",
                  "varname": "remote-68",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    1210,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-68",
                  "varname": "sender-68",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    1236,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-69",
                  "varname": "remote-69",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    1210,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-69",
                  "varname": "sender-69",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    1236,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-70",
                  "varname": "remote-70",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    1210,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-70",
                  "varname": "sender-70",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    1236,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-71",
                  "varname": "remote-71",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    1210,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-71",
                  "varname": "sender-71",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    1236,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-72",
                  "varname": "remote-72",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    1280,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-72",
                  "varname": "sender-72",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    1306,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-73",
                  "varname": "remote-73",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    1280,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-73",
                  "varname": "sender-73",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    1306,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-74",
                  "varname": "remote-74",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    1280,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-74",
                  "varname": "sender-74",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    1306,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-75",
                  "varname": "remote-75",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    1280,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-75",
                  "varname": "sender-75",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    1306,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-76",
                  "varname": "remote-76",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    1350,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-76",
                  "varname": "sender-76",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    1376,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-77",
                  "varname": "remote-77",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    1350,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-77",
                  "varname": "sender-77",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    1376,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-78",
                  "varname": "remote-78",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    1350,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-78",
                  "varname": "sender-78",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    1376,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-79",
                  "varname": "remote-79",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    1350,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-79",
                  "varname": "sender-79",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    1376,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-80",
                  "varname": "remote-80",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    1420,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-80",
                  "varname": "sender-80",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    1446,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-81",
                  "varname": "remote-81",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    1420,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-81",
                  "varname": "sender-81",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    1446,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-82",
                  "varname": "remote-82",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    1420,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-82",
                  "varname": "sender-82",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    1446,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-83",
                  "varname": "remote-83",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    1420,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-83",
                  "varname": "sender-83",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    1446,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-84",
                  "varname": "remote-84",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    1490,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-84",
                  "varname": "sender-84",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    1516,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-85",
                  "varname": "remote-85",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    1490,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-85",
                  "varname": "sender-85",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    1516,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-86",
                  "varname": "remote-86",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    1490,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-86",
                  "varname": "sender-86",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    1516,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-87",
                  "varname": "remote-87",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    1490,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-87",
                  "varname": "sender-87",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    1516,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-88",
                  "varname": "remote-88",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    1560,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-88",
                  "varname": "sender-88",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    1586,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-89",
                  "varname": "remote-89",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    1560,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-89",
                  "varname": "sender-89",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    1586,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-90",
                  "varname": "remote-90",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    1560,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-90",
                  "varname": "sender-90",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    1586,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-91",
                  "varname": "remote-91",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    1560,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-91",
                  "varname": "sender-91",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    1586,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-92",
                  "varname": "remote-92",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    1630,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-92",
                  "varname": "sender-92",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    1656,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-93",
                  "varname": "remote-93",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    1630,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-93",
                  "varname": "sender-93",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    1656,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-94",
                  "varname": "remote-94",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    1630,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-94",
                  "varname": "sender-94",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    1656,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-95",
                  "varname": "remote-95",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    1630,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-95",
                  "varname": "sender-95",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    1656,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-96",
                  "varname": "remote-96",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    1700,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-96",
                  "varname": "sender-96",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    1726,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-97",
                  "varname": "remote-97",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    1700,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-97",
                  "varname": "sender-97",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    1726,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-98",
                  "varname": "remote-98",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    1700,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-98",
                  "varname": "sender-98",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    1726,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-99",
                  "varname": "remote-99",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    1700,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-99",
                  "varname": "sender-99",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    1726,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-100",
                  "varname": "remote-100",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    1770,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-100",
                  "varname": "sender-100",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    1796,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-101",
                  "varname": "remote-101",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    1770,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-101",
                  "varname": "sender-101",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    1796,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-102",
                  "varname": "remote-102",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    1770,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-102",
                  "varname": "sender-102",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    1796,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-103",
                  "varname": "remote-103",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    1770,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-103",
                  "varname": "sender-103",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    1796,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-104",
                  "varname": "remote-104",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    1840,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-104",
                  "varname": "sender-104",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    1866,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-105",
                  "varname": "remote-105",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    1840,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-105",
                  "varname": "sender-105",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    1866,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-106",
                  "varname": "remote-106",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    1840,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-106",
                  "varname": "sender-106",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    1866,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-107",
                  "varname": "remote-107",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    1840,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-107",
                  "varname": "sender-107",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    1866,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-108",
                  "varname": "remote-108",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    1910,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-108",
                  "varname": "sender-108",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    1936,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-109",
                  "varname": "remote-109",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    1910,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-109",
                  "varname": "sender-109",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    1936,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-110",
                  "varname": "remote-110",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    1910,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-110",
                  "varname": "sender-110",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    1936,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-111",
                  "varname": "remote-111",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    1910,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-111",
                  "varname": "sender-111",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    1936,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-112",
                  "varname": "remote-112",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    1980,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-112",
                  "varname": "sender-112",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    2006,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-113",
                  "varname": "remote-113",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    1980,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-113",
                  "varname": "sender-113",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    2006,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-114",
                  "varname": "remote-114",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    1980,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-114",
                  "varname": "sender-114",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    2006,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-115",
                  "varname": "remote-115",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    1980,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-115",
                  "varname": "sender-115",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    2006,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-116",
                  "varname": "remote-116",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    2050,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-116",
                  "varname": "sender-116",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    2076,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-117",
                  "varname": "remote-117",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    2050,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-117",
                  "varname": "sender-117",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    2076,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-118",
                  "varname": "remote-118",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    2050,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-118",
                  "varname": "sender-118",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    2076,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-119",
                  "varname": "remote-119",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    2050,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-119",
                  "varname": "sender-119",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    2076,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-120",
                  "varname": "remote-120",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    2120,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-120",
                  "varname": "sender-120",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    2146,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-121",
                  "varname": "remote-121",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    2120,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-121",
                  "varname": "sender-121",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    2146,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-122",
                  "varname": "remote-122",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    2120,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-122",
                  "varname": "sender-122",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    2146,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-123",
                  "varname": "remote-123",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    2120,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-123",
                  "varname": "sender-123",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    2146,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-124",
                  "varname": "remote-124",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    2190,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-124",
                  "varname": "sender-124",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    2216,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-125",
                  "varname": "remote-125",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    2190,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-125",
                  "varname": "sender-125",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    2216,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-126",
                  "varname": "remote-126",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    2190,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-126",
                  "varname": "sender-126",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    2216,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-127",
                  "varname": "remote-127",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    2190,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-127",
                  "varname": "sender-127",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    2216,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-128",
                  "varname": "remote-128",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    2260,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-128",
                  "varname": "sender-128",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    2286,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-129",
                  "varname": "remote-129",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    2260,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-129",
                  "varname": "sender-129",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    2286,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-130",
                  "varname": "remote-130",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    2260,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-130",
                  "varname": "sender-130",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    2286,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-131",
                  "varname": "remote-131",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    2260,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-131",
                  "varname": "sender-131",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    2286,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-132",
                  "varname": "remote-132",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    2330,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-132",
                  "varname": "sender-132",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    2356,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-133",
                  "varname": "remote-133",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    2330,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-133",
                  "varname": "sender-133",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    2356,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-134",
                  "varname": "remote-134",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    2330,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-134",
                  "varname": "sender-134",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    2356,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-135",
                  "varname": "remote-135",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    2330,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-135",
                  "varname": "sender-135",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    2356,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-136",
                  "varname": "remote-136",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    2400,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-136",
                  "varname": "sender-136",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    2426,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-137",
                  "varname": "remote-137",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    2400,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-137",
                  "varname": "sender-137",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    2426,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-138",
                  "varname": "remote-138",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    2400,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-138",
                  "varname": "sender-138",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    2426,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-139",
                  "varname": "remote-139",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    2400,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-139",
                  "varname": "sender-139",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    2426,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-140",
                  "varname": "remote-140",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    2470,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-140",
                  "varname": "sender-140",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    2496,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-141",
                  "varname": "remote-141",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    2470,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-141",
                  "varname": "sender-141",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    2496,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-142",
                  "varname": "remote-142",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    2470,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-142",
                  "varname": "sender-142",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    2496,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-143",
                  "varname": "remote-143",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    2470,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-143",
                  "varname": "sender-143",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    2496,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-144",
                  "varname": "remote-144",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    2540,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-144",
                  "varname": "sender-144",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    2566,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-145",
                  "varname": "remote-145",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    2540,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-145",
                  "varname": "sender-145",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    2566,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-146",
                  "varname": "remote-146",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    2540,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-146",
                  "varname": "sender-146",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    2566,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-147",
                  "varname": "remote-147",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    2540,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-147",
                  "varname": "sender-147",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    2566,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-148",
                  "varname": "remote-148",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    2610,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-148",
                  "varname": "sender-148",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    2636,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-149",
                  "varname": "remote-149",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    2610,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-149",
                  "varname": "sender-149",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    2636,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-150",
                  "varname": "remote-150",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    2610,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-150",
                  "varname": "sender-150",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    2636,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-151",
                  "varname": "remote-151",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    2610,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-151",
                  "varname": "sender-151",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    2636,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-152",
                  "varname": "remote-152",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    2680,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-152",
                  "varname": "sender-152",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    2706,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-153",
                  "varname": "remote-153",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    2680,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-153",
                  "varname": "sender-153",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    2706,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-154",
                  "varname": "remote-154",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    2680,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-154",
                  "varname": "sender-154",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    2706,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-155",
                  "varname": "remote-155",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    2680,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-155",
                  "varname": "sender-155",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    2706,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-156",
                  "varname": "remote-156",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    2750,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-156",
                  "varname": "sender-156",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    2776,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-157",
                  "varname": "remote-157",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    2750,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-157",
                  "varname": "sender-157",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    2776,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-158",
                  "varname": "remote-158",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    2750,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-158",
                  "varname": "sender-158",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    2776,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-159",
                  "varname": "remote-159",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    2750,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-159",
                  "varname": "sender-159",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    2776,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-160",
                  "varname": "remote-160",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    2820,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-160",
                  "varname": "sender-160",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    2846,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-161",
                  "varname": "remote-161",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    2820,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-161",
                  "varname": "sender-161",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    2846,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-162",
                  "varname": "remote-162",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    2820,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-162",
                  "varname": "sender-162",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    2846,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-163",
                  "varname": "remote-163",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    2820,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-163",
                  "varname": "sender-163",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    2846,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-164",
                  "varname": "remote-164",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    2890,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-164",
                  "varname": "sender-164",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    2916,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-165",
                  "varname": "remote-165",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    2890,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-165",
                  "varname": "sender-165",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    2916,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-166",
                  "varname": "remote-166",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    2890,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-166",
                  "varname": "sender-166",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    2916,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-167",
                  "varname": "remote-167",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    2890,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-167",
                  "varname": "sender-167",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    2916,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-168",
                  "varname": "remote-168",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    2960,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-168",
                  "varname": "sender-168",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    2986,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-169",
                  "varname": "remote-169",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    2960,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-169",
                  "varname": "sender-169",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    2986,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-170",
                  "varname": "remote-170",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    2960,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-170",
                  "varname": "sender-170",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    2986,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-171",
                  "varname": "remote-171",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    2960,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-171",
                  "varname": "sender-171",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    2986,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-172",
                  "varname": "remote-172",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    3030,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-172",
                  "varname": "sender-172",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    3056,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-173",
                  "varname": "remote-173",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    3030,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-173",
                  "varname": "sender-173",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    3056,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-174",
                  "varname": "remote-174",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    3030,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-174",
                  "varname": "sender-174",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    3056,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-175",
                  "varname": "remote-175",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    3030,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-175",
                  "varname": "sender-175",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    3056,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-176",
                  "varname": "remote-176",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    3100,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-176",
                  "varname": "sender-176",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    3126,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-177",
                  "varname": "remote-177",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    3100,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-177",
                  "varname": "sender-177",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    3126,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-178",
                  "varname": "remote-178",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    3100,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-178",
                  "varname": "sender-178",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    3126,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-179",
                  "varname": "remote-179",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    3100,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-179",
                  "varname": "sender-179",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    3126,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-180",
                  "varname": "remote-180",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    3170,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-180",
                  "varname": "sender-180",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    3196,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-181",
                  "varname": "remote-181",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    3170,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-181",
                  "varname": "sender-181",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    3196,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-182",
                  "varname": "remote-182",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    3170,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-182",
                  "varname": "sender-182",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    3196,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-183",
                  "varname": "remote-183",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    3170,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-183",
                  "varname": "sender-183",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    3196,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-184",
                  "varname": "remote-184",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    3240,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-184",
                  "varname": "sender-184",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    3266,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-185",
                  "varname": "remote-185",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    3240,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-185",
                  "varname": "sender-185",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    3266,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-186",
                  "varname": "remote-186",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    3240,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-186",
                  "varname": "sender-186",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    3266,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-187",
                  "varname": "remote-187",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    3240,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-187",
                  "varname": "sender-187",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    3266,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-188",
                  "varname": "remote-188",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    3310,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-188",
                  "varname": "sender-188",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    3336,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-189",
                  "varname": "remote-189",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    3310,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-189",
                  "varname": "sender-189",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    3336,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-190",
                  "varname": "remote-190",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    3310,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-190",
                  "varname": "sender-190",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    3336,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-191",
                  "varname": "remote-191",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    3310,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-191",
                  "varname": "sender-191",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    3336,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-192",
                  "varname": "remote-192",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    3380,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-192",
                  "varname": "sender-192",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    3406,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-193",
                  "varname": "remote-193",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    3380,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-193",
                  "varname": "sender-193",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    3406,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-194",
                  "varname": "remote-194",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    3380,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-194",
                  "varname": "sender-194",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    3406,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-195",
                  "varname": "remote-195",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    3380,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-195",
                  "varname": "sender-195",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    3406,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-196",
                  "varname": "remote-196",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    3450,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-196",
                  "varname": "sender-196",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    3476,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-197",
                  "varname": "remote-197",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    3450,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-197",
                  "varname": "sender-197",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    3476,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-198",
                  "varname": "remote-198",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    3450,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-198",
                  "varname": "sender-198",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    3476,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-199",
                  "varname": "remote-199",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    3450,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-199",
                  "varname": "sender-199",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    3476,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-200",
                  "varname": "remote-200",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    3520,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-200",
                  "varname": "sender-200",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    3546,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-201",
                  "varname": "remote-201",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    3520,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-201",
                  "varname": "sender-201",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    3546,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-202",
                  "varname": "remote-202",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    3520,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-202",
                  "varname": "sender-202",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    3546,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-203",
                  "varname": "remote-203",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    3520,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-203",
                  "varname": "sender-203",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    3546,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-204",
                  "varname": "remote-204",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    3590,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-204",
                  "varname": "sender-204",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    3616,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-205",
                  "varname": "remote-205",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    3590,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-205",
                  "varname": "sender-205",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    3616,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-206",
                  "varname": "remote-206",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    3590,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-206",
                  "varname": "sender-206",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    3616,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-207",
                  "varname": "remote-207",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    3590,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-207",
                  "varname": "sender-207",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    3616,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-208",
                  "varname": "remote-208",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    3660,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-208",
                  "varname": "sender-208",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    3686,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-209",
                  "varname": "remote-209",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    3660,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-209",
                  "varname": "sender-209",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    3686,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-210",
                  "varname": "remote-210",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    3660,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-210",
                  "varname": "sender-210",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    3686,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-211",
                  "varname": "remote-211",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    3660,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-211",
                  "varname": "sender-211",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    3686,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-212",
                  "varname": "remote-212",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    3730,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-212",
                  "varname": "sender-212",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    3756,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-213",
                  "varname": "remote-213",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    3730,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-213",
                  "varname": "sender-213",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    3756,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-214",
                  "varname": "remote-214",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    3730,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-214",
                  "varname": "sender-214",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    3756,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-215",
                  "varname": "remote-215",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    3730,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-215",
                  "varname": "sender-215",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    3756,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-216",
                  "varname": "remote-216",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    3800,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-216",
                  "varname": "sender-216",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    3826,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-217",
                  "varname": "remote-217",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    3800,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-217",
                  "varname": "sender-217",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    3826,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-218",
                  "varname": "remote-218",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    3800,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-218",
                  "varname": "sender-218",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    3826,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-219",
                  "varname": "remote-219",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    3800,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-219",
                  "varname": "sender-219",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    3826,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-220",
                  "varname": "remote-220",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    3870,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-220",
                  "varname": "sender-220",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    3896,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-221",
                  "varname": "remote-221",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    3870,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-221",
                  "varname": "sender-221",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    3896,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-222",
                  "varname": "remote-222",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    3870,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-222",
                  "varname": "sender-222",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    3896,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-223",
                  "varname": "remote-223",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    3870,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-223",
                  "varname": "sender-223",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    3896,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-224",
                  "varname": "remote-224",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    3940,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-224",
                  "varname": "sender-224",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    3966,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-225",
                  "varname": "remote-225",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    3940,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-225",
                  "varname": "sender-225",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    3966,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-226",
                  "varname": "remote-226",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    3940,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-226",
                  "varname": "sender-226",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    3966,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-227",
                  "varname": "remote-227",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    3940,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-227",
                  "varname": "sender-227",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    3966,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-228",
                  "varname": "remote-228",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    4010,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-228",
                  "varname": "sender-228",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    4036,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-229",
                  "varname": "remote-229",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    4010,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-229",
                  "varname": "sender-229",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    4036,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-230",
                  "varname": "remote-230",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    4010,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-230",
                  "varname": "sender-230",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    4036,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-231",
                  "varname": "remote-231",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    4010,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-231",
                  "varname": "sender-231",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    4036,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-232",
                  "varname": "remote-232",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    4080,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-232",
                  "varname": "sender-232",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    4106,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-233",
                  "varname": "remote-233",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    4080,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-233",
                  "varname": "sender-233",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    4106,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-234",
                  "varname": "remote-234",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    4080,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-234",
                  "varname": "sender-234",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    4106,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-235",
                  "varname": "remote-235",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    4080,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-235",
                  "varname": "sender-235",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    4106,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-236",
                  "varname": "remote-236",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    4150,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-236",
                  "varname": "sender-236",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    4176,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-237",
                  "varname": "remote-237",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    4150,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-237",
                  "varname": "sender-237",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    4176,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-238",
                  "varname": "remote-238",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    4150,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-238",
                  "varname": "sender-238",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    4176,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-239",
                  "varname": "remote-239",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    4150,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-239",
                  "varname": "sender-239",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    4176,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-240",
                  "varname": "remote-240",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    4220,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-240",
                  "varname": "sender-240",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    4246,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-241",
                  "varname": "remote-241",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    4220,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-241",
                  "varname": "sender-241",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    4246,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-242",
                  "varname": "remote-242",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    4220,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-242",
                  "varname": "sender-242",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    4246,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-243",
                  "varname": "remote-243",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    4220,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-243",
                  "varname": "sender-243",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    4246,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-244",
                  "varname": "remote-244",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    4290,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-244",
                  "varname": "sender-244",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    4316,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-245",
                  "varname": "remote-245",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    4290,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-245",
                  "varname": "sender-245",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    4316,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-246",
                  "varname": "remote-246",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    4290,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-246",
                  "varname": "sender-246",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    4316,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-247",
                  "varname": "remote-247",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    4290,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-247",
                  "varname": "sender-247",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    4316,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-248",
                  "varname": "remote-248",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    4360,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-248",
                  "varname": "sender-248",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    4386,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-249",
                  "varname": "remote-249",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    4360,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-249",
                  "varname": "sender-249",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    4386,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-250",
                  "varname": "remote-250",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    4360,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-250",
                  "varname": "sender-250",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    4386,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-251",
                  "varname": "remote-251",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    4360,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-251",
                  "varname": "sender-251",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    4386,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-252",
                  "varname": "remote-252",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    20,
                    4430,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-252",
                  "varname": "sender-252",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    20,
                    4456,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-253",
                  "varname": "remote-253",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    240,
                    4430,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-253",
                  "varname": "sender-253",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    240,
                    4456,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-254",
                  "varname": "remote-254",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    460,
                    4430,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-254",
                  "varname": "sender-254",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    460,
                    4456,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "remote-255",
                  "varname": "remote-255",
                  "maxclass": "newobj",
                  "text": "live.remote~ @normalized 0 @smoothing 30",
                  "patching_rect": [
                    680,
                    4430,
                    210,
                    22
                  ],
                  "numinlets": 2,
                  "numoutlets": 1
                }
              },
              {
                "box": {
                  "id": "sender-255",
                  "varname": "sender-255",
                  "maxclass": "newobj",
                  "text": "prepend id",
                  "patching_rect": [
                    680,
                    4456,
                    100,
                    22
                  ],
                  "numinlets": 1,
                  "numoutlets": 1
                }
              }
            ],
            "lines": [
              {
                "patchline": {
                  "source": [
                    "sender-0",
                    0
                  ],
                  "destination": [
                    "remote-0",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-1",
                    0
                  ],
                  "destination": [
                    "remote-1",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-2",
                    0
                  ],
                  "destination": [
                    "remote-2",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-3",
                    0
                  ],
                  "destination": [
                    "remote-3",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-4",
                    0
                  ],
                  "destination": [
                    "remote-4",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-5",
                    0
                  ],
                  "destination": [
                    "remote-5",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-6",
                    0
                  ],
                  "destination": [
                    "remote-6",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-7",
                    0
                  ],
                  "destination": [
                    "remote-7",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-8",
                    0
                  ],
                  "destination": [
                    "remote-8",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-9",
                    0
                  ],
                  "destination": [
                    "remote-9",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-10",
                    0
                  ],
                  "destination": [
                    "remote-10",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-11",
                    0
                  ],
                  "destination": [
                    "remote-11",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-12",
                    0
                  ],
                  "destination": [
                    "remote-12",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-13",
                    0
                  ],
                  "destination": [
                    "remote-13",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-14",
                    0
                  ],
                  "destination": [
                    "remote-14",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-15",
                    0
                  ],
                  "destination": [
                    "remote-15",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-16",
                    0
                  ],
                  "destination": [
                    "remote-16",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-17",
                    0
                  ],
                  "destination": [
                    "remote-17",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-18",
                    0
                  ],
                  "destination": [
                    "remote-18",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-19",
                    0
                  ],
                  "destination": [
                    "remote-19",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-20",
                    0
                  ],
                  "destination": [
                    "remote-20",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-21",
                    0
                  ],
                  "destination": [
                    "remote-21",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-22",
                    0
                  ],
                  "destination": [
                    "remote-22",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-23",
                    0
                  ],
                  "destination": [
                    "remote-23",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-24",
                    0
                  ],
                  "destination": [
                    "remote-24",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-25",
                    0
                  ],
                  "destination": [
                    "remote-25",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-26",
                    0
                  ],
                  "destination": [
                    "remote-26",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-27",
                    0
                  ],
                  "destination": [
                    "remote-27",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-28",
                    0
                  ],
                  "destination": [
                    "remote-28",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-29",
                    0
                  ],
                  "destination": [
                    "remote-29",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-30",
                    0
                  ],
                  "destination": [
                    "remote-30",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-31",
                    0
                  ],
                  "destination": [
                    "remote-31",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-32",
                    0
                  ],
                  "destination": [
                    "remote-32",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-33",
                    0
                  ],
                  "destination": [
                    "remote-33",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-34",
                    0
                  ],
                  "destination": [
                    "remote-34",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-35",
                    0
                  ],
                  "destination": [
                    "remote-35",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-36",
                    0
                  ],
                  "destination": [
                    "remote-36",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-37",
                    0
                  ],
                  "destination": [
                    "remote-37",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-38",
                    0
                  ],
                  "destination": [
                    "remote-38",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-39",
                    0
                  ],
                  "destination": [
                    "remote-39",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-40",
                    0
                  ],
                  "destination": [
                    "remote-40",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-41",
                    0
                  ],
                  "destination": [
                    "remote-41",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-42",
                    0
                  ],
                  "destination": [
                    "remote-42",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-43",
                    0
                  ],
                  "destination": [
                    "remote-43",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-44",
                    0
                  ],
                  "destination": [
                    "remote-44",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-45",
                    0
                  ],
                  "destination": [
                    "remote-45",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-46",
                    0
                  ],
                  "destination": [
                    "remote-46",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-47",
                    0
                  ],
                  "destination": [
                    "remote-47",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-48",
                    0
                  ],
                  "destination": [
                    "remote-48",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-49",
                    0
                  ],
                  "destination": [
                    "remote-49",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-50",
                    0
                  ],
                  "destination": [
                    "remote-50",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-51",
                    0
                  ],
                  "destination": [
                    "remote-51",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-52",
                    0
                  ],
                  "destination": [
                    "remote-52",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-53",
                    0
                  ],
                  "destination": [
                    "remote-53",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-54",
                    0
                  ],
                  "destination": [
                    "remote-54",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-55",
                    0
                  ],
                  "destination": [
                    "remote-55",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-56",
                    0
                  ],
                  "destination": [
                    "remote-56",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-57",
                    0
                  ],
                  "destination": [
                    "remote-57",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-58",
                    0
                  ],
                  "destination": [
                    "remote-58",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-59",
                    0
                  ],
                  "destination": [
                    "remote-59",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-60",
                    0
                  ],
                  "destination": [
                    "remote-60",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-61",
                    0
                  ],
                  "destination": [
                    "remote-61",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-62",
                    0
                  ],
                  "destination": [
                    "remote-62",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-63",
                    0
                  ],
                  "destination": [
                    "remote-63",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-64",
                    0
                  ],
                  "destination": [
                    "remote-64",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-65",
                    0
                  ],
                  "destination": [
                    "remote-65",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-66",
                    0
                  ],
                  "destination": [
                    "remote-66",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-67",
                    0
                  ],
                  "destination": [
                    "remote-67",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-68",
                    0
                  ],
                  "destination": [
                    "remote-68",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-69",
                    0
                  ],
                  "destination": [
                    "remote-69",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-70",
                    0
                  ],
                  "destination": [
                    "remote-70",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-71",
                    0
                  ],
                  "destination": [
                    "remote-71",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-72",
                    0
                  ],
                  "destination": [
                    "remote-72",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-73",
                    0
                  ],
                  "destination": [
                    "remote-73",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-74",
                    0
                  ],
                  "destination": [
                    "remote-74",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-75",
                    0
                  ],
                  "destination": [
                    "remote-75",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-76",
                    0
                  ],
                  "destination": [
                    "remote-76",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-77",
                    0
                  ],
                  "destination": [
                    "remote-77",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-78",
                    0
                  ],
                  "destination": [
                    "remote-78",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-79",
                    0
                  ],
                  "destination": [
                    "remote-79",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-80",
                    0
                  ],
                  "destination": [
                    "remote-80",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-81",
                    0
                  ],
                  "destination": [
                    "remote-81",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-82",
                    0
                  ],
                  "destination": [
                    "remote-82",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-83",
                    0
                  ],
                  "destination": [
                    "remote-83",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-84",
                    0
                  ],
                  "destination": [
                    "remote-84",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-85",
                    0
                  ],
                  "destination": [
                    "remote-85",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-86",
                    0
                  ],
                  "destination": [
                    "remote-86",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-87",
                    0
                  ],
                  "destination": [
                    "remote-87",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-88",
                    0
                  ],
                  "destination": [
                    "remote-88",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-89",
                    0
                  ],
                  "destination": [
                    "remote-89",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-90",
                    0
                  ],
                  "destination": [
                    "remote-90",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-91",
                    0
                  ],
                  "destination": [
                    "remote-91",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-92",
                    0
                  ],
                  "destination": [
                    "remote-92",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-93",
                    0
                  ],
                  "destination": [
                    "remote-93",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-94",
                    0
                  ],
                  "destination": [
                    "remote-94",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-95",
                    0
                  ],
                  "destination": [
                    "remote-95",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-96",
                    0
                  ],
                  "destination": [
                    "remote-96",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-97",
                    0
                  ],
                  "destination": [
                    "remote-97",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-98",
                    0
                  ],
                  "destination": [
                    "remote-98",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-99",
                    0
                  ],
                  "destination": [
                    "remote-99",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-100",
                    0
                  ],
                  "destination": [
                    "remote-100",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-101",
                    0
                  ],
                  "destination": [
                    "remote-101",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-102",
                    0
                  ],
                  "destination": [
                    "remote-102",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-103",
                    0
                  ],
                  "destination": [
                    "remote-103",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-104",
                    0
                  ],
                  "destination": [
                    "remote-104",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-105",
                    0
                  ],
                  "destination": [
                    "remote-105",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-106",
                    0
                  ],
                  "destination": [
                    "remote-106",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-107",
                    0
                  ],
                  "destination": [
                    "remote-107",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-108",
                    0
                  ],
                  "destination": [
                    "remote-108",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-109",
                    0
                  ],
                  "destination": [
                    "remote-109",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-110",
                    0
                  ],
                  "destination": [
                    "remote-110",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-111",
                    0
                  ],
                  "destination": [
                    "remote-111",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-112",
                    0
                  ],
                  "destination": [
                    "remote-112",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-113",
                    0
                  ],
                  "destination": [
                    "remote-113",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-114",
                    0
                  ],
                  "destination": [
                    "remote-114",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-115",
                    0
                  ],
                  "destination": [
                    "remote-115",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-116",
                    0
                  ],
                  "destination": [
                    "remote-116",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-117",
                    0
                  ],
                  "destination": [
                    "remote-117",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-118",
                    0
                  ],
                  "destination": [
                    "remote-118",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-119",
                    0
                  ],
                  "destination": [
                    "remote-119",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-120",
                    0
                  ],
                  "destination": [
                    "remote-120",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-121",
                    0
                  ],
                  "destination": [
                    "remote-121",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-122",
                    0
                  ],
                  "destination": [
                    "remote-122",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-123",
                    0
                  ],
                  "destination": [
                    "remote-123",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-124",
                    0
                  ],
                  "destination": [
                    "remote-124",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-125",
                    0
                  ],
                  "destination": [
                    "remote-125",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-126",
                    0
                  ],
                  "destination": [
                    "remote-126",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-127",
                    0
                  ],
                  "destination": [
                    "remote-127",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-128",
                    0
                  ],
                  "destination": [
                    "remote-128",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-129",
                    0
                  ],
                  "destination": [
                    "remote-129",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-130",
                    0
                  ],
                  "destination": [
                    "remote-130",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-131",
                    0
                  ],
                  "destination": [
                    "remote-131",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-132",
                    0
                  ],
                  "destination": [
                    "remote-132",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-133",
                    0
                  ],
                  "destination": [
                    "remote-133",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-134",
                    0
                  ],
                  "destination": [
                    "remote-134",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-135",
                    0
                  ],
                  "destination": [
                    "remote-135",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-136",
                    0
                  ],
                  "destination": [
                    "remote-136",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-137",
                    0
                  ],
                  "destination": [
                    "remote-137",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-138",
                    0
                  ],
                  "destination": [
                    "remote-138",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-139",
                    0
                  ],
                  "destination": [
                    "remote-139",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-140",
                    0
                  ],
                  "destination": [
                    "remote-140",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-141",
                    0
                  ],
                  "destination": [
                    "remote-141",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-142",
                    0
                  ],
                  "destination": [
                    "remote-142",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-143",
                    0
                  ],
                  "destination": [
                    "remote-143",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-144",
                    0
                  ],
                  "destination": [
                    "remote-144",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-145",
                    0
                  ],
                  "destination": [
                    "remote-145",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-146",
                    0
                  ],
                  "destination": [
                    "remote-146",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-147",
                    0
                  ],
                  "destination": [
                    "remote-147",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-148",
                    0
                  ],
                  "destination": [
                    "remote-148",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-149",
                    0
                  ],
                  "destination": [
                    "remote-149",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-150",
                    0
                  ],
                  "destination": [
                    "remote-150",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-151",
                    0
                  ],
                  "destination": [
                    "remote-151",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-152",
                    0
                  ],
                  "destination": [
                    "remote-152",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-153",
                    0
                  ],
                  "destination": [
                    "remote-153",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-154",
                    0
                  ],
                  "destination": [
                    "remote-154",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-155",
                    0
                  ],
                  "destination": [
                    "remote-155",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-156",
                    0
                  ],
                  "destination": [
                    "remote-156",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-157",
                    0
                  ],
                  "destination": [
                    "remote-157",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-158",
                    0
                  ],
                  "destination": [
                    "remote-158",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-159",
                    0
                  ],
                  "destination": [
                    "remote-159",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-160",
                    0
                  ],
                  "destination": [
                    "remote-160",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-161",
                    0
                  ],
                  "destination": [
                    "remote-161",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-162",
                    0
                  ],
                  "destination": [
                    "remote-162",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-163",
                    0
                  ],
                  "destination": [
                    "remote-163",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-164",
                    0
                  ],
                  "destination": [
                    "remote-164",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-165",
                    0
                  ],
                  "destination": [
                    "remote-165",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-166",
                    0
                  ],
                  "destination": [
                    "remote-166",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-167",
                    0
                  ],
                  "destination": [
                    "remote-167",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-168",
                    0
                  ],
                  "destination": [
                    "remote-168",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-169",
                    0
                  ],
                  "destination": [
                    "remote-169",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-170",
                    0
                  ],
                  "destination": [
                    "remote-170",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-171",
                    0
                  ],
                  "destination": [
                    "remote-171",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-172",
                    0
                  ],
                  "destination": [
                    "remote-172",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-173",
                    0
                  ],
                  "destination": [
                    "remote-173",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-174",
                    0
                  ],
                  "destination": [
                    "remote-174",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-175",
                    0
                  ],
                  "destination": [
                    "remote-175",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-176",
                    0
                  ],
                  "destination": [
                    "remote-176",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-177",
                    0
                  ],
                  "destination": [
                    "remote-177",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-178",
                    0
                  ],
                  "destination": [
                    "remote-178",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-179",
                    0
                  ],
                  "destination": [
                    "remote-179",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-180",
                    0
                  ],
                  "destination": [
                    "remote-180",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-181",
                    0
                  ],
                  "destination": [
                    "remote-181",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-182",
                    0
                  ],
                  "destination": [
                    "remote-182",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-183",
                    0
                  ],
                  "destination": [
                    "remote-183",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-184",
                    0
                  ],
                  "destination": [
                    "remote-184",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-185",
                    0
                  ],
                  "destination": [
                    "remote-185",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-186",
                    0
                  ],
                  "destination": [
                    "remote-186",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-187",
                    0
                  ],
                  "destination": [
                    "remote-187",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-188",
                    0
                  ],
                  "destination": [
                    "remote-188",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-189",
                    0
                  ],
                  "destination": [
                    "remote-189",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-190",
                    0
                  ],
                  "destination": [
                    "remote-190",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-191",
                    0
                  ],
                  "destination": [
                    "remote-191",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-192",
                    0
                  ],
                  "destination": [
                    "remote-192",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-193",
                    0
                  ],
                  "destination": [
                    "remote-193",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-194",
                    0
                  ],
                  "destination": [
                    "remote-194",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-195",
                    0
                  ],
                  "destination": [
                    "remote-195",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-196",
                    0
                  ],
                  "destination": [
                    "remote-196",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-197",
                    0
                  ],
                  "destination": [
                    "remote-197",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-198",
                    0
                  ],
                  "destination": [
                    "remote-198",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-199",
                    0
                  ],
                  "destination": [
                    "remote-199",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-200",
                    0
                  ],
                  "destination": [
                    "remote-200",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-201",
                    0
                  ],
                  "destination": [
                    "remote-201",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-202",
                    0
                  ],
                  "destination": [
                    "remote-202",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-203",
                    0
                  ],
                  "destination": [
                    "remote-203",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-204",
                    0
                  ],
                  "destination": [
                    "remote-204",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-205",
                    0
                  ],
                  "destination": [
                    "remote-205",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-206",
                    0
                  ],
                  "destination": [
                    "remote-206",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-207",
                    0
                  ],
                  "destination": [
                    "remote-207",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-208",
                    0
                  ],
                  "destination": [
                    "remote-208",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-209",
                    0
                  ],
                  "destination": [
                    "remote-209",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-210",
                    0
                  ],
                  "destination": [
                    "remote-210",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-211",
                    0
                  ],
                  "destination": [
                    "remote-211",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-212",
                    0
                  ],
                  "destination": [
                    "remote-212",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-213",
                    0
                  ],
                  "destination": [
                    "remote-213",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-214",
                    0
                  ],
                  "destination": [
                    "remote-214",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-215",
                    0
                  ],
                  "destination": [
                    "remote-215",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-216",
                    0
                  ],
                  "destination": [
                    "remote-216",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-217",
                    0
                  ],
                  "destination": [
                    "remote-217",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-218",
                    0
                  ],
                  "destination": [
                    "remote-218",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-219",
                    0
                  ],
                  "destination": [
                    "remote-219",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-220",
                    0
                  ],
                  "destination": [
                    "remote-220",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-221",
                    0
                  ],
                  "destination": [
                    "remote-221",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-222",
                    0
                  ],
                  "destination": [
                    "remote-222",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-223",
                    0
                  ],
                  "destination": [
                    "remote-223",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-224",
                    0
                  ],
                  "destination": [
                    "remote-224",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-225",
                    0
                  ],
                  "destination": [
                    "remote-225",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-226",
                    0
                  ],
                  "destination": [
                    "remote-226",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-227",
                    0
                  ],
                  "destination": [
                    "remote-227",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-228",
                    0
                  ],
                  "destination": [
                    "remote-228",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-229",
                    0
                  ],
                  "destination": [
                    "remote-229",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-230",
                    0
                  ],
                  "destination": [
                    "remote-230",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-231",
                    0
                  ],
                  "destination": [
                    "remote-231",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-232",
                    0
                  ],
                  "destination": [
                    "remote-232",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-233",
                    0
                  ],
                  "destination": [
                    "remote-233",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-234",
                    0
                  ],
                  "destination": [
                    "remote-234",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-235",
                    0
                  ],
                  "destination": [
                    "remote-235",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-236",
                    0
                  ],
                  "destination": [
                    "remote-236",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-237",
                    0
                  ],
                  "destination": [
                    "remote-237",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-238",
                    0
                  ],
                  "destination": [
                    "remote-238",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-239",
                    0
                  ],
                  "destination": [
                    "remote-239",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-240",
                    0
                  ],
                  "destination": [
                    "remote-240",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-241",
                    0
                  ],
                  "destination": [
                    "remote-241",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-242",
                    0
                  ],
                  "destination": [
                    "remote-242",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-243",
                    0
                  ],
                  "destination": [
                    "remote-243",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-244",
                    0
                  ],
                  "destination": [
                    "remote-244",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-245",
                    0
                  ],
                  "destination": [
                    "remote-245",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-246",
                    0
                  ],
                  "destination": [
                    "remote-246",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-247",
                    0
                  ],
                  "destination": [
                    "remote-247",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-248",
                    0
                  ],
                  "destination": [
                    "remote-248",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-249",
                    0
                  ],
                  "destination": [
                    "remote-249",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-250",
                    0
                  ],
                  "destination": [
                    "remote-250",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-251",
                    0
                  ],
                  "destination": [
                    "remote-251",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-252",
                    0
                  ],
                  "destination": [
                    "remote-252",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-253",
                    0
                  ],
                  "destination": [
                    "remote-253",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-254",
                    0
                  ],
                  "destination": [
                    "remote-254",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sender-255",
                    0
                  ],
                  "destination": [
                    "remote-255",
                    1
                  ]
                }
              }
            ]
          }
        }
      },
      {
        "box": {
          "id": "audio-in",
          "varname": "audio-in",
          "maxclass": "newobj",
          "patching_rect": [
            845,
            572,
            155,
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
            616,
            155,
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
            "mlp-train",
            0
          ],
          "destination": [
            "mlp-train-prefix",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "mlp-train",
            1
          ],
          "destination": [
            "mlp-train-prefix",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "mlp-train-prefix",
            0
          ],
          "destination": [
            "mlp-train-defer",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "mlp-train-defer",
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
            "mlp-infer",
            0
          ],
          "destination": [
            "mlp-infer-prefix",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "mlp-infer",
            1
          ],
          "destination": [
            "mlp-infer-prefix",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "mlp-infer-prefix",
            0
          ],
          "destination": [
            "mlp-infer-defer",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "mlp-infer-defer",
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
            "data-output",
            0
          ],
          "destination": [
            "data-output-prefix",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "data-output",
            1
          ],
          "destination": [
            "data-output-prefix",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "data-output-prefix",
            0
          ],
          "destination": [
            "data-output-defer",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "data-output-defer",
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
            "route-dialog",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "route-dialog",
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
            "import-path",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "import-path",
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
            "route-dialog",
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
            "export-path",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "export-path",
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
            "defer-restore",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "defer-restore",
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
            "defer-host",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "defer-host",
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
            "defer-theme",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "defer-theme",
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
            "defer-load",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "defer-load",
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
            0
          ],
          "destination": [
            "to-editor",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "from-editor",
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
            "controller",
            1
          ],
          "destination": [
            "editor-control",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "editor-control",
            0
          ],
          "destination": [
            "editor",
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
        "Glove Neural Training Bank",
        "Training Bank",
        0
      ],
      "parameterbanks": {},
      "inherited_shortname": 1
    },
    "dependency_cache": [
      {
        "name": "fluid.mlpregressor~.mxo",
        "type": "iLaX"
      },
      {
        "name": "fluid.dataset~.mxo",
        "type": "iLaX"
      },
      {
        "name": "neural_scope_control.js",
        "type": "TEXT",
        "implicit": 1
      },
      {
        "name": "neural_scope_ui.html",
        "type": "TEXT",
        "implicit": 1
      }
    ]
  }
}