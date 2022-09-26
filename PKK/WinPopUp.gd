extends CenterContainer

onready var tween = $Tween

func _ready():
	pass
	
func arise():
	tween.interpolate_property(self,"rect_position:y",-275,104,2.2,Tween.TRANS_ELASTIC,Tween.EASE_OUT)
	tween.start()
	get_parent().emit_signal("hero_win")





func _on_Level3_hero_win():
	arise()
