extends Area2D

onready var healt_progress = $"../CanvasLayer/HealtBar/TextureProgress"

func _ready():
	pass 


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene("res://Dimentional Mountain.tscn")
	


#MUHAMAD RIDWAN ANNAFI


func _on_Hero_hero_update_healt(value):
	healt_progress.value = value
