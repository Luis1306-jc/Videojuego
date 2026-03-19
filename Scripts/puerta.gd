extends Area2D

@export var siguiente_nivel: String = "res://Escenas/nivel_2.tscn"

func _on_body_entered(body):
	if body.is_in_group("player") and Global.llave:
		Global.moneda = 0
		Global.llave = false
		get_tree().change_scene_to_file(siguiente_nivel)
