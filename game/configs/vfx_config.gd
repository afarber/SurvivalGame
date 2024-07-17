class_name VFXConfig

enum Keys {
	HitParticlesWood,
	HitParticlesStone,
	HitParticlesBlood
}

const FILE_PATHS := {
	Keys.HitParticlesWood : "res://particles/hit_particles_wood.tscn",
	Keys.HitParticlesStone : "res://particles/hit_particles_stone.tscn",
	Keys.HitParticlesBlood : "res://particles/hit_particles_blood.tscn"
}

static func get_vfx(key:Keys) -> PackedScene:
	return load(FILE_PATHS.get(key))
