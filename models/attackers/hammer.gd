extends Area2D
var type = 'hammer'
var node
var collisionSound
var collision_sound_ice = load('res://assets/sounds/ice_breaks.wav')
var collision_sound_rock = load('res://assets/sounds/rock_breaks.wav')
func _ready():
	# init
	node = get_tree().get_root().get_node("Node2D")
	collisionSound = get_tree().get_root().get_node("Node2D/collisionSound")

func _process(delta):
	#each frame
	position.y -= 5

func _on_Area2D_area_entered(area):
	if(area.type == 'ice'):
		collisionSound.stream = collision_sound_ice
		collisionSound.play()
		queue_free()
		node.points += 10
	elif(area.type == 'rock'):
		collisionSound.stream = collision_sound_rock
		collisionSound.play()
		queue_free()
		node.points += 10
		