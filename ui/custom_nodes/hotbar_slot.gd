extends InventorySlot

class_name HotbarSlot

const ACTIVE_COLOR = Color.WHITE
const UNACTIVE_COLOR = Color(0.8, 0.8, 0.8, 0.6)

func _ready() -> void:
	$NumTextureRect/NumLabel.text = str(get_index() + 1)

# The origin_slot param is what the _get_drag_data returns
func _can_drop_data(at_position: Vector2, origin_slot: Variant) -> bool:
	if not origin_slot is InventorySlot:
		return false
		
	return ItemConfig.get_item_resource(origin_slot.item_key).is_equipable

func set_highlighted(enabled: bool) -> void:
	modulate = ACTIVE_COLOR if enabled else UNACTIVE_COLOR
