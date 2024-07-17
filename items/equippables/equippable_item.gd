extends Node3D
class_name EquippableItem

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	for child in $MeshHolder.get_children():
		if child is VisualInstance3D:
			child.layers = 2 # equippable camera visual layer


func try_to_use() -> void:
	if animation_player.is_playing():
		return
	
	animation_player.play("use_item")
