extends CharacterBody3D
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
func _physics_process(delta: float) -> void:
	if global_position.distance_to(navigation_agent.target_position) > 2:
		velocity = (navigation_agent.get_next_path_position() - global_position).normalized() * 100 * delta
	velocity += Vector3.DOWN * 98 * delta
	velocity *= 0.95
	move_and_slide()
	
func _on_navigation_agent_3d_target_reached() -> void:
	#navigation_agent.target_position = null
	pass
