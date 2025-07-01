extends Control
@onready var settings_canvas: CanvasLayer = $CanvasLayer
@onready var AniPlayer: AnimationPlayer = $AnimationPlayer


func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_settings_pressed():
	if settings_canvas.visible == true:
		return 1
	settings_canvas.visible = true
	AniPlayer.play("settings_animation")


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_closing_button_pressed():
	AniPlayer.play_backwards("settings_animation")
	await get_tree().create_timer(0.2).timeout
	settings_canvas.visible = false
