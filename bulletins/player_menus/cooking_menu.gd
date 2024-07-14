extends PlayerMenuBase
class_name CookingMenu

@onready var starting_cooking_slot: StartingCookingSlot = %StartingCookingSlot
@onready var cooking_progress_bar: TextureProgressBar = %CookingProgressBar
@onready var final_cooking_slot: FinalCookingSlot = %FinalCookingSlot
@onready var cooking_button: Button = %CookingButton

var cooking_recipe: CookingRecipeResource
var time_cooked: float
var campfire: Node

func initialize(extra_arg) -> void:
	if not extra_arg or not extra_arg is Array:
		return
	cooking_recipe = extra_arg[0]
	time_cooked = extra_arg[1]
	campfire = extra_arg[2]

func _ready() -> void:
	starting_cooking_slot.starting_ingredient_enabled.connect(uncooked_item_added)
	starting_cooking_slot.starting_ingredient_disabled.connect(uncooked_item_removed)

func uncooked_item_added() -> void:
	cooking_button.disabled = false
	cooking_recipe = ItemConfig.get_item_resource(starting_cooking_slot.item_key).cooking_recipe
	time_cooked = 0

func uncooked_item_removed() -> void:
	cooking_button.disabled = true
	cooking_recipe = null
	time_cooked = 0

func start_cooking() -> void:
	pass

func close() -> void:
	EventSystem.PLY_unfreeze_player.emit()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	EventSystem.BUL_destroy_bulletin.emit(BulletinConfig.Keys.CookingMenu)
