extends Node2D

var sound=load('res://assets/sounds/menu_selection.wav')

func _on_back_pressed():
	var audio = AudioStreamPlayer2D.new()
	add_child(audio)
	audio.connect('finished',self,'_on_back_finished')
	audio.stream = sound
	audio.play()
	
	
func _on_back_finished():
	hide()
	


func _on_audio_toggled(button_pressed):
	var audio = AudioStreamPlayer2D.new()
	add_child(audio)
	audio.stream = sound
	audio.play()
