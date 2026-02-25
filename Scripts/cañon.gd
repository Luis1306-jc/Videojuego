extends CharacterBody2D

@export var bullet : PackedScene
var puedodisparar : bool = true

func _ready():
	pass
	
func _process(delta):
	if $RayCast2D.is_colliding():
		var obj = $RayCast2D.get_collider()
		if obj.is_in_group("player") and puedodisparar:
			puedodisparar = false
			$Timer.start()
			shoot() 
	
func shoot():
	var newbullet = bullet.instantiate()
	newbullet.global_position = $spawbullet.global_position
	get_parent().add_child(newbullet)

func _on_timer_timeout():
	puedodisparar = true
