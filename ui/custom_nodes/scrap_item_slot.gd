extends TextureRect
class_name ScrapItemSlot

signal item_scrapped


func _can_drop_data(_at_position: Vector2, slot: Variant) -> bool:
	return slot is InventorySlot and not slot is StartingCookingSlot and not slot is FinalCookingSlot


func _drop_data(_at_position: Vector2, old_slot: Variant) -> void:
	if old_slot is InventorySlot:
		EventSystem.INV_delete_item_by_index.emit(old_slot.get_index(), old_slot is HotbarSlot)
		item_scrapped.emit()
