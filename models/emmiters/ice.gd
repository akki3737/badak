extends Area2D
var type = 'ice'
var node
var SPEED

func _ready():
	node = get_tree().get_root().get_node("Node2D")
	SPEED = node.SPEED
func _process(delta):
	position.y += SPEED

func _on_Area2D_area_entered(area):
	if(area.type == 'hammer'):
		queue_free()
	elif(area.type == 'wall'):
		node.health -= 10 * node.health_factor
		queue_free()
