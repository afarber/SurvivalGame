extends Interactable
class_name InteractableCooker

@onready var cooking_timer: Timer = $CookingTimer
@onready var food_visuals_holder: Marker3D = $FoodVisualsHolder
@onready var fire_particles: GPUParticles3D = $GPUParticles3D
@onready var fire_light: OmniLight3D = $OmniLight3D

var cooking_recipe: CookingRecipeResource

enum CookingStates {
	Inactive,
	ReadyToCook,
	Cooking,
	Cooked
}

var state := CookingStates.Inactive

func start_interaction() -> void:
	EventSystem.BUL_create_bulletin.emit(
		BulletinConfig.Keys.CookingMenu,
		[
			cooking_recipe,
			(cooking_recipe.cooking_time - cooking_timer.time_left) if cooking_recipe else 0,
			self
		]
		)
