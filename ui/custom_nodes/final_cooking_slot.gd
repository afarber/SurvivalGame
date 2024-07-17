extends InventorySlot
class_name FinalCookingSlot

signal cooked_food_taken

func _can_drop_data(_at_position: Vector2, _slot : Variant) -> bool:
	return false
