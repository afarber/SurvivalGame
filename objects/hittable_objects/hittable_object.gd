extends Node3D
class_name HittableObject

@export var attributes: HittableObjectAttributes

var current_health: float

func _ready() -> void:
	current_health = attributes.max_health

func register_hit(weapon_item_resource: WeaponItemResource) -> void:
	if not attributes.weapon_filter.is_empty() and not weapon_item_resource.item_key in attributes.weapon_filter:
		return
	
	current_health -= weapon_item_resource.damage
	if current_health <= 0:
		die()

func die() -> void:
	queue_free()
