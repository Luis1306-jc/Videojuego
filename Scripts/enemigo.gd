extends CharacterBody2D

@export var speed := 50
@export var gravity := 800

var go_right := true

func _ready():
	$AnimatedSprite2D.play("run")
	$Hitbox.body_entered.connect(_on_Hitbox_body_entered)

func _physics_process(delta):
	# Gravedad
	if not is_on_floor():
		velocity.y += gravity * delta

	# Movimiento horizontal
	if go_right:
		velocity.x = speed
		$AnimatedSprite2D.flip_h = true   # sprite original mira a la izquierda
	else:
		velocity.x = -speed
		$AnimatedSprite2D.flip_h = false

	move_and_slide()

	# Cambiar dirección al chocar con pared
	if is_on_wall():
		go_right = !go_right

# Cuando toca al jugador
func _on_Hitbox_body_entered(body):
	if body.is_in_group("player"):
		if body.has_method("hit"):
			body.hit()   # Llama al método hit() del jugador
