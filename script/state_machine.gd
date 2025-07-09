extends Node
class_name StateMachine

@export var initial_state : State

var current_state : State
var states : Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			#child.transitioned.connect(on_state_transitoned)
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state


func _process(_delta):
	if current_state:
		current_state.update(_delta)


func _physics_process(_delta: float) -> void:
	if current_state:
		current_state.physics_update(_delta)


func change_state(state : State):
	if state == current_state:
		return
	
	if !state:
		return
	
	if current_state:
		current_state.exit()
	
	state.enter()
	
	current_state = state
