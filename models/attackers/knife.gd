extends Area2D
var type = 'knife'
var node
var collisionSound
var collision_sound = load('res://assets/sounds/apple_chop.wav')
func _ready():
	node = get_tree().get_root().get_node("Node2D")
	collisionSound = get_tree().get_root().get_node("Node2D/collisionSound")

func _process(delta):
	position.y -= 5

func _on_Area2D_area_entered(area):
	if(area.type == 'apple'):
		collisionSound.stream = collision_sound
		collisionSound.play()
		queue_free()
		node.points += 10
