extends PlayerMenuBase
class_name CraftingMenu

@onready var crafting_button_container: GridContainer = %CraftingButtonContainer

@export var crafting_button_scene: PackedScene

func _ready() -> void:
	for craftable_item_key in ItemConfig.CRAFTABLE_ITEM_KEYS:
		var crafting_button = crafting_button_scene.instantiate()
		crafting_button_container.add_child(crafting_button)
		crafting_button.set_item_key(craftable_item_key)

	# Call the _ready() function in player_menu_base.gd
	super()

func update_inventory(inventory: Array) -> void:
	# update the inventory slots first
	super(inventory)

	for crafting_button in crafting_button_container.get_children():
		var costs := ItemConfig.get_crafting_blueprint_resource(crafting_button.item_key).costs
		var disable_button := false
		for cost in costs:
			if inventory.count(cost.item_key) < cost.amount:
				disable_button = true
				break
		crafting_button.button.disabled = disable_button
		
