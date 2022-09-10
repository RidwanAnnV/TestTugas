class_name Enemy
extends KinematicBody2D

var gravity = 12
export var speed = 10
var velocity = Vector2.ZERO
export var direction = 1
var on_hit = false

onready var pivot = $pivot
onready var raycast : RayCast2D = $pivot/RayCast2D

export var get_hit = 3 

func _ready():
	$"top detection".connect("body_entered", self, "_on_top_detection_body_entered")
	$"side detection".connect("area_entered", self,"_on_side_detection_body_entered")

#MUHAMAD RIDWAN ANNAFI

func _physics_process(delta):
	velocity.y += gravity
	if is_on_wall() or not raycast.get_collider():
		direction *= -1
	
	velocity.x = direction * speed
	
	velocity = move_and_slide(velocity,Vector2.UP)
	pivot.scale.x = direction
	
	
	if not on_hit:
		_update_animation()

func _update_animation():
	if is_on_floor():
		$pivot/AnimatedSprite.play("walk")


func _on_side_detection_body_entered(body):
	if body.name == 'Hero':
		body.hit()


func _on_top_detection_body_entered(body):
	if body.name == 'Hero' and get_hit > 0 :
		body.velocity.y = body.jump
		hit()

func hit():
	get_hit -= 1 
	on_hit = true
	$pivot/AnimatedSprite.play("hit")
	yield(get_tree().create_timer(0.5),"timeout")
	print ("get_hit :", get_hit)
	if get_hit <=0:
		dead()
	else :
		on_hit = false


func dead():
	$pivot/AnimatedSprite.play("dead")
	yield($pivot/AnimatedSprite, "animation_finished")
	queue_free()

