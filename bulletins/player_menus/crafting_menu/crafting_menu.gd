extends PlayerMenuBase


@onready var craft_button_container: GridContainer = %CraftButtonContainer

@export var craft_button_scene:PackedScene


func _ready() -> void:
	for craftable_item_key in ItemConfig.CRAFTABLE_ITEM_KEYS:
		var craft_button := craft_button_scene.instantiate()
		craft_button_container.add_child(craft_button)
		craft_button.set_item_key(craftable_item_key)
		# TODO remove
		craft_button.button.mouse_entered.connect(show_crafting_info.bind(craft_button.item_key))
		craft_button.button.mouse_exited.connect(hide_crafting_info)
		craft_button.button.pressed.connect(craft_button_pressed.bind(craft_button.item_key))
	
	super()


func update_inventory(inventory:Array) -> void:
	super(inventory)
	
	update_craft_button_disables(inventory)


func update_craft_button_disables(inventory:Array) -> void:
	for craft_button in craft_button_container.get_children():
		var crafting_blueprint := ItemConfig.get_crafting_blueprint_resource(craft_button.item_key)
		var disable_button := false
		
		if crafting_blueprint.needs_multitool and not ItemConfig.Keys.Multitool in inventory:
			disable_button = true
		
		elif crafting_blueprint.needs_tinderbox and not ItemConfig.Keys.Tinderbox in inventory:
			disable_button = true
		
		else:
			for cost_data in crafting_blueprint.costs:
				if inventory.count(cost_data.item_key) < cost_data.amount:
					disable_button = true
					break
		
		craft_button.button.disabled = disable_button


func show_crafting_info(item_key:ItemConfig.Keys) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		return
	
	var item_resource := ItemConfig.get_item_resource(item_key)
	item_info_label.text = item_resource.display_name + "\n" + item_resource.description
	extra_info_label.text = "Requirements:"
	
	var blueprint := ItemConfig.get_crafting_blueprint_resource(item_key)
	for cost_resource in blueprint.costs:
		var cost_item_name := ItemConfig.get_item_resource(cost_resource.item_key).display_name
		extra_info_label.text += "\n%s: %d" % [cost_item_name, cost_resource.amount]
	
	if blueprint.needs_multitool:
		extra_info_label.text += "\nMultitool"
	
	if blueprint.needs_tinderbox:
		extra_info_label.text += "\nTinderbox"


func hide_crafting_info() -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		return
	
	item_info_label.text = ""
	extra_info_label.text = ""


func craft_button_pressed(item_key:ItemConfig.Keys) -> void:
	EventSystem.INV_delete_blueprint_costs_from_inventory.emit(ItemConfig.get_crafting_blueprint_resource(item_key).costs)
	EventSystem.INV_add_item_to_inventory.emit(item_key)
	EventSystem.SFX_play_sfx.emit(SFXConfig.Keys.Craft)
