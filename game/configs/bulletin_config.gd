class_name BulletinConfig


enum Keys{
	InteractionPrompt,
	CraftingMenu,
	CookingMenu,
	PauseMenu,
	SettingsMenu
}


static func get_bulletin(bulletin_key:Keys) -> Bulletin:
	return load(BULLETIN_PATHS[bulletin_key]).instantiate()


const BULLETIN_PATHS := {
	Keys.InteractionPrompt : "res://bulletins/interaction_prompt/interaction_prompt.tscn",
	Keys.CraftingMenu : "res://bulletins/player_menus/crafting_menu/crafting_menu.tscn",
	Keys.CookingMenu : "res://bulletins/player_menus/cooking_menu/cooking_menu.tscn",
	Keys.PauseMenu : "res://bulletins/pause_menu/pause_menu.tscn",
	Keys.SettingsMenu : "res://bulletins/settings_menu/settings_menu.tscn"
}
