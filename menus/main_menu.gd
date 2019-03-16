extends Node2D

var sound = load('res://assets/sounds/menu_selection.wav')
func _on_start_pressed():
	$menu/start/start.stream=sound
	$menu/start/start.play()
	#print($AudioStreamPlayer2D.is_playing())
		

func _on_settings_pressed():
	$settings_menu.show()
	$AudioStreamPlayer2D.stream=sound
	$AudioStreamPlayer2D.play()


func _on_exit_pressed():
	$menu/exit/exit.stream=sound
	$menu/exit/exit.play()
	
	
func _on_start_finished():
	get_tree().change_scene('res://world.tscn')
	


func _on_exit_finished():
	get_tree().quit()
