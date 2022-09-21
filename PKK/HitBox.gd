class_name hitbox 
extends Area2D

export var target_grup:String
export var damage : int

func _ready():
	self.connect("body_entered", self ,"_collision_detected")


func _collision_detected(body):
	if body.is_in_group(target_grup) and damage != 0:
		pass
