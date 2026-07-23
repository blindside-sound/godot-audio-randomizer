# Audio Randomizer

Bulk generation configured `AudioStreamRandomizer` resources from a selection of audio files. Select your files in the FileSystem dock, run one menu command and get one randomizer per file with sensible default pitch/volume variation. No need for manual resource creation.

Godot 4 already randomizes pitch/volume at runtime via `AudioStreamRandomizer`. This tool doesn't replace that. It automates the busywork of creating and configuring one of those resources per sound, instead of doing it by hand thirty times.

## Install

**Via Asset Library:** search "Audio Randomizer" in the AssetLib tab, install, enable under Project > Project Settings > Plugins.

**Manual:** copy `addons/audio_randomizer/` into your project's `addons/` folder, then enable it under Project > Project Settings > Plugins.

## Usage

1. Select one or more audio files (`.wav`, `.ogg`, `.mp3`) in the FileSystem dock.
2. Project menu > Tools > Create AudioStreamRandomizers.
3. A `<filename>_randomizer.tres` is created next to each selected file.

**WARNING:**
Re-running on the same file overwrites its generated `.tres` in place so any manual edits to a generated resource will be lost on regeneration.

## Defaults

- Pitch variation: 1.1
- Volume variation: ±3 dB

No config UI in v1 so defaults are baked in (Will work on this next). Edit the generated `.tres` directly if you need different values.

## License

MIT — see LICENSE.