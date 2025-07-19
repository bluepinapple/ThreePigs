extends SiblingState
@onready var sibling: CharacterBody2D = $"../.."
@onready var wait_state: Node = %WaitState
@onready var idle_state: Node = %idleState
@onready var pathfinder: Node2D = %Pathfinder

var path = []
var current_target
var player

var padding = 4
var target_padding = 5


func enter():
	if get_tree().get_first_node_in_group("player") != null :
		player = get_tree().get_first_node_in_group("player")
	path = pathfinder.find_path(sibling.global_position,player.get_sibling_sink_position())
	#var first = path.pop_front()
	#print(first,"first")
	#if path.size() == 0:
		#change_state(wait_state)
	
	next_point()
	
	super.enter()


func physics_update(_delta):
	#if path.size() == 0:
		#change_state(wait_state)
	#print(current_target,sibling.global_position)
	if current_target != null:
		#print(current_target[0],"===",sibling.global_position[0])
		if current_target[0] -padding > sibling.global_position[0]:
			print("you")
			sibling.velocity.x = sibling.run_speed
		elif current_target[0] + padding < sibling.global_position[0]:
			print("zuo")
			sibling.velocity.x = -sibling.run_speed
		else :
			
			sibling.velocity.x = 0
		#print(sibling.global_position.distance_to(current_target) ,"diatance")
		if sibling.global_position.distance_to(Vector2(current_target[0],current_target[1] + 9)) < target_padding and sibling.is_on_floor():
			print("current_target",current_target)
			
			
			next_point()
	if path.size() == 0 :
		change_state(idle_state)
	
	
	super.physics_update(_delta)



func next_point():
	if path.size() == 0:
		current_target = null
		return
	current_target = path.pop_front()
	
	if !current_target:
		sibling.jump()
		next_point()
	
