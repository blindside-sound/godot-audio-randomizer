# Audio Randomizer — bulk-creates AudioStreamRandomizer resources from selected files.
# SPDX-License-Identifier: MIT

@tool
extends EditorPlugin

const MENU_LABEL := "Create AudioStreamRandomizers"
const FILE_EXT := ["wav", "mp3", "ogg"]
const SUFFIX := "_randomizer"

const DEF_RAND_PITCH := 1.1
const DEF_RAND_VOL_DB := 3.0

func _enter_tree():
    print("Audio Randomizer plugin enabled.")
    add_tool_menu_item(MENU_LABEL, _on_generate_pressed)
    return

func _exit_tree():
    print("Audio Randomizer plugin disabled.")
    remove_tool_menu_item(MENU_LABEL)
    return

func _on_generate_pressed():

    var skipped := 0
    var created := 0

    for path in EditorInterface.get_selected_paths():
        if path.get_extension() not in FILE_EXT:
            continue
    
        var audio_stream = load(path)
    
        if not (audio_stream is AudioStream):
            push_warning("Not a loadable AudioStream, skipped: %s" % path)
            skipped += 1
            continue
        
        var randomizer = AudioStreamRandomizer.new()
        randomizer.add_stream(-1, audio_stream)
        randomizer.random_pitch = DEF_RAND_PITCH
        randomizer.random_volume_offset_db = DEF_RAND_VOL_DB

        var out_path := _output_path(path)
        if ResourceSaver.save(randomizer, out_path) == OK:
            created += 1
        else:
            push_warning("Save failed: %s" % out_path)
            skipped += 1
    EditorInterface.get_resource_filesystem().scan()
    print("[AudioRandomizer] Created %d -- Skipped %d" % [created, skipped])

func _output_path(source_path: String) -> String:
    return "%s/%s%s.tres" % [
        source_path.get_base_dir(),
        source_path.get_file().get_basename(),
        SUFFIX
    ]