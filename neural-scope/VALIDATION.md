# Glove Neural Scope validation — 2026-10-07

## Offline checks passed

- **Neural core:** eight cases plus two training metrics use synthetic data only, without the removed default JSON. User-selected Data Knot layer conversion, independent tanh/linear accumulation, dimension validation, malformed weights/inputs and weight serialization pass.
- Synthetic 5 → 16 → 10 training achieved **RMSE 0.00894872**; synthetic nonlinear 10-input/two-output training achieved **RMSE 0.00754120** after up to 800 epochs. These are training-set results, not unseen-gesture accuracy or hardware tests.
- **32 adapter tests** execute the actual shipped Max controller in Node against a simulated Live Object Model. Existing discovery, Rack traversal, hand routing, capture, training, remote acquisition/release, output clamp, mode/scope banks, topology changes, saved-state rematching, cleanup and theme checks pass. New coverage checks named immutable snapshots, same-name identities, scope/bounds recall with Run release, mode/target compatibility, unavailable-output rejection, library restore after runtime ID changes, cross-Set JSON export/import, Unicode names, malformed imports, dialog cancellation/stale callbacks, deletion without bank erasure, export without a current target, version-one state migration, user-selected Data Knot import and large-library transport.
- A 302-parameter simulated target scopes 256 outputs and transports the complete table and captured sample in fragments of at most 4096 characters. Blob restoration preserves the data. The selected-track API object is cached and is not reconstructed per frame.
- **Nine HTML function checks** execute the actual packet receiver, theme function and model selector: out-of-order table assembly, stale/duplicate rejection, malformed-packet error reporting, light/dark colors, empty/named library state, compatible/incompatible Load controls, training lockout and selector IDs. These are function tests, not browser rendering.
- Structural checks verify recursive links, 256 fixed native remote channels, both Max receive buses, the Live theme bridge, stereo connections, relative companion dependencies, native import/export dialog routes, absence of the removed preset and AMXD/source equality. Generated Max JS and HTML scripts pass syntax checks.

Results are in `validation/neural.json`, `adapter.json` and `ui.json`.

## Host boundary

No native Live or Max UI test was completed for this new device. Live app control was not approved. The in-app browser rejected the localhost UI preview request because permission was declined; no alternate browser or hidden browser access was attempted. The temporary preview server was stopped.

Opening the AMXD, companion-file resolution, native theme rendering, the editor window, actual glove buses, all Live parameter mapping behavior, Set recall and stereo audio require host acceptance. Scope Lab's previous native validation is useful implementation context but does **not** validate this new device.

## Live acceptance procedure

1. Keep the AMXD and its JS/HTML companions together. Load the AMXD after an instrument or on an audio track. Check the Max console for missing assets or JS/API errors and confirm stereo pass-through.
2. Load one Glove Receiver Dual. Move each hand once and inspect the ten input values. Switch Left, Right and Both; verify Both waits if a hand has never sent a valid frame.
3. Select a target on This track, then try Selected track and Follow. Pin a target from the menu. Change target during Run and confirm the previous mappings release and Run remains off.
4. Scope two or more parameters, record at least two distinct gestures/sounds with Run off, Train, then Run. Confirm clamps, continuous and quantized parameters, output smoothing and Stop behavior. Check the large editor and both light/dark themes.
5. Train and Save two named models with different output scopes/bounds. Select and Load each, confirming Run stops and saved scope/bounds return. Export a model, Import it into another Set, test file-dialog cancellation, and verify a different hand mode or target structure prevents Load. Test × removes only the snapshot. A user-selected Data Knot model additionally requires single-hand input and exactly ten scoped outputs.
6. Save/reopen a Set. Choose the same target and verify samples, weights, named model selector and settings return while Run is off. Check target removal, parameter Configure changes and device/Rack reordering before performance use.
