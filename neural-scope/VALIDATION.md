# Glove Neural Scope validation — 2026-10-07

## Offline checks passed

- **Neural core:** eight test cases plus two recorded training metrics. The original model's layer shape and all ten samples import correctly; tanh/linear accumulation matches independently calculated predictions to 1e-12. Invalid dimensions, weights, activations and non-finite data are rejected. Serialized models predict identically.
- New 5 → 16 → 10 training on the supplied ten examples achieved normalized training **RMSE 0.02960637** after up to 800 epochs. A synthetic nonlinear 10-input/two-output dataset achieved **RMSE 0.00754120**. These are training-set results, not unseen-gesture accuracy or hardware tests.
- **21 adapter tests** execute the actual shipped Max controller in Node against a simulated Live Object Model. Coverage includes same-track and selected-track discovery, Rack traversal, selected-device follow and pinning, self exclusion, 5/5/10 input order, missing-hand rejection, native-range capture, duplicate-pose rejection, actual training completion, native remote acquisition/release, clamp and quantized output, independent mode/scope banks, stale UI events, target movement/deletion, parameter list changes, unavailable targets, release on partial mapping failure, reload with new parameter IDs, legacy import, model invalidation and deletion cleanup.
- A 302-parameter simulated target scopes 256 outputs and transports the complete table and captured sample in fragments of at most 4096 characters. Blob restoration preserves the data. The selected-track API object is cached and is not reconstructed per frame.
- **Four HTML function tests** execute the actual packet receiver and theme function: complete out-of-order 302-row message assembly; stale/duplicate rejection; malformed-packet error reporting; light/dark CSS palette and contrast. These are function tests, not browser rendering.
- Structural checks verify recursive links, 256 fixed native remote channels, both Max receive buses, the Live theme bridge, stereo connections, relative companion dependencies and AMXD/source equality. Generated Max JS and HTML scripts pass syntax checks.

Results are in `validation/neural.json`, `adapter.json` and `ui.json`.

## Host boundary

No native Live or Max UI test was completed for this new device. Live app control was not approved. The in-app browser rejected the localhost UI preview request because permission was declined; no alternate browser or hidden browser access was attempted. The temporary preview server was stopped.

Opening the AMXD, companion-file resolution, native theme rendering, the editor window, actual glove buses, all Live parameter mapping behavior, Set recall and stereo audio require host acceptance. Scope Lab's previous native validation is useful implementation context but does **not** validate this new device.

## Live acceptance procedure

1. Keep all four runtime files together. Load the AMXD after an instrument or on an audio track. Check the Max console for missing assets or JS/API errors and confirm stereo pass-through.
2. Load one Glove Receiver Dual. Move each hand once and inspect the ten input values. Switch Left, Right and Both; verify Both waits if a hand has never sent a valid frame.
3. Select a target on This track, then try Selected track and Follow. Pin a target from the menu. Change target during Run and confirm the previous mappings release and Run remains off.
4. Scope two or more parameters, record at least two distinct gestures/sounds with Run off, Train, then Run. Confirm clamps, continuous and quantized parameters, output smoothing and Stop behavior. Check the large editor and both light/dark themes.
5. Select ten outputs and a single hand, load Legacy model, and verify output order. Switch Both and verify the old five-dimensional model is not used there.
6. Save/reopen a Set. Choose the same target and verify samples, weights and settings return while Run is off. Check target removal, parameter Configure changes and device/Rack reordering before performance use.
