extends Area2D

var type = 'shield'
# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var node
func _ready():
	node = get_tree().get_root().get_node("Node2D")
	

func _process(delta):
	position.y += 4


func _on_Area2D_body_entered(body):
	print('s')
	node.goodies['shield']+=1
	print(node.goodies['shield'])
	queue_free()