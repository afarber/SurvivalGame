extends TextureRect
class_name CraftButton

@onready var icon_texture_rect: TextureRect = $MarginContainer/IconTextureRect
@onready var button: Button = $Button

var item_key:ItemConfig.Keys

func set_item_key(_item_key) -> void:
	item_key = _item_key
	update_icon()

func update_icon() -> void:
	if item_key == null:
		icon_texture_rect.texture = null
		return
	
	icon_texture_rect.texture = ItemConfig.get_item_resource(item_key).icon

