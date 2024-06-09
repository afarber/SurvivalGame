extends Resource

class_name CraftingBlueprintResource

@export var item_key := ItemConfig.Keys.Axe
@export var costs: Array[BlueprintCostData] = []
@export var needs_multitool := false
@export var needs_tinderbox := false
