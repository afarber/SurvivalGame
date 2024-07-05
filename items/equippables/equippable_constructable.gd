extends EquippableItem
class_name EquippableConstructable

# preload() loads immediately when the game starts, load() when it is needed
const VALID_MATERIAL:StandardMaterial3D = preload("res://resources/materials/constructable_valid_material.tres")
const INVALID_MATERIAL:StandardMaterial3D = preload("res://resources/materials/constructable_invalid_material.tres")

@onready var item_place_ray: RayCast3D = $ItemPlaceRay
@onready var constructable_area: Area3D = $ConstructableArea
@onready var collision_shape_3d: CollisionShape3D = $ConstructableArea/CollisionShape3D
@onready var constructable_preview_mesh: MeshInstance3D = $ConstructableArea/ConstructablePreviewMesh

var constructable_item_key: ItemConfig.Keys
var obstacles: Array[Node3D] = []
var place_valid := false

