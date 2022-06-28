tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("BeatKeeper", "AudioStreamPlayer", preload("beatkeeper_node.gd"), preload("AudioStreamPlayer.svg"))


func _exit_tree():
	remove_custom_type("MyButton")
