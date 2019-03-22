extends Area2D
var type = 'healthkit'

var node
func _ready():
	node = get_tree().get_root().get_node("Node2D")

func _process(delta):
	position.y += 4

func _on_Area2D_body_entered(body):
	node.goodies['medikit']+=1
	print(node.goodies['medikit'])
	queue_free()