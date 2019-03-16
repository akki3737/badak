extends Area2D
var type = 'water'
var node
var collisionSound
var collision_sound = load('res://assets/sounds/water-pouring.wav')
func _ready():
	node = get_tree().get_root().get_node("Node2D")
	collisionSound = get_tree().get_root().get_node("Node2D/collisionSound")

func _process(delta):
	position.y -= 5

func _on_Area2D_area_entered(area):
	if(area.type == 'fire'):
		collisionSound.stream = collision_sound
		collisionSound.play()
		queue_free()
		node.points += 10

