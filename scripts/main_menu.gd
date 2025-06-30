extends Control
@onready var settings_canvas: CanvasLayer = $CanvasLayer

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_settings_pressed():
	settings_canvas.visible = true


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_closing_button_pressed() -> void:
	settings_canvas.visible = false
