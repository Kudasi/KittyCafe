extends CharacterBody3D

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D

func _ready() -> void:
	navigation_agent.target_position = Vector3.ZERO
	pass
	
func _process(delta: float) -> void:
	var view_direction : Vector3 = Vector3(velocity.x, 0.0, velocity.z)
	#look_at(view_direction)
	
	var local_camera : Vector3 = get_viewport().get_camera_3d().global_position - global_position
	var transformed_camera: Vector3 = local_camera * basis
	var projected_camera : Vector2 = Vector2(transformed_camera.x, transformed_camera.z).normalized()
	
	$AnimationTree.set("parameters/Idle/blend_position", projected_camera)
	$AnimationTree.set("parameters/Walking/blend_position", projected_camera)
	$AnimationTree.set("parameters/Transition/transition_request", "Walking" if velocity.length() > 1 else "Idle")
	
	
func _physics_process(delta: float) -> void:
	velocity = (navigation_agent.get_next_path_position() - position).normalized() * 100 * delta
	velocity += Vector3.DOWN * 98 * delta
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		var camera = get_viewport().get_camera_3d()
		var raycast_query = PhysicsRayQueryParameters3D.create(camera.global_position, camera.global_position + camera.project_ray_normal(event.position) * 100, 1, [get_rid()])
		var raycast = get_world_3d().direct_space_state.intersect_ray(raycast_query)
		
		if raycast:
			navigation_agent.target_position = raycast.position
		
