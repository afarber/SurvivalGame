extends HBoxContainer

func _enter_tree() -> void:
	EventSystem.INV_hotbar_updated.connect(update_hotbar)

func update_hotbar(hotbar: Array) -> void:
	for slot in get_children():
		slot.set_item_key(hotbar[slot.get_index()])
