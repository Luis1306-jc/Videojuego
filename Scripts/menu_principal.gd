extends Control

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/game.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
