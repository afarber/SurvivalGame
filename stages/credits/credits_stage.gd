extends Stage


func exit_to_menu() -> void:
	EventSystem.STA_change_stage.emit(StageConfig.Keys.MainMenu)


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		exit_to_menu()
