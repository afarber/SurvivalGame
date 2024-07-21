class_name SFXConfig


enum Keys {
	UIClick,
	ItemPickup,
	Craft,
	Build,
	Eat,
	WeaponSwoosh,
	TreeHit,
	BoulderHit,
	CowHurt,
	CowAttack,
	WolfHurt,
	WolfAttack,
	Footstep,
	JumpLand,
	GoInTent
}

const FILE_PATHS := {
	Keys.UIClick : "res://audio/sfx/ui_click.wav",
	Keys.ItemPickup : "res://audio/sfx/item_pickup.wav",
	Keys.Craft : "res://audio/sfx/craft.wav",
	Keys.Build : "res://audio/sfx/build.wav",
	Keys.Eat : "res://audio/sfx/eat.wav",
	Keys.WeaponSwoosh : "res://audio/sfx/weapon_swoosh.wav",
	Keys.TreeHit : "res://audio/sfx/tree_hit.wav",
	Keys.BoulderHit : "res://audio/sfx/boulder_hit.wav",
	Keys.CowHurt : "res://audio/sfx/cow_hurt.wav",
	Keys.CowAttack : "res://audio/sfx/cow_attack.wav",
	Keys.WolfHurt : "res://audio/sfx/wolf_hurt.wav",
	Keys.WolfAttack : "res://audio/sfx/wolf_attack.wav",
	Keys.Footstep : "res://audio/sfx/footstep.wav",
	Keys.JumpLand : "res://audio/sfx/jump_land.wav",
	Keys.GoInTent : "res://audio/sfx/go_in_tent.wav"
}

static func get_audio_stream(key:Keys) -> AudioStream:
	return load(FILE_PATHS.get(key))
