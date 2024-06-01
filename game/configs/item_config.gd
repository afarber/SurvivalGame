class_name ItemConfig

enum Keys {
	Stick,
	Stone,
	Plant
}

const ITEM_RESOURCE_PATHS := {
	Keys.Stick: "res://resources/item_resources/stick_resource.tres"
}

static func get_resource(key: Keys) -> ItemResource:
	return load(ITEM_RESOURCE_PATHS.get(key))
