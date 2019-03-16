extends Node2D

var pause = false
var is_alive = true
var SPEED = 2
var type = 'world'
var points = 0
var health = 100
var pos
var health_factor = 1
var score_factor = 1
var scoreTimer
var shieldTimer
var ball = load('res://models/emmiters/ball.tscn')
var ice = load('res://models/emmiters/ice.tscn')
var apple = load('res://models/emmiters/apple.tscn')
var rock=load('res://models/emmiters/rock.tscn')
var fire=load('res://models/emmiters/fire.tscn')
var emmiters_count = 2
var emmiter_time_set = false
var emmiter_speed_set = false

func _ready():
	scoreTimer =  Timer.new()
	scoreTimer.connect('timeout',self,'_on_timer_timeout1')
	add_child(scoreTimer)
	
	shieldTimer =  Timer.new()
	shieldTimer.connect('timeout',self,'_on_timer_timeout2')
	add_child(shieldTimer)
	$backgroundSound.play()
	$Timer.wait_time = 2
	$Timer.start()
	pos=2

func _process(delta):
	$score.text = "Score : "+str(points)
	$health.text = "Health : "+str(health)
	if(points>25 && emmiters_count == 2 ):
		emmiters_count +=1
		$rightContainer/hammer.show() 
	elif(points>350 && emmiters_count == 3):
		emmiters_count +=1
	elif(points>500 && emmiters_count == 4):
		emmiters_count +=1
		$leftContainer/knife.show()
	if(points>0 && $Timer.wait_time > 1 && SPEED < 5):
		if(points%200==0):
			if(!emmiter_time_set):
				$Timer.stop()
				$Timer.wait_time -= 0.2
				$Timer.start()
				emmiter_time_set = true
		else:
			emmiter_time_set = false
		if(points%10==0):
			if(!emmiter_speed_set):
				SPEED += 0.1
				print(SPEED)
				emmiter_speed_set = true
		else:
			emmiter_speed_set = false
	
	if(health<=0):
		is_alive = false
		$Player/Sprite.hide()
		$gameOver.show()
		$Pause.hide()
		$health.text = "Well Played!"
		
func enemies():
	var emit = int(rand_range(1,4))
	if(emit==1):
		$emit1.add_child(obstacle())
	elif(emit==2):
		$emit2.add_child(obstacle())
	elif(emit==3):
		$emit3.add_child(obstacle())
		
func obstacle():
	var n=int(rand_range(1,emmiters_count+1))
	if (n==1):
		return fire.instance()
	elif (n==2):
		return ball.instance()
	elif(n==3):
		return rock.instance()
	elif(n==4):
		return ice.instance()
	elif(n==5):
		return apple.instance()

func _on_Timer_timeout():
	enemies()


func _on_1_body_entered(body):
	pos = 1


func _on_2_body_entered(body):
	pos = 2


func _on_3_body_entered(body):
	pos = 3


func _on_Pause_pressed():
	get_tree().paused = true
	$pauseMenu.show()


func _on_2xScore_pressed():
	if(scoreTimer.is_stopped()):
		scoreTimer.wait_time = 8
		scoreTimer.start()
		score_factor = 2
	else:
		scoreTimer.wait_time += 8

func _on_timer_timeout1():
	score_factor = 1
	scoreTimer.stop()

func _on_shield_pressed():
	if(shieldTimer.is_stopped()):
		shieldTimer.wait_time = 8
		shieldTimer.start()
		health_factor = 0
	else:
		shieldTimer.wait_time += 8

func _on_timer_timeout2():
	health_factor = 1
	shieldTimer.stop()

func _on_healthKit_pressed():
	if(health<=80):
		health += 20
	else:
		health = 100