extends Area2D

func _ready():
	hide()
	$CollisionShape2D.disabled = true

func _process(delta):
	if Global.moneda >= 10 and !Global.llave:
		show()
		$CollisionShape2D.disabled = false

func _on_body_entered(body):
	if body.is_in_group("player"):
		Global.llave = true
		queue_free()
