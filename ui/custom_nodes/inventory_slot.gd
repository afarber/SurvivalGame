extends TextureRect
class_name InventorySlot


@onready var icon_texture_rect: TextureRect = $MarginContainer/IconTextureRect


# Type not specified here for the var, because it can also be null
var item_key
var display_name
var description


func _enter_tree() -> void:
	mouse_entered.connect(send_description)
	mouse_exited.connect(hide_description)


func send_description() -> void:
	# Do not send when dragging the mouse
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		return

	if display_name and description:
		EventSystem.INV_set_item_info_label.emit(display_name + "\n\n" + description)
	else:
		EventSystem.INV_set_item_info_label.emit("")


func hide_description() -> void:
	EventSystem.INV_set_item_info_label.emit("")


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

	var item_resource:ItemResource = ItemConfig.get_item_resource(item_key)
	icon_texture_rect.texture = item_resource.icon
	display_name = item_resource.display_name
	description = item_resource.description


func _get_drag_data(_at_position: Vector2) -> Variant:
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
		EventSystem.SFX_play_sfx.emit(SFXConfig.Keys.UIClick)
		# return this item slot as the thing to be dragged
		return self
	
	# the slot item is not set and thus cannot be dragged
	return null


func _can_drop_data(_at_position: Vector2, slot: Variant) -> bool:
	# when the inventory slot is occupied by an item and the item is equippable, 
	# then swap it with the item dragged from the hotbar
	if item_key != null:
		if slot is HotbarSlot:
			return ItemConfig.get_item_resource(item_key).is_equippable
		
		if slot is StartingCookingSlot:
			return ItemConfig.get_item_resource(item_key).cooking_recipe_resource != null
		
		if slot is FinalCookingSlot:
			return false
	
	return slot is InventorySlot


func _drop_data(_at_position: Vector2, old_slot: Variant) -> void:
	if old_slot is StartingCookingSlot:
		var temp_own_key = item_key
		EventSystem.INV_add_item_by_index.emit(old_slot.item_key, get_index(), self is HotbarSlot)
		old_slot.set_item_key(temp_own_key)
		old_slot.starting_ingredient_disabled.emit()
	
	elif old_slot is FinalCookingSlot:
		EventSystem.INV_add_item_by_index.emit(old_slot.item_key, get_index(), self is HotbarSlot)
		old_slot.set_item_key(null)
		old_slot.cooked_food_taken.emit()
	
	else:
		EventSystem.INV_switch_two_inventory_item_indexes.emit(
			old_slot.get_index(),
			old_slot is HotbarSlot,
			get_index(),
			self is HotbarSlot
			)
	
	EventSystem.SFX_play_sfx.emit(SFXConfig.Keys.UIClick)
