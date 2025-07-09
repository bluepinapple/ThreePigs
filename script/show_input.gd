extends Node
@onready var ponit: Node2D = %ponit


@export var input_icons : Array[InputIcon]

var points : Array = []


func _ready() -> void:
	initiate_points()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		set_pic(1)
	elif event.is_action_pressed("mouse_left"):
		set_pic(2)
	elif event.is_action_pressed("mouse_right"):
		set_pic(3)
	elif event.is_action_pressed("move_up"):
		set_pic(4)
	elif event.is_action_pressed("move_down"):
		set_pic(6)
	elif event.is_action_pressed("move_left"):
		set_pic(7)
	elif event.is_action_pressed("move_right"):
		set_pic(5)
	elif event.is_action_pressed("crouch"):
		set_pic(8)
	elif event.is_action_pressed("dash"):
		set_pic(9)
	
	elif event.is_action_pressed("interact"):
		set_pic(10)


func set_pic(id : int):
	if points.size() == 0:
		initiate_points()
	
	var new_sprite = Sprite2D.new()
	new_sprite.texture = input_icons[id - 1].pic
	
	var random_point = points.pop_at(randi_range(0,points.size()-1))
	
	ponit.add_child(new_sprite)
	new_sprite.global_position = random_point
	
	var tween_0 = create_tween()
	tween_0.tween_property(new_sprite,"position",Vector2(new_sprite.position.x,new_sprite.position.y - 20),.6)
	
	get_tree().create_timer(.2).timeout.connect(func a(): 
		var tween = create_tween()
		tween.tween_property(new_sprite,"modulate",Color(1,1,1,0),.4)
		
		await tween.finished
		new_sprite.queue_free()
		)


func initiate_points():
	for child in ponit.get_children():
		points.append(child.global_position)
