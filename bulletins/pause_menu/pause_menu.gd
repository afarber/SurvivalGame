extends FadingBulletin
class_name PauseMenu


const BUTTON_FADE_TIME = 0.15

@onready var resume_button: Button = $VBoxContainer/ResumeButton
@onready var settings_button: Button = $VBoxContainer/SettingsButton
@onready var exit_button: Button = $VBoxContainer/ExitButton


func _ready() -> void:
	resume_button.modulate = TRANSPARENT_COLOR
	settings_button.modulate = TRANSPARENT_COLOR
	exit_button.modulate = TRANSPARENT_COLOR
	
	get_tree().paused = true
	
	EventSystem.SFX_play_sfx.emit(SFXConfig.Keys.UIClick)
	
	super()


func fade_in() -> void:
	super()
	
	var tween := create_tween()
	tween.tween_property(resume_button, "modulate", Color.WHITE, BUTTON_FADE_TIME)
	tween.tween_property(settings_button, "modulate", Color.WHITE, BUTTON_FADE_TIME)
	tween.tween_property(exit_button, "modulate", Color.WHITE, BUTTON_FADE_TIME)


func _on_resume_button_pressed() -> void:
	EventSystem.HUD_show_hud.emit()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
	fade_out()


func _on_settings_button_pressed() -> void:
	EventSystem.BUL_create_bulletin.emit(BulletinConfig.Keys.SettingsMenu, true)
	fade_out()


func _on_exit_button_pressed() -> void:
	EventSystem.STA_change_stage.emit(StageConfig.Keys.MainMenu)
