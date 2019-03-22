extends Node2D
var sound = load('res://assets/sounds/menu_selection.wav')



	
func _on_retry_pressed():
	get_tree().paused = false
	var audio = AudioStreamPlayer2D.new()
	add_child(audio)
	audio.connect('finished',self,'_on_retry_finished')
	audio.stream = sound
	audio.play()
func _on_retry_finished():
	get_tree().paused = false
	get_tree().change_scene('res://world.tscn')


func _on_home_pressed():
	get_tree().paused = false
	var audio = AudioStreamPlayer2D.new()
	add_child(audio)
	audio.connect('finished',self,'_on_home_finished')
	audio.stream = sound
	audio.play()
	
func _on_home_finished():
	get_tree().paused = false
	get_tree().change_scene('res://menus/main_menu.tscn')