extends CharacterBody2D

var velocidad : int = 50
var vel_perseguir : int = 100
var perseguir : bool = false
var muriendo : bool = false


func _ready():
	$AnimatedSprite2D.play("run")
	velocity.x = -velocidad


func _physics_process(delta):
	if muriendo:
		return

	detectar()

	if !perseguir:
		if is_on_wall():
			if !$AnimatedSprite2D.flip_h:
				velocity.x = velocidad
			else:
				velocity.x = -velocidad
			
		if velocity.x < 0:
			$AnimatedSprite2D.flip_h = false
		elif velocity.x > 0:
			$AnimatedSprite2D.flip_h = true

	move_and_slide()


func detectar():
	perseguir = false

	if $right.is_colliding():
		var obj = $right.get_collider()
		if obj != null and obj.is_in_group("player"):
			perseguir = true
			velocity.x = vel_perseguir
			$AnimatedSprite2D.flip_h = true
			return

	if $left.is_colliding():
		var obj = $left.get_collider()
		if obj != null and obj.is_in_group("player"):
			perseguir = true
			velocity.x = -vel_perseguir
			$AnimatedSprite2D.flip_h = false
			return


func dead():
	if muriendo:
		return

	muriendo = true
	set_physics_process(false)
	velocity = Vector2.ZERO
	$AnimatedSprite2D.play("dead")

	# ⏱️ Espera fija (aunque la animación esté en loop)
	await get_tree().create_timer(0.6).timeout
	queue_free()
