extends PlayerMenuBase

@onready var starting_cooking_slot: StartingCookingSlot = %StartingCookingSlot
@onready var cooking_progress_bar: TextureProgressBar = %CookingProgressBar
@onready var final_cooking_slot: FinalCookingSlot = %FinalCookingSlot


func close() -> void:
	EventSystem.PLY_unfreeze_player.emit()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	EventSystem.BUL_destroy_bulletin.emit(BulletinConfig.Keys.CookingMenu)
