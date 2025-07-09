extends Node

signal check_interface_entered
signal check_interface_exited

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var canvas_layer: CanvasLayer = %CanvasLayer

@export var being_checked_item = preload("res://scene/being_checked_item.tscn")

var can_be_checked_items = preload("res://resource/CanBeCheckedItems.tres").items
var current_item : Node2D
var is_in : bool = false

func _ready() -> void:
	GameEvent.can_be_checked_item_clicked.connect(on_item_clicked)
	
func _unhandled_input(event: InputEvent) -> void:
	if current_item && is_in:
		
		if event is InputEventMouseButton && event.is_action_released("mouse_left") && !current_item.is_mouse_entered:
			emit_check_interface_exited()
			animation_player.play("out")
			current_item.play_anima_out()
			
			current_item = null
			is_in = false

func on_item_clicked(item_id : int):
	emit_check_interface_entered()
	animation_player.play("in")
	var pic : Texture
	
	for i in can_be_checked_items:
		if i.item_id == item_id:
			pic = i.item_pic
	
	var item = being_checked_item.instantiate()
	
	canvas_layer.add_child(item)
	
	current_item = item
	if pic:
		item.set_sprite_pic(pic)
	item.global_position = get_viewport().get_visible_rect().size / 2
	item.play_anima_in()


func emit_check_interface_entered():
	check_interface_entered.emit()


func emit_check_interface_exited():
	check_interface_exited.emit()


func set_is_in_true():
	is_in = true
