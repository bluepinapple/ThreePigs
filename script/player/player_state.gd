extends State
class_name PlayerState

var player : CharacterBody2D


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")


func enter():
	
	super.enter()
