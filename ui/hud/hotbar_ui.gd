extends HBoxContainer


func _enter_tree() -> void:
	EventSystem.INV_hotbar_updated.connect(update_hotbar)
	EventSystem.EQU_active_hotbar_slot_updated.connect(update_active_slot)
	EventSystem.EQU_unequip_item.connect(update_active_slot.bind(null))


func update_hotbar(hotbar:Array) -> void:
	for slot in get_children():
		slot.set_item_key(hotbar[slot.get_index()])


func update_active_slot(slot_index) -> void:
	for slot in get_children():
		slot.set_active(slot.get_index() == slot_index)
