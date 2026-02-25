extends Area2D

var vidaextra: int = 20

func _on_body_entered(body):
	if body.is_in_group("player"):
		var barra = body.get_node("BarravidaPlayer")
		barra.value = min(barra.value + vidaextra, barra.max_value)
		queue_free()
