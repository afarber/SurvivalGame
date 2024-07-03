extends EquippableItem
class_name EquippableConstructable

@onready var item_place_ray: RayCast3D = $ItemPlaceRay
@onready var constructable_area: Area3D = $ConstructableArea
@onready var collision_shape_3d: CollisionShape3D = $ConstructableArea/CollisionShape3D
@onready var constructable_preview_mesh: MeshInstance3D = $ConstructableArea/ConstructablePreviewMesh
