# Glove MIDI Trigger

A native Max for Live **MIDI effect** for the ElastremeSense Manu-5D e-skin glove system. Each of ten fingers can strike an acceleration-triggered note or hold a note while curled. Fixed and scale-constrained random pitches, note ranges and velocity endpoints are independent for every finger. No FluCoMa, Data Knot, Node runtime or external Max package is needed at runtime.

![Native layout preview](ui-layout.png)

The preview illustrates the generated layout; Live supplies its actual native widget theme. The main panel is 984 × 169 pixels. A star beside a finger means it owns an active note. Controls and the calibration reference are Live parameters saved with the device/Set; held notes, derivative history and an unfinished calibration are never recalled.

## Install and play

1. Keep `Glove_MIDI_Trigger.amxd` and `glove_midi_trigger.js` together. The ZIP preserves this folder structure. Load `receiver-v2/Glove_Receiver_Dual.amxd` once in the same Live Set and connect USB or OSC there.
2. Put **Glove MIDI Trigger on a MIDI track before an instrument**, such as Drum Rack or a synthesizer. The Receiver may stay on its existing audio track. The effect creates MIDI even without incoming keyboard notes; keyboard/clip MIDI also passes through.
3. Return fingers to an open pose. LEFT/RIGHT show LIVE when fresh data arrive; WAIT releases that hand's notes. Each hand reads `GLeft` or `GRight`, in **pinky, ring, middle, index, thumb** order.
4. Leave **Accel** selected to strike notes by moving fingers. Click **Calibrate 8 s** and make several representative strikes with enabled fingers. Notes are suppressed during capture. Calibration pools both hands into one global acceleration reference; repeat if the message reports too little motion. Click again to cancel.
5. **Sens %** increases or decreases acceleration response. **Threshold** sets the minimum normalized strength; **Length ms** is acceleration-note duration and **Retrig ms** is the shortest interval between strikes from one finger. **Cal ref / s²** exposes the saved reference and can also be entered manually.
6. Choose **Toggle** to hold a note when curl crosses **above 0.5**. Returning **below 0.45** releases it; the small hysteresis prevents threshold chatter. A finger loaded or re-enabled while already bent must return below 0.45 first. **Panic** releases generated notes and re-arms from a fresh pose.

## Per-finger settings

| Control | Behavior |
| --- | --- |
| On | Enables this finger. Switching it off releases its note. |
| Trigger | Accel = short acceleration strike; Toggle = continuous curl gate/hold, not a latched flip-flop. |
| Pitch / Note | Fixed uses Note (MIDI 0–127); Random chooses a new pitch at each trigger. |
| Root / Scale | Applied to Random only. Roots C–B; chromatic, major, natural minor, seven diatonic modes, major/minor pentatonic, blues and whole tone. |
| Low / High | Inclusive MIDI limits for Random. Only pitches in the chosen root/scale are eligible. An inverted range, or a one-note range outside the scale, produces no note and a status message. |
| V Min / V Max | MIDI 1–127, independent for each finger. Endpoints may be inverted for an inverse response. Velocity 0 is never emitted as a note-on. |

Live displays MIDI pitch names using its own octave naming (for example MIDI 60 is C3 in Live). Fixed mode ignores Root/Scale/Low/High. Random mode ignores Note. The default fixed pitches are MIDI 60–69, left pinky through right thumb.

## What “acceleration” means

These buses carry five filtered **curl positions**, not IMU acceleration. The effect computes the magnitude of the time derivative of curl velocity: bend acceleration in **normalized curl / second²**. It uses measured frame arrival intervals, not a fixed frame rate. Both starting and stopping a movement, including extension, can create a strike.

Velocity is smoothed with a 20 ms time constant; acceleration with 30 ms. A 15 ms peak window makes note-on velocity reflect the movement's initial peak, followed by a 5 ms scheduling task. These are design values, not measured end-to-end latency. The Receiver's Smooth/Deadband and the hardware transport still affect the signal; begin with the existing Receiver's 8 ms / 0.003 defaults.

Strength = `abs(acceleration) / calibration_reference × Sens / 100`. A strike starts at Threshold; velocity maps strength between Threshold and 1 onto V Min–V Max, clipped at the endpoints. The detector re-arms below half Threshold and obeys Retrig ms. Calibration uses the 95th percentile of 120 ms peak bins containing motion above 0.5 curl/s², over 8 seconds; at least eight bins are required. Enabled fingers in either trigger mode contribute. Quiet or cancelled calibration keeps the old reference.

## Hold intensity and MIDI behavior

At Toggle note-on, curl from 0.5 to 1 maps onto V Min–V Max. **MIDI note-on velocity is fixed for the lifetime of a note.** Further bending sends per-note **polyphonic key pressure (Poly Aftertouch)** at most every 25 ms when its value changes. Your instrument must respond to poly pressure to hear that continuous intensity change; otherwise the note sustains with its initial velocity. The effect does not repeatedly retrigger a held note. See the [MIDI message reference](https://docs.cycling74.com/userguide/midi/) for note/pressure message types.

Random chooses once per hold and keeps that pitch until release. Fingers sharing the same output pitch/channel share one voice: the first onset supplies note-on velocity, the maximum current owner intensity supplies pressure, and the final owner releases the note. Use different fixed notes if you want independent articulation. Incoming keyboard/clip notes pass through separately; avoid assigning the same pitch to a keyboard note and a glove hold if independent release is required. The Channel control encodes outgoing glove MIDI; actual channel routing/filtering remains subject to Live and the target instrument.

A frame gap over 100 ms resets derivatives and releases that hand's held notes on the next frame. With no valid frames, a 250 ms timeout releases them. Disable, per-finger setting changes, global setting changes, Panic, calibration, and device deletion release owned notes. No global CC123 is sent, so Panic targets this device's generated voices. Complete incoming MIDI messages are reconstructed before forwarding to prevent inserted note packets from corrupting MIDI running status; channel messages, system common, real-time, and complete SysEx packets are handled (SysEx limited to 65,536 bytes and subject to host support). [midiout](https://docs.cycling74.com/reference/midiout/) receives each complete packet.

## Source and verification

`tools/build.py` regenerates the editable `.maxpat`, MIDI-type `.amxd` envelope, and SVG preview. `tools/test_engine.js` runs against the actual ES5 engine in a deterministic Node VM. `tools/test_patch.py` checks parameters, routing, packet envelope and UI bounds. Node/Python are development tools only. See [VALIDATION.md](VALIDATION.md) for completed checks and their limits.
