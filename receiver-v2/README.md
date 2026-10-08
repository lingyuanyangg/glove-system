# Glove Receiver Dual

A compact **648 × 169** Max for Live audio effect for dual-hand USB/OSC reception, independent Open/Fist calibration, jitter suppression, animated finger curl and OSC forwarding. Stereo audio passes through.

[Download Receiver](Glove_Receiver_Dual.zip) · [中文操作说明](README_中文.md)

![Receiver interface layout](layout-preview.png)

## Install

Keep `Glove_Receiver_Dual.amxd`, `glove_dual_engine.js`, `glove_hands.js` and `glove_usb_serial.js` together. Load the device on an audio track. Use one Receiver per Set: `GLeft` / `GRight` buses and UDP ports 7000/6000 are shared.

## USB reception

Upload the [D12 hardware-UART firmware](../arduino/glove_usb_dual_hardware/README.md). Left receiver TXD connects to **D0**; Right receiver TXD connects to **D12**. Close Serial Monitor and other programs using the port.

Open **USB…**, click **Refresh**, select the board's USB port, then **Open**. Open also selects USB input. A selected port alone does not open it. USB settings show L/R activity and board/UART diagnostic counters. Close releases the port; choosing OSC closes USB. The saved port name recalls with the connection closed, so click Open after device load.

USB expects 115200, 8N1 degree frames such as `L,180.0,160.0,150.0,149.0,134.5;` and `R,...;`. Arduino has already divided by ten. Board diagnostics do not drive finger values.

## Calibration

Open Calibrate for each hand independently:

1. Hold the hand naturally open for at least 0.3 seconds; click **Open → 0**.
2. Hold a comfortable fist for at least 0.3 seconds; click **Fist → 0.9**.
3. Confirm both captures succeeded. **Reset** restores that hand's default range.

The Input row displays unfiltered input before endpoint calibration; USB values are degrees. Capture averages recent input and rejects motion, insufficient span or stale data. Each finger supports either sensor direction. Output is clipped to 0–1 with fist at 0.9 and extra bend headroom to 1.0. Completed endpoint pairs are saved with the Live Set. Keep calibration consistent before training Gesture or Neural Scope.

![Calibration controls](calibration-preview.png)

## Filtering and display

Stabilize applies Deadband, default **0.003**, and time-aware Smooth, default **8 ms**. Reduce Smooth for faster response or increase it for steadier control. Smooth 0 bypasses time smoothing; Deadband 0 accepts every change; Stabilize off bypasses both.

Each hand displays five values in **pinky, ring, middle, index, thumb** order. Vector hands fold with normalized curl; meters mark 0.9. The drawing illustrates curl, not measured joint angles. Monitors refresh around 30 Hz independently of control processing.

WAIT means no data since initialization; LIVE means recent valid input; HOLD means one second without valid input. HOLD retains the last values. The calibration Input table lets you inspect the source before normalization.

## OSC input and forwarding

| Hand | Input port | Degree input | 0–1 input |
| --- | ---: | --- | --- |
| Left | 7000 | `/servos` | `/GLeft` |
| Right | 6000 | `/servos` | `/GRight` |

Every packet has five numeric arguments in the common finger order. For forwarding, enter destination IP/host and Port, click **Apply**, then enable **OSC Out**. Output addresses are `/GLeft` and `/GRight`, each with five calibrated, filtered values. Default destination is `127.0.0.1:8000`; forwarding starts off.

## Connecting other devices

The Receiver publishes fresh physical input on `GLeft` / `GRight`, including stationary real frames. Change-driven smoothing updates also go to `GLeftControl` / `GRightControl` for [Glove Mapper](../mapper/README.md). [Gesture](../gesture-classification/README.md), [Neural Scope](../neural-scope/README.md) and [MIDI Trigger](../midi-trigger/README.md) use the physical-frame buses. No track audio routing is needed for these messages.

See the [operating guide](../docs/OPERATING.md) for troubleshooting and [technical specification](../docs/TECHNICAL.md) for endpoint formulas, capture limits and bus timing.
