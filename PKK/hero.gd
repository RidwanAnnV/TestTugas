extends KinematicBody2D

var speed = 200
var direction_x = 1
var gravity = 12
var jump = -300
var velocity = Vector2.ZERO

onready var animatedSprite : AnimatedSprite = $Marimoo


func _ready():
	add_to_group("player")


func _physics_process(delta):
	var snap = Vector2.DOWN *5
	velocity.y = velocity.y + gravity
	
	if Input.is_action_pressed("kanan"):
		direction_x = 1
	elif Input.is_action_pressed("kiri"):
		direction_x = -1
	else :
		direction_x = 0
	
	
	if Input.is_action_just_pressed("lompat")and is_on_floor() == true:
		velocity.y = jump
		snap = Vector2.ZERO
	
	if direction_x != 0:
		animatedSprite.scale.x = direction_x
	 
	
	velocity.x = direction_x * speed
	velocity.x = lerp(velocity.x,0,0.3);
	velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP, true);
