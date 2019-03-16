extends Node2D
var sound=load('res://assets/sounds/menu_selection.wav')


func _on_resume_pressed():
	var audio = AudioStreamPlayer2D.new()
	add_child(audio)
	audio.connect('finished',self,'_on_resume_finished')
	audio.stream = sound
	audio.play()
	

func _on_resume_finished():
	hide()
	get_tree().paused = false

func _on_restart_pressed():
	var audio = AudioStreamPlayer2D.new()
	add_child(audio)
	audio.connect('finished',self,'_on_restart_finished')
	audio.stream = sound
	audio.play()
	
func _on_restart_finished():
	get_tree().paused = false
	get_tree().change_scene('res://world.tscn')


func _on_settings_pressed():
	var audio = AudioStreamPlayer2D.new()
	add_child(audio)
	audio.connect('finished',self,'_on_settings_finished')
	audio.stream = sound
	audio.play()

func _on_settings_finished():
	$settings_menu.show()


func _on_home_pressed():
	var audio = AudioStreamPlayer2D.new()
	add_child(audio)
	audio.connect('finished',self,'_on_home_finished')
	audio.stream = sound
	audio.play()

func _on_home_finished():
	get_tree().paused = false
	get_tree().change_scene('res://menus/main_menu.tscn')
