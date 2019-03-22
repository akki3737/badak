extends Area2D
var type = 'xspeed'

var node
func _ready():
	node = get_tree().get_root().get_node("Node2D")

func _process(delta):
	position.y += 4

func _on_Area2D_body_entered(body):
	print('x')
	node.goodies['xspeed'] +=1
	print(node.goodies['xspeed'])
	queue_free()
