extends Node
class_name PlayerStatsManager

const MAX_ENERGY = 100
var current_energy := MAX_ENERGY

func _enter_tree() -> void:
	EventSystem.PLY_change_energy.connect(change_energy)

func change_energy(energy_change: float) -> void:
	current_energy += energy_change
	EventSystem.PLY_energy_updated(MAX_ENERGY, current_energy)
