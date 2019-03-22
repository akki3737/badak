extends Node2D
var file
var score
var sound = load('res://assets/sounds/menu_selection.wav')
var bg_sound=load('res://assets/sounds/main_menu.wav')
var is_audio 
func _ready():
	#is_audio = get_node('/root/Node2D/settings_menu/Node2D')
	#print(is_audio.is_audio)
	$bg.stream=bg_sound
	$bg.play()
	
	file= File.new()
	if(file.file_exists('user://high_score.sve')):
		file.open('user://high_score.sve',File.READ)
		$menu/high_score.text = str(file.get_as_text())
		
	else:
		$menu/high_score.text='0'
		file.open('user://high_score.sve',File.WRITE)
		file.store_string(str(0))
	file.close()
	
func _on_start_pressed():
	var audio = AudioStreamPlayer2D.new()
	add_child(audio)
	audio.connect('finished',self,'_on_start_finished')
	audio.stream = sound
	audio.play()
	#print($AudioStreamPlayer2D.is_playing())


func _on_settings_pressed():
	var audio = AudioStreamPlayer2D.new()
	add_child(audio)
	audio.stream = sound
	audio.play()
	$settings_menu.show()
	


func _on_exit_pressed():
	var audio = AudioStreamPlayer2D.new()
	add_child(audio)
	audio.connect('finished',self,'_on_exit_finished')
	audio.stream = sound
	audio.play()
	
	
func _on_start_finished():
	get_tree().change_scene('res://world.tscn')
	
func _on_exit_finished():
	get_tree().quit()


func _on_howToPlay_pressed():
	$manual.show()


func _on_Button_pressed():
	$manual.hide()



func _on_storyClose_pressed():
	$Story.hide()
	$storyClose.hide()
	$manual/Button.hide()
	$manual/Sprite2.hide()


func _on_Button2_pressed():
	$manual/Sprite2.show()
	$manual/Button.show()
	$manual/Button2.hide()
