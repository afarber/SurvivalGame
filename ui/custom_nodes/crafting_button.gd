extends TextureRect
class_name CraftingButton

var item_key: ItemConfig.Keys
var display_name: String
var description: String
var requirements: String

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
	var costs := ItemConfig.get_crafting_blueprint_resource(item_key).costs
	EventSystem.INV_delete_crafting_blueprints_costs.emit(costs)
	EventSystem.INV_add_item.emit(item_key)

func set_item_key(_item_key: ItemConfig.Keys) -> void:
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

	for cost in blueprint.costs:
		var cost_name := ItemConfig.get_item_resource(cost.item_key).display_name
		requirements += "\n%s: %d" % [
			cost_name, 
			cost.amount
		]
