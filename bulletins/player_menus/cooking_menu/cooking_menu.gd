extends PlayerMenuBase

@onready var starting_cooking_slot: StartingCookingSlot = %StartingCookingSlot
@onready var cooking_progress_bar: TextureProgressBar = %CookingProgressBar
@onready var final_cooking_slot: FinalCookingSlot = %FinalCookingSlot
@onready var cook_button: Button = %CookButton


var cooking_recipe: CookingRecipeResource
var time_cooked: float
var interactable_cooker: InteractableCooker
var cooking_state : InteractableCooker.CookingStates


func initialize(extra_arg) -> void:
	if not extra_arg or not extra_arg is Array:
		return
	
	cooking_recipe = extra_arg[0]
	time_cooked = extra_arg[1]
	interactable_cooker = extra_arg[2]
	cooking_state = extra_arg[3]


func _ready() -> void:
	starting_cooking_slot.mouse_entered.connect(show_item_info.bind(starting_cooking_slot))
	starting_cooking_slot.mouse_exited.connect(hide_item_info)
	final_cooking_slot.mouse_entered.connect(show_item_info.bind(final_cooking_slot))
	final_cooking_slot.mouse_exited.connect(hide_item_info)
	
	starting_cooking_slot.starting_ingredient_enabled.connect(uncooked_item_added)
	starting_cooking_slot.starting_ingredient_disabled.connect(uncooked_item_removed)
	
	final_cooking_slot.cooked_food_taken.connect(interactable_cooker.cooked_item_removed)
	
	if cooking_state == InteractableCooker.CookingStates.ReadyToCook:
		starting_cooking_slot.set_item_key(cooking_recipe.uncooked_item)
		cook_button.disabled = false
	
	elif cooking_state == InteractableCooker.CookingStates.Cooking:
		starting_cooking_slot.set_item_key(cooking_recipe.uncooked_item)
		start_cooking()
	
	elif cooking_state == InteractableCooker.CookingStates.Cooked:
		final_cooking_slot.set_item_key(cooking_recipe.cooked_item)
	
	super()


func uncooked_item_added() -> void:
	cook_button.disabled = false
	cooking_recipe = ItemConfig.get_item_resource(starting_cooking_slot.item_key).cooking_recipe
	time_cooked = 0
	interactable_cooker.uncooked_item_added(cooking_recipe)


func uncooked_item_removed() -> void:
	cook_button.disabled = true
	cooking_recipe = null
	time_cooked = 0
	interactable_cooker.uncooked_item_removed()


func start_cooking() -> void:
	starting_cooking_slot.cooking_in_progress = true
	cook_button.disabled = true
	cooking_progress_bar.value = time_cooked / cooking_recipe.cooking_time
	
	var tween := create_tween()
	tween.tween_property(
		cooking_progress_bar,
		"value",
		cooking_progress_bar.max_value,
		cooking_recipe.cooking_time - time_cooked
	)
	
	tween.tween_callback(finished_cooking)
	
	if cooking_state != InteractableCooker.CookingStates.Cooking:
		interactable_cooker.start_cooking()
		EventSystem.SFX_play_sfx.emit(SFXConfig.Keys.UIClick)


func finished_cooking() -> void:
	final_cooking_slot.set_item_key(cooking_recipe.cooked_item)
	starting_cooking_slot.set_item_key(null)
	cooking_progress_bar.value = 0
	starting_cooking_slot.cooking_in_progress = false


func close() -> void:
	EventSystem.BUL_destroy_bulletin.emit(BulletinConfig.Keys.CookingMenu)
	EventSystem.PLA_unfreeze_player.emit()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	EventSystem.SFX_play_sfx.emit(SFXConfig.Keys.UIClick)
