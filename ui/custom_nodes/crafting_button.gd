extends TextureRect

# Type not specified here for the var, because it can also be null
var item_key

@onready var icon_texture_rect: TextureRect = $MarginContainer/IconTextureRect

# Type not specified here for the param, because it can also be null
func set_item_key(_item_key) -> void:
	item_key = _item_key
	var item_resource:ItemResource = ItemConfig.get_item_resource(item_key)
	icon_texture_rect.texture = item_resource.icon
	
