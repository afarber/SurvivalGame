extends Node3D
class_name ItemHolder

var current_item_scene:EquippableItem


func _enter_tree() -> void:
	EventSystem.EQU_equip_item.connect(equip_item)
	EventSystem.EQU_unequip_item.connect(unequip_item)


func equip_item(item_key:ItemConfig.Keys) -> void:
	unequip_item()
	var item_scene := ItemConfig.get_equippable_item_scene(item_key).instantiate()
	
	if item_scene is EquippableWeapon:
		item_scene.weapon_item_resource = ItemConfig.get_item_resource(item_key)
	
	elif item_scene is EquippableConsumable:
		item_scene.consumable_item_resource = ItemConfig.get_item_resource(item_key)
	
	elif item_scene is EquippableConstructable:
		item_scene.constructable_item_key = item_key
	
	add_child(item_scene)
	current_item_scene = item_scene


func unequip_item() -> void:
	for child in get_children():
		child.queue_free()
	
	current_item_scene = null


func try_to_use_item() -> void:
	if current_item_scene == null:
		return
	
	current_item_scene.try_to_use()
