extends KinematicBody2D

var speed = normal_speed
var direction_x = -1
var gravity = 12
var jump = -300
var dash = 500
var normal_speed = 200
var velocity = Vector2.ZERO

onready var animatedSprite : AnimatedSprite = $Marimoo

#MUHAMAD RIDWAN ANNAFI

func _ready():
	add_to_group("player")

#MUHAMAD RIDWAN ANNAFI

func _physics_process(delta):
	var snap = Vector2.DOWN * 5
	velocity.y = velocity.y + gravity
	
	if Input.is_action_pressed("kanan"):
		direction_x = 1
	elif Input.is_action_pressed("kiri"):
		direction_x = -1
	else :
		direction_x = 0
	
	if(Input.is_action_just_pressed("Dash")):
		Dash()
	
	if Input.is_action_just_pressed("lompat")and is_on_floor() == true:
		velocity.y = jump
		snap = Vector2.ZERO
	
	if direction_x != 0:
		animatedSprite.scale.x = direction_x
	 
	
	velocity.x = direction_x * normal_speed
	velocity.x = lerp(velocity.x,0,0.3);
	velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP, true);
	
	update_animation()

#MUHAMMAD RIDWAN ANNAFI

func update_animation():
	if is_on_floor():
		if velocity.x < (normal_speed * 0.5) and velocity.x > (-normal_speed * 0.5):
			animatedSprite.play("idle")
		else:
			animatedSprite.play("Run")
	else:
		if velocity.y > 0:
			pass
		else:
			pass



func Dash():
	speed = dash
