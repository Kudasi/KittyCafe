extends Node3D

func _process(delta: float) -> void:
	$Node3D.rotate_y(delta)
