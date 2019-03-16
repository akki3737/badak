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
var speed = 5
var speedTimer
var is_fire
var knife = load('res://models/attackers/knife.tscn')
#var fire = load('res://models/attackers/fire.tscn')
var water = load('res://models/attackers/water.tscn')
var hammer = load('res://models/attackers/hammer.tscn')
var bat = load('res://models/attackers/bat.tscn')
#var ice = load('res://models/attackers/ice.tscn')
var throw_sound = load('res://assets/sounds/player_throws.wav')
var pos = 2

func _ready():
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
	if(node.is_alive):
		input()
	if(pos == 1):
		position.x = lerp(position.x,leftDesination.position.x,delta*speed)
		if(is_fire):
			attack1.add_child(attack.instance())
			is_fire = false
	elif(pos == 2):
		position.x = lerp(position.x,middleDesination.position.x,delta*speed)
		if(is_fire):
			attack2.add_child(attack.instance())
			is_fire = false
	elif(pos == 3):
		position.x = lerp(position.x,rightDesination.position.x,delta*speed)
		if(is_fire):
			attack3.add_child(attack.instance())
			is_fire = false
	
	
func input():
	if(Input.is_action_pressed('ui_right')):
		move_and_slide(Vector2(650,0),Vector2(0,0))
	if(Input.is_action_pressed('ui_left')):
		move_and_slide(Vector2(-650,0),Vector2(0,0))
	if(Input.is_action_just_pressed('fire')):
		$AudioStreamPlayer2D.stream = throw_sound
		$AudioStreamPlayer2D.play()
		if(node.pos == 1):
			attack1.add_child(attack.instance())
		elif(node.pos==2):
			attack2.add_child(attack.instance())
		elif(node.pos==3):
			attack3.add_child(attack.instance())
		

func _on_knife_pressed():
	attack = knife
 
func move(pos):
	pass

func _on_hammer_pressed():
	attack = hammer


func _on_water_pressed():
	attack = water



func _on_Bat_pressed():
	attack = bat



func _on_left_pressed():
	move(1)
	pos = 1
	is_fire = true


func _on_middle_pressed():
	move(2)
	pos = 2
	is_fire = true


func _on_right_pressed():
	move(3)
	pos = 3
	is_fire = true


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