extends Node
class_name PlayerStatsManager


const MAX_ENERGY = 100.0
const MAX_HEALTH = 100.0

var current_energy := MAX_ENERGY
var current_health := MAX_HEALTH


func _enter_tree() -> void:
	EventSystem.PLA_change_energy.connect(change_energy)
	EventSystem.PLA_change_health.connect(change_health)


func change_energy(amount:float) -> void:
	current_energy += amount
	
	if current_energy <= 0:
		change_health(current_energy)
	
	current_energy = clampf(current_energy, 0, MAX_ENERGY)
	EventSystem.PLA_energy_updated.emit(MAX_ENERGY, current_energy)


func change_health(amount:float) -> void:
	current_health += amount
	EventSystem.PLA_health_updated.emit(MAX_HEALTH, current_health)
	
	if current_health <= 0:
		EventSystem.PLA_freeze_player.emit()
		EventSystem.STA_change_stage.emit(StageConfig.Keys.MainMenu)
