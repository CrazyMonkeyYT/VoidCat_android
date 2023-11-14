extends CanvasLayer

func _pauseButton_pressed():
	get_tree().paused = true
	$pauseMenu.show()

func _playButton_pressed():
	$pauseMenu.hide()
	get_tree().paused = false

func _restart_pressed():
	$pauseMenu.hide()
	get_tree().paused = false
	get_tree().reload_current_scene()
