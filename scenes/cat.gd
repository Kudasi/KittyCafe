extends CharacterBody3D

var direction : Vector2 = Vector2.UP

func _process(delta: float) -> void:
	var view_direction : Vector3 = Vector3(direction.x, 0.0, direction.y)
	basis.z = view_direction
	
	var local_camera : Vector3 = get_viewport().get_camera_3d().global_position - global_position
	var transformed_camera: Vector3 = local_camera * basis
	var projected_camera : Vector2 = Vector2(transformed_camera.x, transformed_camera.z).normalized()
	
	$AnimationTree.set("parameters/Idle/blend_position", projected_camera)
	
	print(projected_camera)
	
