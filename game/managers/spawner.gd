extends Node3D
class_name Spawner

@export var constructable_holder: Node3D

@onready var object_holder: Node3D = $ObjectHolder


func _enter_tree() -> void:
	EventSystem.SPA_spawn_scene.connect(spawn_scene)
	EventSystem.SPA_spawn_vfx.connect(spawn_vfx)

func spawn_scene(scene:PackedScene, tform:Transform3D, is_constructable := false) -> void:
	var object := scene.instantiate()
	object.global_transform = tform
	
	if is_constructable:
		constructable_holder.add_child(object)
		EventSystem.GAM_update_navmesh.emit()
	
	else:
		object_holder.add_child(object)


func spawn_vfx(scene:PackedScene, tform:Transform3D) -> void:
	var vfx := scene.instantiate()
	vfx.global_transform = tform
	add_child(vfx)
	
	if vfx is GPUParticles3D:
		vfx.emitting = true
	
	get_tree().create_timer(2.0, false).timeout.connect(vfx.queue_free)

