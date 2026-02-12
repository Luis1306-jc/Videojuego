extends CharacterBody2D

var velocidad := 170
var salto := 250
var gravedad := 600
var atacar := false	
var hitplayer=false
var cont_jump : int = 0
var max_jump : int = 2
@onready var vida_bar := $BarravidaPlayer

func _ready():
	$Area2D/CollisionShape2D.disabled = true
	$anim.animation_finished.connect(_on_anim_finished)

func _physics_process(delta):
	velocity.y += gravedad * delta
	
	if !hitplayer:
		if !atacar:
			if Input.is_action_pressed("ui_right"):
				velocity.x = velocidad
				$Area2D.position.x = 19
				$anim.flip_h = false
			elif Input.is_action_pressed("ui_left"):
				velocity.x = -velocidad
				$Area2D.position.x = -7
				$anim.flip_h = true
			else:
				velocity.x = 0

			if is_on_floor() and Input.is_action_just_pressed("saltar"):
				cont_jump = 0
				cont_jump+=1
				velocity.y = -salto
			else:
				if Input.is_action_just_pressed("saltar") and max_jump > cont_jump:
					cont_jump+=1
					velocity.y = -salto
				if Input.is_action_just_released("saltar"):
					velocity.y += 5000*delta

			if Input.is_action_just_pressed("atacar") and !hitplayer:
				atacar = true
				$Area2D/CollisionShape2D.disabled = false
				$anim.play("atack")

		animaciones()
	move_and_slide()


func animaciones():
	if atacar:
		return

	if is_on_floor():
		if velocity.x != 0:
			$anim.play("run")
		else:
			$anim.play("idle")
	else:
		if velocity.y < 0:
			$anim.play("jump")
		else:
			$anim.play("fall")
			
func hit():
	hitplayer = true
	velocity = Vector2.ZERO
	
	if !$anim.flip_h:
		velocity = Vector2(-100,-200)
	else:
		velocity = Vector2(100,-200)
	
	$anim.play("hit")
	await $anim.animation_finished
	
	hitplayer = false

	if vida_bar.disminuir_vida(30):
		dead()

func dead():
	set_physics_process(false)
	$anim.play("dead")
	await $anim.animation_finished
	Global.moneda = 0
	Global.llave = false
	get_tree().change_scene_to_file("res://Escenas/game_over.tscn")



func _on_anim_finished():
	atacar = false
	$Area2D/CollisionShape2D.disabled = true


func _on_area_2d_body_entered(body):
	if body.is_in_group("enemie"):
		hit()  # Llama a tu propio método hit() del jugador
