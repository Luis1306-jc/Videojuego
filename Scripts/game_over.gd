extends Control

func _on_reintentar_pressed():
	Global.moneda = 0
	Global.llave = false
	get_tree().change_scene_to_file("res://Escenas/game.tscn")

func _on_menu_pressed():
	call_deferred("_ir_menu")

func _ir_menu():
	get_tree().change_scene_to_file("res://Escenas/Menu_Principal.tscn")
