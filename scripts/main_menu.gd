extends Control
@onready var settings_canvas: CanvasLayer = $CanvasLayer
@onready var AniPlayer: AnimationPlayer = $AnimationPlayer
@onready var click_player: AudioStreamPlayer2D = $ClickPlayer


func _on_start_pressed():
	click_player.play()
	await get_tree().create_timer(0.05).timeout
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_settings_pressed():
	click_player.play()
	if settings_canvas.visible == true:
		return
	settings_canvas.visible = true
	AniPlayer.play("settings_animation")


func _on_exit_pressed():
	click_player.play()
	await get_tree().create_timer(0.05).timeout
	get_tree().quit()


func _on_closing_button_pressed():
	click_player.play()
	AniPlayer.play_backwards("settings_animation")
	await get_tree().create_timer(0.2).timeout
	settings_canvas.visible = false
