extends Area3D
class_name Hitbox


signal register_hit


@export var hit_audio_key := SFXConfig.Keys.TreeHit
@export var hit_particles_key := VFXConfig.Keys.HitParticlesWood


func take_hit(weapon_item_resource:WeaponItemResource) -> void:
	register_hit.emit(weapon_item_resource)
	EventSystem.SFX_play_dynamic_sfx.emit(hit_audio_key, global_position)
