class_name StageConfig

enum Keys {
	Island
}

const STAGE_PATHS := {
	Keys.Island: "res://stages/island.tscn"
}

static func get_stage(key: Keys) -> Node:
	return load(STAGE_PATHS.get(key)).instantiate()
