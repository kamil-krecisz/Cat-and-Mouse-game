extends Area2D

@onready var timer: Timer = $Timer
var mouse  # a variable for mouse to use in different functions(on timer timeout)

@onready var label: Label = $"../CanvasLayer/Label"
var points = 0

func _on_body_entered(body):
	if body.is_in_group("Mouse"):
		print("Trapped")
		points += 1
		label.text = "Points: " + str(points)
		body.can_move = false  # lock the movement
		mouse = body   # save mouse to the mouse variable for later use
		timer.start()          # start timer

func _on_timer_timeout():
	if mouse and mouse.is_inside_tree():
		mouse.can_move = true  # unlock the movement
	queue_free()  # delete the trap
