extends HBoxContainer
class_name HotbarUi

func _enter_tree() -> void:
	EventSystem.INV_hotbar_updated.connect(update_hotbar)
	EventSystem.EQU_active_hotbar_slot_updated.connect(active_hotbar_slot_updated)

func update_hotbar(hotbar: Array) -> void:
	for slot in get_children():
		slot.set_item_key(hotbar[slot.get_index()])

# idx can be either integer or null, so do not specify the type
func active_hotbar_slot_updated(idx) -> void:
	for slot in get_children():
		slot.set_highlighted(slot.get_index() == idx)
