# Readable patch sources

These four `.maxpat` files were extracted from the JSON payloads of the corresponding `.amxd` devices in `../devices/`. They preserve the original patch content, nested subpatches, and parameter metadata.

Use the `.amxd` files when loading devices into Ableton Live. The extracted sources are intended for code review and editing; changing them does not automatically update the corresponding `.amxd` binary. Save an edited device through Max for Live and refresh its extracted source for publication.

Add `../devices/` to Max's file search path when opening these sources so `unitPart.maxpat` and the regression JSON can resolve. External CNMAT MMJ Depot, Data Knot, and FluCoMa dependencies still apply.
