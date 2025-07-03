extends Control
@onready var settings_canvas: CanvasLayer = $CanvasLayer
@onready var AniPlayer: AnimationPlayer = $AnimationPlayer
@onready var click_player: AudioStreamPlayer2D = $ClickPlayer


#SETTINGS BUTTONS
@onready var resolution_option: OptionButton = $CanvasLayer/Panel/VBoxContainer/ResolutionOption
@onready var window_mode: OptionButton = $CanvasLayer/Panel/VBoxContainer/WindowMode
@onready var apply_button: Button = $CanvasLayer/Panel/ApplyButton


var resolutions = [
	Vector2i(1280, 720), Vector2i(1920, 1080),
	Vector2i(1600, 900), Vector2i(960, 640)]


func _ready():
	var config = ConfigFile.new()
	if config.load("user://settings.cfg") == OK:
		var res = config.get_value("display", "resolution", Vector2i(1280, 720))
		var mode = config.get_value("display", "mode", 0)
		DisplayServer.window_set_size(res)
		DisplayServer.window_set_mode(mode)
	for res in resolutions:
		resolution_option.add_item("%sx%s" % [res.x, res.y])
		
	window_mode.add_item("Windowed")
	window_mode.add_item("Closed Window")
	window_mode.add_item("Full-screen")
	window_mode.add_item("Borderless Full-Screen")










func _on_start_pressed():
	click_player.play()
	await get_tree().create_timer(0.05).timeout
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_settings_pressed():
	show_settings()


func _on_exit_pressed():
	click_player.play()
	await get_tree().create_timer(0.05).timeout
	get_tree().quit()


func _on_closing_button_pressed():
	hide_settings()


func _on_apply_button_pressed():
	var res = resolutions[resolution_option.selected]
	print(res)
	var mode = window_mode.selected
	
	DisplayServer.window_set_size(res)
	DisplayServer.window_set_mode(mode)
	
	var config = ConfigFile.new()
	config.set_value("display", "resolution", res)
	config.set_value("display", "mode", mode)
	config.save("user://settings.cfg")
	
	
func show_settings():
	click_player.play()
	if settings_canvas.visible == true:
		hide_settings()
		return
	settings_canvas.visible = true
	AniPlayer.play("settings_animation")
	
func hide_settings():
	click_player.play()
	AniPlayer.play_backwards("settings_animation")
	await get_tree().create_timer(0.2).timeout
	settings_canvas.visible = false
