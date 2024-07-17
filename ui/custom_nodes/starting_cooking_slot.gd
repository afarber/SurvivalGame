extends InventorySlot
class_name StartingCookingSlot


signal starting_ingredient_enabled
signal starting_ingredient_disabled

var cooking_in_progress := false


func _get_drag_data(_at_position: Vector2):
	if cooking_in_progress:
		return null
	
	if item_key != null:
		var drag_preview := TextureRect.new()
		drag_preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		drag_preview.texture = icon_texture_rect.texture
		drag_preview.size = Vector2(80, 80)
		drag_preview.modulate.a = 0.7
		set_drag_preview(drag_preview)
		EventSystem.SFX_play_sfx.emit(SFXConfig.Keys.UIClick)
		return self
	
	return null


func _can_drop_data(_at_position: Vector2, slot : Variant) -> bool:
	if item_key != null:
		return false
	
	if ItemConfig.get_item_resource(slot.item_key).cooking_recipe == null:
		return false
	
	return slot is InventorySlot


func _drop_data(_at_position: Vector2, old_slot : Variant) -> void:
	set_item_key(old_slot.item_key)
	EventSystem.INV_delete_item_by_index.emit(old_slot.get_index(), old_slot is HotbarSlot)
	starting_ingredient_enabled.emit()
	EventSystem.SFX_play_sfx.emit(SFXConfig.Keys.UIClick)
