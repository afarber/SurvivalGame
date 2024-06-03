extends Node

const INVENTORY_SIZE = 28

var inventory: Array = []

func _enter_tree() -> void:
	EventSystem.INV_try_to_pickup_item.connect(try_to_pickup_item)
	EventSystem.INV_ask_to_update_inventory.connect(send_inventory)

func _ready() -> void:
	inventory.resize(INVENTORY_SIZE)
	
func send_inventory() -> void:
	EventSystem.INV_inventory_updated.emit(inventory)
	
func try_to_pickup_item(item_key: ItemConfig.Keys, destroy_pickupable: Callable) -> void:
	if not get_free_slots():
		return
	
	add_item(item_key)
	destroy_pickupable.call()

func get_free_slots() -> int:
	# count how many elements are null
	return inventory.count(null)

func add_item(item_key: ItemConfig.Keys) -> void:
	for i in inventory.size():
		if inventory[i] == null:
			inventory[i] = item_key
			return
