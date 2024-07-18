extends TextureRect
class_name CraftButton
# TODO extends InventorySlot


@onready var icon_texture_rect: TextureRect = $MarginContainer/IconTextureRect
@onready var button: Button = $Button

var item_key:ItemConfig.Keys
var display_name
var description
var requirements


func _ready() -> void:
	button.mouse_entered.connect(send_crafting_info)
	button.mouse_exited.connect(hide_crafting_info)


func send_crafting_info() -> void:
	# Do not send when dragging the mouse
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		return
	EventSystem.INV_set_item_info_label.emit(display_name + "\n\n" + description)
	EventSystem.INV_set_extra_info_label.emit(requirements)


func hide_crafting_info() -> void:
	EventSystem.INV_set_item_info_label.emit("")
	EventSystem.INV_set_extra_info_label.emit("")


func set_item_key(_item_key) -> void:
	item_key = _item_key
	update()


func update() -> void:
	if item_key == null:
		icon_texture_rect.texture = null
		display_name = null
		description = null
		requirements = null
		return
	
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
