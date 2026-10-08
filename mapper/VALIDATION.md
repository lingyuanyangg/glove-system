# Glove Mapper validation — 2026-10-08

## Verified offline

- Recursive graph, unique Live parameter names, ten persistent strict native mappings, visible 0–100% Min/Max, correct signal/ID outlets and target-range query before ID output.
- Ten native `p Scale` graph simulations cover full range, 20–80%, calibrated fist 0.9, headroom 1, inversion, equal endpoints, clipping and target ranges [-70,6] and [20,20000].
- The shipped controller executes in a VM: both control signals update before a UI tick, latest-only monitors, no idle painting, rejection of malformed/nonfinite/out-of-range input, stationary fresh frames, control side buses that do not manufacture freshness, HOLD, and Task disposal.
- AMXD header/length/payload equal its source; stereo pass-through; native presentation fits 388 × 169 without overlapping top-level controls.
- The paired Receiver has no mapping/remote objects. Its change-driven control outlets feed GLeftControl/GRightControl; fresh-input outlets continue to feed GLeft/GRight. Receiver 26 engine and 38 USB checks pass.

## Verified in Ableton Live

Loaded the installed Receiver and Mapper on the existing empty fourth audio track in the user's Untitled Set. The native gray/orange UI, ten read-only values, Map/Min/Max and animated hands were observed directly through native app screenshots.

Two synthetic OSC frames sent to localhost showed Left [0.2,0.4,0.6,0.8,0.9] and Right [0.9,0.8,0.6,0.4,0.2] correctly in both devices; Receiver mirrors the Right display spatially while Mapper keeps the documented channel order. Both devices transition to HOLD after source loss.

A native Left Pinky mapping to the empty fourth track's Pan revealed that the inherited liveui.map module did not request its target range. Added getrange before the mapped ID reaches live.remote~. Reloaded the final Mapper and verified input 0.2 produces Pan **-0.6** in its [-1,1] native range, displayed as **30L**, rather than an unscaled 0.2. The Pan control becomes unavailable while mapped. Clicking × releases it. The temporary assignment was removed and Pan restored to **0 / C**. Synthetic values were cleared to zero afterward. Both final devices remain loaded; USB was not opened and the Set was not saved.

## Remaining host checks

This review did not test all ten simultaneous native assignments, actual host editing of every Min/Max combination, parameter reassignment/duplicate-device cases, saved Set mapping/range recall, real USB/glove input, OSC output or audio fidelity. Offline graph checks are not measurements of actual hardware latency. Illustrative preview images are not screenshots of Live.
