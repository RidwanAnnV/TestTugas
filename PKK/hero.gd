extends KinematicBody2D

export var dash_duration :float = 1.0
export var normal_speed = 200

enum {
	IDLE,
	WALK,
	DASH,
	JUMP,
	ATTACK
}
var state = IDLE

var speed = normal_speed
var direction_x = -1
var gravity = 12
var jump = -300
var dash = 500
var velocity = Vector2.ZERO
var on_hit = false 

onready var animatedSprite : AnimatedSprite = $Marimoo
onready var timer : Timer = $Timer

#MUHAMAD RIDWAN ANNAFI

func _ready():
	add_to_group("player")

#MUHAMAD RIDWAN ANNAFI

func _physics_process(delta):
	var snap = Vector2.DOWN * 5
	velocity.y = velocity.y + gravity
	
	if velocity.y > -1:
		pass
		#set_collision_layer_bit(0, true)
		#set_collision_mask_bit(0, true)
	if state != DASH:
		if is_on_floor():
			if not on_hit and Input.is_action_just_pressed("lompat"):
				#set_collision_layer_bit(0, false)
				#set_collision_mask_bit(0, false)
				state = JUMP
				velocity.y = jump
				snap = Vector2.ZERO
			if not on_hit and Input.is_action_pressed("kanan") or Input.is_action_pressed("kiri"):
				state = WALK
		if not on_hit and Input.is_action_pressed("kanan"):
			direction_x = 1
		elif not on_hit and Input.is_action_pressed("kiri"):
			direction_x = -1
		else :
			if is_on_floor():
				state = IDLE
			direction_x = 0
	
		if(not on_hit and Input.is_action_just_pressed("dash")):
			Dash()
	
	if is_on_floor():
		state = ATTACK
		direction_x = 0 
	
	if direction_x != 0:
		animatedSprite.scale.x = direction_x
	 
	
	velocity.x = direction_x * speed
	velocity.x = lerp(velocity.x,0,0.3);
	velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP, true);
	
	if not on_hit:
		update_animation()

#MUHAMMAD RIDWAN ANNAFI

func update_animation():
	match state:
		IDLE:
			animatedSprite.play("idle")
		WALK:
			animatedSprite.play("Run")
		DASH:
			animatedSprite.play("dash")
		ATTACK:
			animatedSprite.play("attack")



func Dash():
	speed = dash
	direction_x = animatedSprite.scale.x
	state = DASH
	timer.start(dash_duration)


func _on_Timer_timeout():
	state = IDLE
	speed = normal_speed

func hit():
	on_hit = true
	animatedSprite.play("hit")
	yield(get_tree().create_timer(0.5),"timeout")
	on_hit = false

