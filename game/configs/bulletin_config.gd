class_name BulletinConfig

enum Keys {
	InteractionPrompt,
	CraftingMenu
}

const BULLETIN_PATHS := {
	Keys.InteractionPrompt: "res://bulletins/interaction_prompt.tscn",
	Keys.CraftingMenu: "res://bulletins/player_menus/crafting_menu.tscn"
}

static func get_bulletin(key: Keys) -> Bulletin:
	return load(BULLETIN_PATHS.get(key)).instantiate()
