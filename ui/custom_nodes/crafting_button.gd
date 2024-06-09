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
	button.pressed.connect(crafting_button_pressed)

func send_crafting_info() -> void:
	# Do not send when dragging the mouse
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		return
	EventSystem.INV_set_description_label.emit(display_name + "\n\n" + description)
	EventSystem.INV_set_extra_info_label.emit(requirements)

func hide_crafting_info() -> void:
	EventSystem.INV_set_description_label.emit("")
	EventSystem.INV_set_extra_info_label.emit("")

func crafting_button_pressed() -> void:
	EventSystem.INV_add_item.emit(item_key)

# Type not specified here for the param, because it can also be null
func set_item_key(_item_key) -> void:
	item_key = _item_key
	var item_resource:ItemResource = ItemConfig.get_item_resource(item_key)
	icon_texture_rect.texture = item_resource.icon
	display_name = item_resource.display_name
	description = item_resource.description
	var blueprint:CraftingBlueprintResource = ItemConfig.get_crafting_blueprint_resource(item_key)
	requirements = "Requirements\n"
	
	if blueprint.needs_multitool:
		requirements += "\nMultitool"
	if blueprint.needs_tinderbox:
		requirements += "\nTinderbox"

	for blueprint_cost in blueprint.costs:
		var cost_name := ItemConfig.get_item_resource(blueprint_cost.item_key).display_name
		requirements += "\n%s: %d" % [
			cost_name, 
			blueprint_cost.amount
		]
