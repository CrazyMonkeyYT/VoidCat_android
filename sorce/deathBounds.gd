extends Area2D


func _ready():
	pass


func _on_charater_keepMoving(velocityOut):
	position.y -= velocityOut.y
