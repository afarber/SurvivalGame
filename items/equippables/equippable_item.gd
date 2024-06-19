extends Node3D
class_name EquippableItem

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	for child in $MeshHolder.get_children():
		# put every equippable item on camera layer 2, to make it visible to MainCamera
		if child is VisualInstance3D:
			child.layers = 2

func try_to_use() -> void:
	if animation_player.is_playing():
		return
	animation_player.play("use_item")
