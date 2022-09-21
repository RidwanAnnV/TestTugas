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
var is_attack = false
var healt_max = 100
var healt = 100

signal hero_dead

onready var animatedSprite : AnimatedSprite = $Marimoo
onready var timer : Timer = $Timer

signal hero_update_healt(value)

func _input(event):
	if event is InputEventKey and event.is_action_pressed("attack") and ATTACK:
		attack()

func attack():
	is_attack = true
	$HitBox.monitoring = true;
	animatedSprite.play("attack")
	yield(animatedSprite,"animation_finished")
	$HitBox.monitoring = false;
	print($HitBox.monitoring)
	is_attack = false
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
	
	if direction_x != 0:
		animatedSprite.scale.x = direction_x
	 
	
	velocity.x = direction_x * speed
	velocity.x = lerp(velocity.x,0,0.3);
	velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP, true);
	
	if not on_hit and not is_attack:
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
	
	healt -= 50 
	emit_signal("hero_update_healt",(float(healt)/float(healt_max))* 100)
	
	animatedSprite.play("hit")
	yield(get_tree().create_timer(0.5),"timeout")
	
	if healt <= 0:
		dead()
	else:
		on_hit = false

func dead():
	$Marimoo.play("dead")
	set_collision_layer_bit(0,false)
	set_collision_mask_bit(2, false)
	yield($Marimoo, "animation_finished")
	emit_signal("hero_dead")
	yield(get_tree().create_timer(0),"timeout")
	queue_free()
