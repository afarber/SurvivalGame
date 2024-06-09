extends TextureRect

# Type not specified here for the var, because it can also be null
var item_key
var display_name
var description
var requirements

@onready var icon_texture_rect: TextureRect = $MarginContainer/IconTextureRect

@onready var button: Button = $Button

func _ready() -> void:
	button.mouse_entered.connect(send_crafting_info)
	button.mouse_exited.connect(hide_crafting_info)

func send_crafting_info() -> void:
	print("crafting button: send_crafting_info")
	EventSystem.INV_set_description_label.emit(display_name + "\n\n" + description)
	EventSystem.INV_set_extra_info_label.emit(requirements)

func hide_crafting_info() -> void:
	print("crafting button: send_crafting_info")
	EventSystem.INV_set_description_label.emit("")
	EventSystem.INV_set_extra_info_label.emit("")

# Type not specified here for the param, because it can also be null
func set_item_key(_item_key) -> void:
	item_key = _item_key
	var item_resource:ItemResource = ItemConfig.get_item_resource(item_key)
	icon_texture_rect.texture = item_resource.icon
	display_name = item_resource.display_name
	description = item_resource.description
	requirements = "TODO"
