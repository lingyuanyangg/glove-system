# Glove Mapper

A standalone Max for Live audio effect with ten native finger mappings: five from `GLeft`, five from `GRight`. The controls were extracted from Glove Receiver Dual. Each finger has a read-only 0–1 monitor, **Map**, **×**, **Min** and **Max** in a compact **388 × 169** native Live interface.

[Download Glove Mapper](Glove_Mapper.zip).

## Install and use

Keep `Glove_Mapper.amxd` and `glove_mapper.js` together. Load the audio effect on an audio track or after an instrument. Keep one Glove Receiver Dual in the Set, connect USB/OSC and calibrate there. The Mapper can sit on another track; the shared Max buses do not require a track audio routing connection.

Click a finger's **Map**, then a Live parameter. Click **×** to release it. Min/Max are 0–100% of that target's native range, default 0/100. Inverted and equal ranges are supported. With 20/80%, open (0) reaches 20%, calibrated fist (0.9) reaches 74%, and full headroom (1) reaches 80%. Each mapping and its ranges are stored with this device in the Live Set. Keep Live's audio engine running for `live.remote~` control.

The receiver's calibration, Stabilize, Smooth and Deadband process the inputs first. The Mapper introduces no second smoothing stage. Its signals update on accepted control messages; numbers refresh at approximately 30Hz. Stereo audio passes through unchanged.

**WAIT** means no valid fresh hand frame since load. **LIVE** means recent valid fresh frames; **HOLD** means over one second without them. HOLD retains the last value and assignment. It does not measure Bluetooth sensor age.

## Data interface

Both hands use five numeric values in **pinky, ring, middle, index, thumb** order, each in 0–1. Malformed/nonfinite/out-of-range lists are ignored.

- `GLeft` / `GRight`: fresh filtered input, also consumed by regression and classification. Stationary real frames refresh status; no synthetic heartbeat is added.
- `GLeftControl` / `GRightControl`: the new receiver's change-driven control outputs, including smoothing ticks between physical frames. The Mapper uses these immediately so moving the mapping out of the receiver does not insert a monitor-frame wait. These side buses do not refresh connection status.

The standard buses remain sufficient with an older receiver; the extra control buses preserve the new receiver's finer smoothing updates. Duplicate identical values do not re-send a signal or repaint the UI.

## Migrating existing Sets

The new Receiver contains no Map/Min/Max or `live.remote~` objects. The new Mapper is a separate device, so **old Receiver assignments do not automatically move across**. Reassign their targets and ranges in Mapper. A local backup of the previous receiver is retained. Existing loaded instances in old Sets keep their original embedded patch until replaced; do not run both receiver versions together on the same ports.

## Source and checks

The `.maxpat` source and AMXD payload are equivalent. The ten native `liveui.map` modules are embedded, with strict mapping and persistence. The builder imports the shared `../tools/native_mapping.py`, which reads Cycling '74's locally installed Max for Live mapping patch. That helper is a build-time dependency, not a runtime companion.

```sh
python3 tools/build.py
python3 tools/test_patch.py
node tools/test_controller.js
node tools/test_mapping.js
node tools/export_layout.js
```

The controller and native range graph pass offline checks; the validation record distinguishes these from actual Live operation.

Illustrative layout generated from presentation rectangles, not a Live screenshot:

![Glove Mapper](layout-preview.png)
