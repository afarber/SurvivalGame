extends Node


var active_slot
var hotbar:Array


func _enter_tree() -> void:
	EventSystem.INV_hotbar_updated.connect(hotbar_updated)
	EventSystem.EQU_hotkey_pressed.connect(hotkey_pressed)
	EventSystem.EQU_delete_equipped_item.connect(delete_equipped_item)


func _ready() -> void:
	EventSystem.EQU_active_hotbar_slot_updated.emit(null)


func hotbar_updated(_hotbar:Array) -> void:
	hotbar = _hotbar
	
	if active_slot != null and hotbar[active_slot] == null:
		EventSystem.EQU_unequip_item.emit()
		active_slot = null


func hotkey_pressed(hotkey:int) -> void:
	var hotkey_index := hotkey - 1
	
	if hotbar[hotkey_index] == null:
		return
	
	if hotkey_index != active_slot:
		active_slot = hotkey_index
		EventSystem.EQU_equip_item.emit(hotbar[hotkey_index])
		EventSystem.EQU_active_hotbar_slot_updated.emit(hotkey_index)
	
	else:
		active_slot = null
		EventSystem.EQU_unequip_item.emit()


func delete_equipped_item() -> void:
	EventSystem.INV_delete_item_by_index.emit(active_slot, true)
	EventSystem.EQU_active_hotbar_slot_updated.emit(null)
	active_slot = null
