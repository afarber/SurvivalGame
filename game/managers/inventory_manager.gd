extends Node
class_name InventoryManager

const INVENTORY_SIZE = 28
const HOTBAR_SIZE = 9

var inventory: Array = []
var hotbar: Array = []

func _enter_tree() -> void:
	EventSystem.INV_try_to_pickup_item.connect(try_to_pickup_item)
	EventSystem.INV_ask_to_update_inventory.connect(send_inventory)
	EventSystem.INV_switch_two_item_indexes.connect(switch_two_item_indexes)
	EventSystem.INV_delete_crafting_blueprints_costs.connect(delete_crafting_blueprints_costs)
	EventSystem.INV_add_item.connect(add_item)
	EventSystem.INV_delete_item_by_index.connect(delete_item_by_index)

func _ready() -> void:
	inventory.resize(INVENTORY_SIZE)
	hotbar.resize(HOTBAR_SIZE)
	# TODO delete later
	inventory[0] = ItemConfig.Keys.Axe
	
func send_inventory() -> void:
	EventSystem.INV_inventory_updated.emit(inventory)

func send_hotbar() -> void:
	EventSystem.INV_hotbar_updated.emit(hotbar)
	
func try_to_pickup_item(item_key: ItemConfig.Keys, destroy_pickupable: Callable) -> void:
	if not get_free_slots():
		return
	
	add_item(item_key)
	destroy_pickupable.call()

func get_free_slots() -> int:
	# count how many elements are null
	return inventory.count(null)

func delete_crafting_blueprints_costs(costs: Array[BlueprintCostData]) -> void:
	for cost in costs:
		for _a in cost.amount:
			delete_item(cost.item_key)

func delete_item_by_index(index: int, is_in_hotbar: bool) -> void:
	if is_in_hotbar:
		hotbar[index] = null;
		send_hotbar()
	else:
		inventory[index] = null
		send_inventory()

func delete_item(item_key: ItemConfig.Keys) -> void:
	var index = inventory.rfind(item_key)
	if index < 0:
		print(item_key, " not found in the inventory ", inventory)
		return

	inventory[index] = null
	send_inventory()

func add_item(item_key: ItemConfig.Keys) -> void:
	for i in inventory.size():
		if inventory[i] == null:
			inventory[i] = item_key
			send_inventory()
			return

func switch_two_item_indexes(idx1: int, idx1_is_in_hotbar: bool, idx2: int, idx2_is_in_hotbar: bool) -> void:
	var item1 = hotbar[idx1] if idx1_is_in_hotbar else inventory[idx1]
	var item2 = hotbar[idx2] if idx2_is_in_hotbar else inventory[idx2]

	if idx1_is_in_hotbar:
		hotbar[idx1] = item2
	else:
		inventory[idx1] = item2

	if idx2_is_in_hotbar:
		hotbar[idx2] = item1
	else:
		inventory[idx2] = item1

	send_inventory()
	send_hotbar()
