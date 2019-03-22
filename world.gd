extends Node2D
var goodies = {'shield':0,
'medikit':0,'xspeed':0}
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
var xspeedTimer
var prev_speed
var ball = load('res://models/emmiters/ball.tscn')
var ice = load('res://models/emmiters/ice.tscn')
var apple = load('res://models/emmiters/apple.tscn')
var rock=load('res://models/emmiters/rock.tscn')
var fire=load('res://models/emmiters/fire.tscn')
var medikit = load('res://models/emmiters/healthkit.tscn')
var xspeed = load('res://models/emmiters/xspeed.tscn')
var empty = load('res://models/attackers/empty.tscn')
var death_scream=load('res://assets/sounds/Wilhelm_Scream.wav')
var death_sound=load('res://assets/sounds/death.ogg')
var shield = load('res://models/emmiters/shield.tscn')
#var bonus_bg = load('res://assets/sprites/backgrounds/bonus.jpeg')
var world_bg = load('res://assets/sprites/backgrounds/world_bg2.png')
var emmiters_count = 2
var emmiter_time_set = false
var emmiter_speed_set = false
var is_bonus = 0
var bonusTimer
func _ready():
	randomize()
	$leftContainer/knife.hide()
	$rightContainer/hammer.hide()
	
	bonusTimer = Timer.new()
	bonusTimer.wait_time = 15
	bonusTimer.connect('timeout',self,'_on_bonus_timeout')
	add_child(bonusTimer)
	
	xspeedTimer = Timer.new()
	xspeedTimer.wait_time = 15
	xspeedTimer.connect('timeout',self,'_on_timer_timeout4')
	add_child(xspeedTimer)
	
	$HealthTextureProgress.value = 100
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
	$score.text = str(points)
	$HealthTextureProgress.value = health
	if(points>100 && emmiters_count == 2 ):
		emmiters_count +=1
		$rightContainer/hammer.show() 
	elif(points>200 && emmiters_count == 3):
		emmiters_count +=1
	elif(points>300 && emmiters_count == 4):
		emmiters_count +=1
		$leftContainer/knife.show()
		
	if(points>0 && $Timer.wait_time > 1 && SPEED < 5):
		if(points%100==0):
			$Player/Sprite.animation = "dance"
			$Player/Sprite.play()
			if(!emmiter_time_set):
				$Timer.stop()
				$Timer.wait_time -= 0.2
				$Timer.start()
				emmiter_time_set = true
		else:
			emmiter_time_set = false
		if(points%50==0):
			if(!emmiter_speed_set):
				SPEED += 0.2
				print(SPEED)
				emmiter_speed_set = true
		else:
			emmiter_speed_set = false

		if(points % 200 == 0):
			bonusTimer.wait_time = 15
			is_bonus = 8 - emmiters_count
			points +=10
			$Label.text = "BONUS ROUND!!"
			$Player.attack = empty
			$leftContainer.hide()
			$rightContainer.hide()
			health_factor = 0
			bonusTimer.start()
	
	$HBoxContainer/shield.text = "Shield : "+str(goodies['shield'])
	$HBoxContainer/healthkit.text = "Healthkit : "+str(goodies['medikit'])
	$HBoxContainer/xspeed.text = "SlowMo : "+str(goodies['xspeed'])
	
	
	if(health<=0 && is_alive):
		$Player/AudioStreamPlayer2D.stream=death_scream
		$Player/AudioStreamPlayer2D.play()
		
		var file= File.new()
		file.open('user://high_score.sve',File.READ)
		if(int(file.get_as_text())<points):
			file.open('user://high_score.sve',File.WRITE)
			file.store_string(str(points))
		file.close()
		
		is_alive = false
		$Player/Sprite.hide()
		$gameOver.show()
		$Pause.hide()
		$backgroundSound.stream = death_sound
		$backgroundSound.play()
		get_tree().paused = true

func _on_bonus_timeout():
	$Label.text = ""
	$leftContainer.show()
	$rightContainer.show()
	bonusTimer.stop()
	$Player.attack = $Player.water
	is_bonus = 0

func enemies():
	var emit = int(rand_range(1,4))
	if(emit==1):
		$emit1.add_child(obstacle())
	elif(emit==2):
		$emit2.add_child(obstacle())
	elif(emit==3):
		$emit3.add_child(obstacle())
		
func obstacle():
	var n=int(rand_range(1,emmiters_count+1+is_bonus))
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
	elif(n==6):
		return medikit.instance()
	elif(n==7):
		return xspeed.instance()
	elif(n==8):
		return shield.instance()
	

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
	if(goodies['shield']>0):
		if(shieldTimer.is_stopped()):
			shieldTimer.wait_time = 8
			shieldTimer.start()
			health_factor = 0
		else:
			shieldTimer.wait_time += 8
		goodies['shield'] -=1

func _on_timer_timeout2():
	health_factor = 1
	shieldTimer.stop()

func _on_healthkit_pressed():
	if(goodies['medikit']>0):
		if(health<=80):
			health += 20
		else:
			health = 100
		goodies['medikit'] -=1


func _on_xspeed_pressed():
	if(goodies['xspeed']>0):
		xspeedTimer.wait_time = 8
		xspeedTimer.start()
		prev_speed = SPEED
		SPEED = 1
		goodies['xspeed'] -=1

func _on_timer_timeout4():
	SPEED = prev_speed
	xspeedTimer.stop()
