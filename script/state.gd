extends Node
class_name State

func enter():
	#print("currentstate ",self.name)
	pass


func exit():
	pass


func update(_delta : float):
	pass


func physics_update(_delta:float):
	pass


func change_state(next_state : State):
	if get_parent() is StateMachine:
		get_parent().change_state(next_state)
