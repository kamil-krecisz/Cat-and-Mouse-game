extends Area2D
@onready var timer: Timer = $Timer
var mouse

func _on_body_entered(body):
	mouse = body
	if body.is_in_group("Mouse"):
		body.can_move = false
		timer.start()


func _on_timer_timeout():
	mouse.can_move = true
	queue_free()
