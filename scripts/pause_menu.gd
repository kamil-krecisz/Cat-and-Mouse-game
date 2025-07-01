extends Control
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var click_player: AudioStreamPlayer2D = $ClickPlayer

func _ready():
	$PanelContainer/VBoxContainer/Exit.disabled = true
	$PanelContainer/VBoxContainer/Resume.disabled = true
	$PanelContainer/VBoxContainer/MainMenu.disabled = true

func resume():
	$PanelContainer/VBoxContainer/Exit.disabled = true
	$PanelContainer/VBoxContainer/Resume.disabled = true
	$PanelContainer/VBoxContainer/MainMenu.disabled = true
	get_tree().paused = false
	animation.play_backwards("blur")
	
func pause():
	$PanelContainer/VBoxContainer/Exit.disabled = false
	$PanelContainer/VBoxContainer/Resume.disabled = false
	$PanelContainer/VBoxContainer/MainMenu.disabled = false
	get_tree().paused = true
	animation.play("blur")
	
func Esc():
	if Input.is_action_just_pressed("esc") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused == true:
		resume()

func _on_resume_pressed():
	click_player.play()
	resume()

func _on_main_menu_pressed():
	click_player.play()
	await get_tree().create_timer(0.05).timeout
	resume()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_exit_pressed():
	click_player.play()
	await get_tree().create_timer(0.05).timeout
	get_tree().quit()

func _process(_delta):
	Esc()
