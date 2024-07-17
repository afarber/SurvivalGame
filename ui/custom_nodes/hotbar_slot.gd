extends InventorySlot
class_name HotbarSlot

const ACTIVE_COLOR = Color.WHITE
const INACTIVE_COLOR = Color(0.8, 0.8, 0.8, 0.6)

func _ready() -> void:
	$HotkeyTextureRect/HotkeyLabel.text = str(get_index() + 1)

func _can_drop_data(_at_position: Vector2, slot: Variant) -> bool:
	return ItemConfig.get_item_resource(slot.item_key).is_equippable

func set_active(active:bool) -> void:
	modulate = INACTIVE_COLOR if not active else ACTIVE_COLOR
