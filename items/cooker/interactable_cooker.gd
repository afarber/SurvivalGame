extends Interactable
class_name InteractableCooker

@onready var cooking_timer: Timer = $CookingTimer
@onready var food_visuals_holder: Marker3D = $FoodVisualsHolder
@onready var gpu_particles: GPUParticles3D = $GPUParticles3D
@onready var omni_light: OmniLight3D = $OmniLight3D

func start_interaction() -> void:
	EventSystem.BUL_create_bulletin.emit(BulletinConfig.Keys.CookingMenu)
