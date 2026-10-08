# Glove MIDI Trigger

A native Max for Live **MIDI effect** for ten independent fingers: piano-like bend-acceleration strikes or curl-held notes, fixed, random or Markov pitches, and individual note ranges, native draggable note-name controls, and global Root/Scale and velocity limits shared by both hands. The **664 × 169** main panel places both hands' settings side by side.

[Download MIDI Trigger](Glove_MIDI_Trigger.zip) · [中文操作说明](README_中文.md)

![MIDI Trigger interface layout](ui-layout.png)

## Install and play

Keep `Glove_MIDI_Trigger.amxd` and `glove_midi_trigger.js` together. Load on a **MIDI track before an instrument**. Connect/calibrate [Glove Receiver Dual](../receiver-v2/README.md) anywhere in the same Set. The effect reads fresh `GLeft` / `GRight` frames, ordered pinky, ring, middle, index, thumb. Keyboard/clip MIDI passes through.

Return fingers to an open pose. LEFT/RIGHT show LIVE when data arrive and WAIT otherwise. A star beside a finger means it owns an active note.

## Per-finger controls

| Control | Function |
| --- | --- |
| On | Enable/disable; disabling releases its note |
| Trigger | Accel = one short note per accelerating bend stroke; Toggle = note held while curled |
| Pitch / Note | Fixed uses Note; Random draws uniformly; Markov uses the previous pitch and the selected preset |
| Low / High | Inclusive random range entered as note names; only notes within the global scale are eligible for Random and Markov |

## Note names and global scale

**Note**, **Low** and **High** are native `live.numbox` controls in MIDI-note units. Drag up/down to change pitch in semitone steps, or select a field, type `C2`, `A4` or `F#3` and press **Enter**. Hold Shift while dragging for finer mouse control. The device follows **Live's octave convention: C3 = MIDI 60**, so C2 is MIDI 48 and A4 is MIDI 81. Accepted pitches span C-2 through G8 (MIDI 0–127). Use sharp spelling for accidentals, for example A#3 for B-flat. The underlying saved values are MIDI integers. Settings are saved with the Live Set.

The top-row **Root / Scale** controls apply to every Random/Markov finger on both hands. Root spans C–B; scales include chromatic, major/minor, diatonic modes, pentatonic, blues and whole tone. Each finger keeps its own Low/High range. For example, Root C / Scale Major and Low C2 / High C4 choose only C-major notes within that range.

Fixed ignores Root/Scale/Low/High; Random and Markov ignore Note. An empty random scale/range intersection produces no note and a message. Changing a pitch, Root or Scale releases the affected generated notes; lift before the next Accel strike; Toggle must return below 0.45. Default fixed notes span C3–A3 across Left pinky through Right thumb.

## Global velocity limits

The top-row **V Min / V Max** controls set one MIDI velocity range (1–127) for all ten fingers, in both Accel and Toggle modes. Stronger movement or deeper curl moves within this shared range. Reversed endpoints invert the response; equal endpoints give constant velocity. Changing either endpoint releases generated notes; return to neutral before playing again.

## Markov Chain presets

Select **Markov** in a finger's Pitch menu and choose a global **Markov** preset. Root/Scale and that finger's Low/High define the eligible pitches. Each finger has an independent first-order Markov chain: the previous triggered pitch changes the probability of its next pitch. The first pitch is a uniform draw from the eligible range.

| Preset | Transition preference |
| --- | --- |
| Stepwise | Neighboring eligible notes, with occasional wider moves |
| Upward | Rising steps; preferential wrap to the bottom at the range ceiling |
| Downward | Falling steps; preferential wrap to the top at the range floor |
| Leaps | Wider intervals, especially three or four eligible-note steps |
| Tonic Pull | Tonic, fifth and third, with a preference for the current register |
| Balanced | Broad choices with a mild preference for nearby pitches |

Only a triggered note advances the chain; lifting or stopping does not. Note release keeps its history. Panic, setting changes, reload and input loss reset history; settings and the preset choice are saved, but phrase history is transient. The preset selector affects Markov lanes; Fixed and Random keep their own pitch behavior.

## Acceleration and global calibration

Accel behaves like a piano downstroke: **increasing curl with positive bend acceleration** crosses Threshold and triggers one note. Continuing the same bend, stopping and extending do not generate another note. A real return stroke, at least 0.02 below that stroke's peak curl, re-arms immediately. There is no stationary dwell requirement. The next accelerating bend may strike again, subject to Retrig ms. Small fluctuations below the return distance cannot re-arm.

Acceleration is calculated from normalized curl, not an IMU. A stronger accelerating bend produces larger velocity within the global V Min–V Max. Length ms sets the note duration independently of finger release. Default Retrig is 40 ms; lower it toward 20 ms for faster repeats if needed.

Click **Calibrate 8 s** and make several representative accelerating bends with enabled fingers, lifting between strikes. Notes pause while capturing a global reference pooled from both hands. The completed reference is saved as **Cal ref / s²**. Insufficient motion keeps the existing value; click again to cancel.

- **Sens %**: higher makes the same movement stronger/more sensitive.
- **Threshold**: minimum normalized strength to trigger.
- **Length ms**: acceleration-note duration.
- **Retrig ms**: shortest repeat interval per finger.
- **Channel**: outgoing glove MIDI channel, subject to Live/instrument routing.
- **Panic**: release generated notes and lift fingers to re-arm.

Calibration/filter settings in the Receiver affect this signal. Save the Live Set for MIDI settings and calibration; held notes are not recalled.

## Toggle and continuous intensity

Toggle here is a curl gate: **above 0.5 begins a held note; below 0.45 releases it**. Hysteresis avoids threshold chatter. A finger already bent at load/re-enable/reconnect must return below 0.45 first.

Curl 0.5–1 maps to V Min–V Max. Note-on velocity is set at onset; continued curl sends **Poly Aftertouch** at most every 25 ms when its value changes. The instrument must respond to poly pressure for continuous intensity changes. The effect does not repeatedly retrigger a held note. Random and Markov choose once per onset and keep the pitch during the hold.

Fingers with identical generated pitch/channel share one voice: the first onset supplies velocity, maximum owner intensity supplies pressure, and the last owner releases it. Use distinct pitches for independent articulation. Avoid keyboard/glove overlap on the same pitch if independent note release is needed.

A frame gap over 100 ms resets/release on the next frame; no valid data for 250 ms releases that hand. Disable, settings/mode changes, Panic, calibration and deletion release generated notes. Panic does not send a global All Notes Off for incoming keyboard notes.

See the [technical specification](../docs/TECHNICAL.md) for formulas and timing, and [operating guide](../docs/OPERATING.md) for setup/troubleshooting.
