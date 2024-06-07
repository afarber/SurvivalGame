extends TextureRect

class_name InventorySlot

@onready var icon_texture_rect: TextureRect = $MarginContainer/IconTextureRect

# Type not specified here for the var, because it can also be null
var item_key
var display_name
var description

func _enter_tree() -> void:
	mouse_entered.connect(send_display_name)
	mouse_exited.connect(hide_item_info)

func send_display_name() -> void:
	# Do not send the item display_name if dragging the mouse
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		return

	if display_name and description:
		EventSystem.INV_show_item_info.emit(display_name + "\n\n" + description)
	else:
		EventSystem.INV_show_item_info.emit("")

func hide_item_info() -> void:
	EventSystem.INV_show_item_info.emit("")

# Type not specified here for the param, because it can also be null
func set_item_key(_item_key) -> void:
	item_key = _item_key
	update()

func update() -> void:
	if item_key == null:
		icon_texture_rect.texture = null
		display_name = null
		description = null
		return

	var resource:ItemResource = ItemConfig.get_resource(item_key)
	icon_texture_rect.texture = resource.icon
	display_name = resource.display_name
	description = resource.description

func _get_drag_data(at_position: Vector2) -> Variant:
	if item_key != null:
		var drag_preview := Control.new()
		var texture_rect := TextureRect.new()
		texture_rect.modulate = Color(1, 1, 1, 0.75)
		texture_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		texture_rect.texture = icon_texture_rect.texture
		texture_rect.custom_minimum_size = Vector2(80, 80)
		# center-align the texture_rect, so that mouse pointer is in its middle
		texture_rect.position = -0.5 * texture_rect.custom_minimum_size
		drag_preview.add_child(texture_rect)
		set_drag_preview(drag_preview)
		# return this item slot as the thing to be dragged
		return self
	
	# the slot item is not set and thus cannot be dragged
	return null

# The origin_slot param is what the _get_drag_data returns
func _can_drop_data(at_position: Vector2, origin_slot: Variant) -> bool:
	return origin_slot is InventorySlot

func _drop_data(at_position: Vector2, origin_slot: Variant) -> void:
	EventSystem.INV_switch_two_item_indexes.emit(origin_slot.get_index(), get_index())
