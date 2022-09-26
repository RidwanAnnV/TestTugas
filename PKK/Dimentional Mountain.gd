extends Node2D

signal hero_win

func _on_Exit_pressed():
	get_tree().change_scene("res://TileScreen.tscn")


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("hero_win")
