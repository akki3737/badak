extends KinematicBody2D
var type = 'player'
var node
var attack1
var attack2
var attack3
var attack
var leftDesination
var middleDesination
var rightDesination
var speed = 4
var speedTimer
var is_fire = false
var knife = load('res://models/attackers/knife.tscn')
#var fire = load('res://models/attackers/fire.tscn')
var water = load('res://models/attackers/water.tscn')
var hammer = load('res://models/attackers/hammer.tscn')
var bat = load('res://models/attackers/bat.tscn')
#var ice = load('res://models/attackers/ice.tscn')
var throw_sound = load('res://assets/sounds/player_throws.wav')
var pos = 2
var current_pos = 2

func _ready():
	$Sprite.animation = 'idle'
	$Sprite.play()
	speedTimer =  Timer.new()
	speedTimer.connect('timeout',self,'_on_timer_timeout3')
	add_child(speedTimer)
	
	attack = water
	leftDesination = get_node('/root/Node2D/leftDestination')
	middleDesination = get_node('/root/Node2D/middleDestination')
	rightDesination = get_node('/root/Node2D/rightDestination')
	node = get_node('/root/Node2D')
	attack1 = get_node('/root/Node2D/attack1')
	attack2 = get_node('/root/Node2D/attack2')
	attack3 = get_node('/root/Node2D/attack3')

func _process(delta):
	if(pos == 1):
		current_pos = 1
		position.x = lerp(position.x,leftDesination.position.x,delta*speed)
		if(is_fire):
			attack1.add_child(attack.instance())
			is_fire=false

	elif(pos == 2):
		current_pos = 2
		position.x = lerp(position.x,middleDesination.position.x,delta*speed)
		if(is_fire):
			attack2.add_child(attack.instance())
			is_fire=false

	elif(pos == 3):
		current_pos = 3
		position.x = lerp(position.x,rightDesination.position.x,delta*speed)
		if(is_fire):
			attack3.add_child(attack.instance())
			is_fire=false
		

		
func _on_knife_pressed():
	attack = knife

	
func _on_hammer_pressed():
	attack = hammer


func _on_water_pressed():
	attack = water



func _on_Bat_pressed():
	attack = bat



func _on_left_pressed():
	if(current_pos == 1):
		$Sprite.animation = 'throw'
		$Sprite.play()
	else:
		$Sprite.animation = 'left_run'
		$Sprite.play()
	is_fire = true
	pos = 1


func _on_middle_pressed():
	if(current_pos == 2):
		$Sprite.animation = 'throw'
		$Sprite.play()
	elif(current_pos == 1):
		$Sprite.animation = 'right_run'
		$Sprite.play()
	else:
		$Sprite.animation = 'left_run'
		$Sprite.play()
	is_fire = true
	pos = 2


func _on_right_pressed():
	if(current_pos == 3):
		$Sprite.animation = 'throw'
		$Sprite.play()
	else:
		$Sprite.animation = 'right_run'
		$Sprite.play()
	is_fire = true
	pos = 3


func _on_2xSpeed_pressed():
	if(speedTimer.is_stopped()):
		speedTimer.wait_time = 8
		speedTimer.start()
		speed = 30
	else:
		speedTimer.wait_time += 8

func _on_timer_timeout3():
	speed = 5
	speedTimer.stop()


func _on_fartBomb_pressed():
	#attack = fart
	pass
func _on_leftDestination_body_entered(body):
	$Sprite.animation = 'throw'
	$Sprite.play()
	


func _on_Sprite_animation_finished():
		$Sprite.animation = 'idle'
		$Sprite.play()

func _on_middleDestination_body_entered(body):
	if(pos == 2):
		$Sprite.animation = 'throw'
		$Sprite.play()


func _on_rightDestination_body_entered(body):
	$Sprite.animation = 'throw'
	$Sprite.play()