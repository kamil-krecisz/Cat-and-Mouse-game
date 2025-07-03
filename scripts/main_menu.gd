extends Control


func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_settings_pressed():
	print("Settings pressed")


func _on_exit_pressed() -> void:
	get_tree().quit()
