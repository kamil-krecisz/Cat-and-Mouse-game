extends Control
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var click_player: AudioStreamPlayer2D = $ClickPlayer
@onready var Player = get_tree().get_first_node_in_group("Player")
@onready var label = get_tree().get_first_node_in_group("Label")

@export var price = 10

func _ready():
	$PanelContainer/VBoxContainer/Exit.disabled = true
	$PanelContainer/VBoxContainer/Resume.disabled = true
	$PanelContainer/VBoxContainer/MainMenu.disabled = true

func resume():
	$PanelContainer/VBoxContainer/Exit.disabled = true
	$PanelContainer/VBoxContainer/Resume.disabled = true
	$PanelContainer/VBoxContainer/MainMenu.disabled = true
	$Shop.disabled = true
	get_tree().paused = false
	animation.play_backwards("blur")
	
func pause():
	$PanelContainer/VBoxContainer/Exit.disabled = false
	$PanelContainer/VBoxContainer/Resume.disabled = false
	$PanelContainer/VBoxContainer/MainMenu.disabled = false
	$Shop.disabled = false
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


func _on_shop_pressed():
	show_shop()
	
func show_shop():
	click_player.play()
	if $Panel.visible == true:
		animation.play_backwards("open_shop")
		await get_tree().create_timer(0.3).timeout
		$Panel.visible = false
		return
	$Panel.visible = true
	animation.play("open_shop")


func _on_speed_upgrade_pressed():
	if Player and label.points >= price:
		Player.UPGRADE_SPEED += 0.1
		label.points -= price
		print(Player.UPGRADE_SPEED)
