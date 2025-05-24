extends Camera2D

@export var SMOOTH_SPEED = 10.0  # Im wyższa wartość, tym szybciej kamera się wyrównuje
@export var target_node : Node2D  # Wybierz gracza jako target

func _process(delta):
	if target_node:
		position = position.lerp(target_node.position, SMOOTH_SPEED * delta)
