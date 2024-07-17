@tool
extends OmniLight3D
class_name FlickeringLight


var noise := FastNoiseLite.new()

@export var min_energy := 0.9
@export var max_energy := 1.5
@export var speed := 1.0


func _ready() -> void:
	noise.frequency = speed * 0.001
	noise.seed = randi()


func _process(_delta: float) -> void:
	light_energy = min_energy + noise.get_noise_1d(Time.get_ticks_msec()) * (max_energy - min_energy)
