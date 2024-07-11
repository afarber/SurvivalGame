extends InventorySlot
class_name FinalCookingSlot

signal cooked_food_taken

func _can_drop_data(_at_position: Vector2, slot : Variant) -> bool:
	return false
