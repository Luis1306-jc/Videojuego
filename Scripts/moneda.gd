extends Area2D

@onready var anim = $AnimatedSprite2D

func _ready() -> void:
	anim.play("coin") # hace que la moneda se anime sola

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.moneda += 1
		queue_free()
