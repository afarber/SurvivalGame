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


const CRAFTABLE_ITEM_KEYS:Array[Keys] = [
	Keys.Axe,
	Keys.Pickaxe,
	Keys.Campfire,
	Keys.Multitool,
	Keys.Rope,
	Keys.Tinderbox,
	Keys.Torch,
	Keys.Tent,
	Keys.Raft
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



const CRAFTING_BLUEPRINT_RESOURCES := {
	Keys.Axe : "res://resources/crafting_blueprints/axe_blueprint.tres",
	Keys.Rope : "res://resources/crafting_blueprints/rope_blueprint.tres",
	Keys.Pickaxe : "res://resources/crafting_blueprints/pickaxe_blueprint.tres",
	Keys.Campfire : "res://resources/crafting_blueprints/campfire_blueprint.tres",
	Keys.Multitool :"res://resources/crafting_blueprints/multitool_blueprint.tres" ,
	Keys.Raft : "res://resources/crafting_blueprints/raft_blueprint.tres",
	Keys.Tent : "res://resources/crafting_blueprints/tent_blueprint.tres",
	Keys.Tinderbox : "res://resources/crafting_blueprints/tinderbox_blueprint.tres",
	Keys.Torch : "res://resources/crafting_blueprints/torch_blueprint.tres"
}

static func get_crafting_blueprint_resource(item_key:Keys) -> CraftingBlueprintResource:
	return load(CRAFTING_BLUEPRINT_RESOURCES[item_key])


const EQUIPPABLE_ITEM_SCENES := {
	Keys.Axe : "res://items/equippables/equippable_axe.tscn",
	Keys.Pickaxe : "res://items/equippables/equippable_pickaxe.tscn",
	Keys.Mushroom : "res://items/equippables/equippable_mushroom.tscn",
	Keys.Tent : "res://items/equippables/equippable_tent.tscn",
	Keys.Campfire : "res://items/equippables/equippable_campfire.tscn",
	Keys.Fruit : "res://items/equippables/equippable_fruit.tscn",
	Keys.CookedMeat : "res://items/equippables/equippable_cooked_meat.tscn",
	Keys.Raft : "res://items/equippables/equippable_raft.tscn",
	Keys.Torch : "res://items/equippables/equippable_torch.tscn"
}

static func get_equippable_item_scene(item_key:Keys) -> PackedScene:
	return load(EQUIPPABLE_ITEM_SCENES[item_key]) 



const PICKUPPABLE_ITEM_SCENES := {
	Keys.Log : "res://interactables/pickuppables/rigid_pickuppable_log.tscn",
	Keys.Coal : "res://interactables/pickuppables/rigid_pickuppable_coal.tscn",
	Keys.RawMeat : "res://interactables/pickuppables/rigid_pickuppable_raw_meat.tscn",
	Keys.Flintstone : "res://interactables/pickuppables/rigid_pickuppable_flintstone.tscn"
}

static func get_pickuppable_item_scene(item_key:Keys) -> PackedScene:
	return load(PICKUPPABLE_ITEM_SCENES[item_key])



const CONSTRUCTABLE_SCENES := {
	Keys.Tent : "res://objects/constructables/constructable_tent.tscn",
	Keys.Campfire : "res://objects/constructables/constructable_campfire.tscn",
	Keys.Raft : "res://objects/constructables/constructable_raft.tscn"
}

static func get_constructable_scene(item_key:Keys) -> PackedScene:
	return load(CONSTRUCTABLE_SCENES[item_key])
