extends CanvasLayer


func _ready():
	pass

func _restart_pressed():
	$GameOverMenu.hide()
	get_tree().paused = false
	get_tree().reload_current_scene()

func _death_area_entered():
	print("dead")
	get_tree().paused = true
	$GameOverMenu.show()
	


func _on_death_body_entered(body):
	print("dead")
	$GameOverMenu.show()
	yield(get_tree().create_timer(.5), "timeout")
	get_tree().paused = true
