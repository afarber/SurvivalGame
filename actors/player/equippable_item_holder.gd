extends Node3D

var current_item_scene: Node3D

func _enter_tree() -> void:
	EventSystem.EQU_equip_item.connect(equip_item)
	EventSystem.EQU_unequip_item.connect(unequip_item)

func equip_item(item_key: ItemConfig.Keys) -> void:
	unequip_item()
	var item_scene := ItemConfig.get_equippable_item(item_key).instantiate()
	add_child(item_scene)
	current_item_scene = item_scene

func unequip_item() -> void:
	for child in get_children():
		child.queue_free()
	current_item_scene = null
