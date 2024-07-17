extends Resource
class_name ItemResource

@export var item_key := ItemConfig.Keys.Stick
@export var display_name := "item_name"
@export var icon:Texture2D
@export_multiline var description := "item description"
@export var is_equippable := false
@export var cooking_recipe : CookingRecipeResource
