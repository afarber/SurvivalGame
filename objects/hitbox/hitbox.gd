extends Area3D
class_name Hitbox

signal register_hit

func take_hit(weapon_item_resource: WeaponItemResource) -> void:
	register_hit.emit(weapon_item_resource)
