extends Resource
class_name CookingRecipeResource

@export var uncooked_item := ItemConfig.Keys.RawMeat
@export var uncooked_item_visuals : PackedScene
@export var cooked_item := ItemConfig.Keys.CookedMeat
@export var cooked_item_visuals : PackedScene
@export var cooking_time := 5.0
