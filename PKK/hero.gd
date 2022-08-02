extends KinematicBody2D

var speed = 100
var gravity = 12
var jump = -200
var velocity = Vector2.ZERO

func _physics_process(delta):
	velocity.y = velocity.y + gravity
	
	if Input.is_action_pressed("kanan"):
		velocity.x = speed
	if Input.is_action_pressed("kiri"):
		velocity.x = -speed
	
	elif Input.is_action_just_pressed("lompat")and is_on_floor():
		velocity.y = jump
	
	velocity.x = lerp(velocity.x,0,0.3);
	velocity = move_and_slide(velocity,Vector2.UP);
