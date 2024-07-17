class_name StageConfig


enum Keys{
	Island,
	MainMenu,
	Credits
}


static func get_stage(stage_key:Keys) -> Stage:
	return load(STAGE_PATHS[stage_key]).instantiate()


const STAGE_PATHS := {
	Keys.Island : "res://stages/island/island.tscn",
	Keys.MainMenu : "res://stages/main_menu/main_menu.tscn",
	Keys.Credits : "res://stages/credits/credits_stage.tscn"
}
