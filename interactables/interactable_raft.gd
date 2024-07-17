extends Interactable


func start_interaction() -> void:
	EventSystem.STA_change_stage.emit(StageConfig.Keys.Credits)
