extends TextureRect

class_name InventorySlot

@onready var icon_texture_rect: TextureRect = $MarginContainer/IconTextureRect

# Type not specified here for the var, because it can also be null
var item_key

# Type not specified here for the param, because it can also be null
func set_item_key(_item_key) -> void:
	item_key = _item_key
	update_icon()

func update_icon() -> void:
	if item_key == null:
		icon_texture_rect.texture = null
		return
	icon_texture_rect.texture = ItemConfig.get_resource(item_key).icon

func _get_drag_data(at_position: Vector2) -> Variant:
	if item_key:
		# return this item slot as the thing to be dragged
		return self
	
	# the slot item is not set and thus cannot be dragged
	return null

# The origin_slot param is what the _get_drag_data returns
func _can_drop_data(at_position: Vector2, origin_slot: Variant) -> bool:
	return slot is InventorySlot

func _drop_data(at_position: Vector2, origin_slot: Variant) -> void:
	EventSystem.INV_switch_two_item_indexes.emit(origin_slot.get_index(), )
