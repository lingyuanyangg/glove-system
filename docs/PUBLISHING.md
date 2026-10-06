# Publishing this project on GitHub

This folder is prepared as a standalone repository root. Use its `README.md` as the GitHub front page. It can also be added as a `Glove_System/` subfolder in an existing repository; in that case link to this README from the existing repository's landing page.

Suggested repository name: **glove-system**.

Suggested GitHub description:

> Five-channel glove interface combining Arduino servo control, OSC over Wi-Fi, and Max for Live parameter mapping, gesture-triggered MIDI, and neural regression.

Suggested topics: `arduino`, `uno-r4-wifi`, `osc`, `max-for-live`, `ableton-live`, `gesture-control`, `flucoma`, `data-knot`.

## Files to upload

Upload the complete contents of this folder, preserving the directory layout and filenames. The four `.amxd` binaries are the Live device entry points; the extracted `.maxpat` files make the implementation readable on GitHub. Keep the model and helper in `max/devices/`.

The included ZIP is a convenient transfer archive. Extract it before uploading the repository contents. Do not upload only the ZIP if you want GitHub to display the README and source code.

## Git commands

In a standalone copy of this directory, outside any existing repository:

```sh
git init -b main
git add README.md .gitignore .gitattributes arduino max docs tools
git commit -m "Add glove firmware, Max for Live devices, and English documentation"
git remote add origin https://github.com/YOUR_USERNAME/glove-system.git
git push -u origin main
```

Replace the remote with the actual repository you created on GitHub. When integrating into an existing repository, use that repository's branch and commit workflow rather than initializing a nested repository.

The publication copy contains placeholder network settings. Upload that copy before making local Wi-Fi edits. No project-wide license has been chosen; decide the license and verify the recovered helper's attribution before describing the repository as open source. Third-party packages are linked as dependencies rather than bundled.

## GitHub repository

The public repository is [lingyuanyangg/glove-system](https://github.com/lingyuanyangg/glove-system). The initial project publication was prepared on 2026-10-06. Subsequent changes and publication commits are recorded in the repository history.
