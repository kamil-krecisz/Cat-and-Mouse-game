extends Control
@onready var animation: AnimationPlayer = $AnimationPlayer

func resume():
	get_tree().paused = false
	animation.play_backwards("blur")
	
func pause():
	get_tree().paused = true
	animation.play("blur")
	
func Esc():
	if Input.is_action_just_pressed("esc") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused == true:
		resume()

func _on_resume_pressed():
	resume()

func _on_main_menu_pressed():
	resume()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_exit_pressed():
	get_tree().quit()

func _process(_delta):
	Esc()
