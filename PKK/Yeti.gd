extends KinematicBody2D

var gravity = 12
var speed = -10
var velocity = Vector2.ZERO
export var direction = 1

func _ready():
	pass

func _physics_process(delta):
	velocity.y += gravity
	if is_on_wall():
		direction = direction * -1
	
	velocity.x = speed * direction
	
	velocity = move_and_slide(velocity,Vector2.UP)
	
	_update_animation()

func _update_animation():
	$AnimatedSprite.flip_h = true
	if direction == -1:
		$AnimatedSprite.flip_h = false
