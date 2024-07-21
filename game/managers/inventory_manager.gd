extends Node
class_name InventoryManager


const INVENTORY_SIZE = 28
var inventory := []

const HOTBAR_SIZE = 9
var hotbar := []


func _enter_tree() -> void:
	EventSystem.INV_try_to_pickup_item.connect(try_to_pickup_item)
	EventSystem.INV_ask_update_inventory.connect(send_inventory)
	EventSystem.INV_switch_two_inventory_item_indexes.connect(switch_two_item_indexes)
	EventSystem.INV_add_item_to_inventory.connect(add_item)
	EventSystem.INV_delete_blueprint_costs_from_inventory.connect(delete_blueprint_costs)
	EventSystem.INV_delete_item_by_index.connect(delete_item_by_index)
	EventSystem.INV_add_item_by_index.connect(add_item_by_index)


func _ready() -> void:
	inventory.resize(INVENTORY_SIZE)
	hotbar.resize(HOTBAR_SIZE)


func send_inventory() -> void:
	EventSystem.INV_inventory_updated.emit(inventory)


func try_to_pickup_item(item_key:ItemConfig.Keys, destroy_pickuppable:Callable) -> void:
	if not get_free_slots():
		return
	
	add_item(item_key)
	destroy_pickuppable.call()


func switch_two_item_indexes(slot1:int, slot1_is_hotbar_slot:bool, slot2:int, slot2_is_hotbar_slot:bool) -> void:
	var item1 = inventory[slot1] if not slot1_is_hotbar_slot else hotbar[slot1]
	var item2 = inventory[slot2] if not slot2_is_hotbar_slot else hotbar[slot2]
	
	if not slot1_is_hotbar_slot:
		inventory[slot1] = item2
	else:
		hotbar[slot1] = item2
	
	if not slot2_is_hotbar_slot:
		inventory[slot2] = item1
	else:
		hotbar[slot2] = item1
	
	EventSystem.INV_inventory_updated.emit(inventory)
	EventSystem.INV_hotbar_updated.emit(hotbar)


func get_free_slots() -> int:
	var free_slots := 0
	for slot in inventory:
		if not slot:
			free_slots += 1
	
	return free_slots


func add_item(item_key:ItemConfig.Keys) -> void:
	for i in inventory.size():
		if inventory[i] == null:
			inventory[i] = item_key
			break
	
	EventSystem.INV_inventory_updated.emit(inventory)


func delete_blueprint_costs(costs:Array[CraftingBlueprintCostDataResource]) -> void:
	for cost in costs:
		for i in cost.amount:
			delete_item(cost.item_key)


func delete_item(item_key:ItemConfig.Keys) -> void:
	if not inventory.has(item_key):
		return
	
	inventory[inventory.rfind(item_key)] = null


func delete_item_by_index(index:int, is_in_hotbar:bool) -> void:
	if is_in_hotbar:
		hotbar[index] = null
		EventSystem.INV_hotbar_updated.emit(hotbar)
	
	else:
		inventory[index] = null
		EventSystem.INV_inventory_updated.emit(inventory)


func add_item_by_index(item_key:ItemConfig.Keys, index:int, is_in_hotbar:bool) -> void:
	if is_in_hotbar:
		hotbar[index] = item_key
		EventSystem.INV_hotbar_updated.emit(hotbar)
	
	else:
		inventory[index] = item_key
		EventSystem.INV_inventory_updated.emit(inventory)

