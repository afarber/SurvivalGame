extends Resource
class_name ItemResource

@export var item_key: ItemConfig.Keys
@export var display_name := "item name"
@export var icon: Texture2D
@export_multiline var description := "description"
@export var is_equipable := false
@export var cooking_recipe: CookingRecipeResource
