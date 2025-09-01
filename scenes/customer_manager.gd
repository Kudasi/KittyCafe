extends Node
@export var queue: Node3D
@export var spawnpoint: Node3D
var last_spawn_time = 0
const CUSTOMER = preload("uid://c8sagwvmjr63r")
func spawn_customer():
	var customer=CUSTOMER.instantiate()
	for point in queue.get_children():
		if point.get_child_count() > 0:
			continue
		point.add_child(customer)
		customer.navigation_agent.target_position = point.global_position
		break
	customer.global_position = spawnpoint.global_position
func _process(delta: float) -> void:
	if Time.get_ticks_msec() - last_spawn_time > 10000:
		spawn_customer()
		last_spawn_time = Time.get_ticks_msec()
