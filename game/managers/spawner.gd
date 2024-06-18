extends Node3D
class_name Spawner

@onready var items: Node3D = $Items

func _enter_tree() -> void:
	EventSystem.SPA_spawn_scene.connect(spawn_scene)

func spawn_scene(scene: PackedScene, tform: Transform3D) -> void:
	var object := scene.instantiate()
	object.global_transform = tform
	items.add_child(object)
