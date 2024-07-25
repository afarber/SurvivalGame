extends Interactable
class_name InteractableSleepPoint


func start_interaction() -> void:
	EventSystem.PLA_player_sleep.emit()
	EventSystem.SFX_play_sfx.emit(SFXConfig.Keys.GoInTent)
