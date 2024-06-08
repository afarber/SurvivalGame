class_name ItemConfig

enum Keys {
	# pickuppables
	Stick,
	Stone,
	Plant,
	Mushroom,
	Fruit,
	Log,
	Coal,
	Flintstone,
	RawMeat,
	CookedMeat,

	# craftables
	Axe,
	Pickaxe,
	Campfire,
	Multitool,
	Rope,
	Tinderbox,
	Torch,
	Tent,
	Raft
}

const CRAFTABLE_ITEM_KEYS: Array[Keys] = [
	Keys.Axe,
	#Keys.Pickaxe,
	#Keys.Campfire,
	#Keys.Multitool,
	Keys.Rope,
	#Keys.Tinderbox,
	#Keys.Torch,
	#Keys.Tent,
	#Keys.Raft
]

const ITEM_RESOURCES := {
	Keys.Stick : "res://resources/items/stick_item_resource.tres",
	Keys.Stone : "res://resources/items/stone_item_resource.tres",
	Keys.Plant : "res://resources/items/plant_item_resource.tres",
	Keys.Mushroom : "res://resources/items/mushroom_item_resource.tres",
	Keys.Fruit : "res://resources/items/fruit_item_resource.tres",
	Keys.Flintstone : "res://resources/items/flintstone_item_resource.tres",
	
	Keys.Axe : "res://resources/items/axe_item_resource.tres",
	Keys.Rope : "res://resources/items/rope_item_resource.tres",
	Keys.Pickaxe : "res://resources/items/pickaxe_item_resource.tres",
	Keys.Torch : "res://resources/items/torch_item_resource.tres",
	
	Keys.Log : "res://resources/items/log_item_resource.tres",
	Keys.Coal : "res://resources/items/coal_item_resource.tres",
	Keys.RawMeat : "res://resources/items/raw_meat_item_resource.tres",
	Keys.CookedMeat : "res://resources/items/cooked_meat_item_resource.tres",
	
	Keys.Tent : "res://resources/items/tent_item_resource.tres",
	Keys.Campfire : "res://resources/items/campfire_item_resource.tres",
	Keys.Raft : "res://resources/items/raft_item_resource.tres",
	Keys.Multitool : "res://resources/items/multitool_item_resource.tres",
	Keys.Tinderbox : "res://resources/items/tinderbox_item_resource.tres"
}

static func get_item_resource(item_key:Keys) -> ItemResource:
	return load(ITEM_RESOURCES[item_key])
