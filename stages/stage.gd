extends Node
class_name Stage


signal loading_complete


@export var show_mouse := false
@export var music_to_play := MusicConfig.Keys.MainMenuSong
@export var scatter_nodes : Array[Node3D] = []

var scatter_nodes_ready := 0


func _ready() -> void:
	EventSystem.MUS_play_music.emit(music_to_play)
	
	for scatter_mode in scatter_nodes:
		if scatter_mode.has_signal("build_completed"):
			scatter_mode.build_completed.connect(scatter_node_loaded)
	
	if scatter_nodes.is_empty():
		loading_complete.emit()


func scatter_node_loaded() -> void:
	scatter_nodes_ready += 1
	
	if scatter_nodes_ready >= scatter_nodes.size():
		loading_complete.emit()
		
		if show_mouse:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
