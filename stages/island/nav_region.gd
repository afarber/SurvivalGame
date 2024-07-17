extends NavigationRegion3D


func _enter_tree() -> void:
	EventSystem.GAM_update_navmesh.connect(bake_navigation_mesh)
