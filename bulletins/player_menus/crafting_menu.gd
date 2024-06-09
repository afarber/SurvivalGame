extends PlayerMenuBase

@onready var crafting_button_container: GridContainer = %CraftingButtonContainer

@export var crafting_button_scene: PackedScene

func _ready() -> void:
	for craftable_item_key in ItemConfig.CRAFTABLE_ITEM_KEYS:
		var crafting_button = crafting_button_scene.instantiate()
		crafting_button_container.add_child(crafting_button)
		crafting_button.set_item_key(craftable_item_key)
	
	# Call the _ready() function in player_menu_base.gd
	super()
