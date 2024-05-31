extends Interactable

class_name Pickupable

@export var item_key: ItemConfig.Keys

var parent: Node3D = get_parent()

func start_interaction() -> void:
	# Remove the parent from the world
	parent.queue_free()
