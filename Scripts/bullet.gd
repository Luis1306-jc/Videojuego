extends Area2D

func _process(delta):
	position.x -= 1


func _on_body_entered(body):
	if body.is_in_group("player"):
		body.hit()
		queue_free()
	else:
		queue_free()
