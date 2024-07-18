extends PlayerMenuBase
class_name CraftingMenu


@onready var craft_button_container: GridContainer = %CraftButtonContainer

@export var craft_button_scene:PackedScene


func _ready() -> void:
	for craftable_item_key in ItemConfig.CRAFTABLE_ITEM_KEYS:
		var craft_button := craft_button_scene.instantiate()
		craft_button_container.add_child(craft_button)
		craft_button.set_item_key(craftable_item_key)
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

func craft_button_pressed(item_key:ItemConfig.Keys) -> void:
	EventSystem.INV_delete_blueprint_costs_from_inventory.emit(ItemConfig.get_crafting_blueprint_resource(item_key).costs)
	EventSystem.INV_add_item_to_inventory.emit(item_key)
	EventSystem.SFX_play_sfx.emit(SFXConfig.Keys.Craft)
