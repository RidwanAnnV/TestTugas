extends CenterContainer

onready var tween = $Tween

func _ready():
	pass
	
func arise():
	tween.interpolate_property(self,"rect_position:y",-143,104,2.2,Tween.TRANS_ELASTIC,Tween.EASE_OUT)
	tween.start()





func _on_Hero_hero_dead():
	arise()


func _on_Button_pressed():
	get_tree().change_scene("res://Dimentional Mountain.tscn")
