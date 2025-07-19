extends CharacterBody2D
@onready var pathfinder: Node2D = %Pathfinder

@export var ability_name : String = "dash"
@onready var player_check_area: Area2D = %PlayerCheckArea
@onready var player_check_area_colli: CollisionShape2D = %PlayerCheckAreaColli
@onready var sprite: Sprite2D = %Sprite

@export var jump_force : float = -400
@export var run_speed : float = 160

var gravity : = ProjectSettings.get("physics/2d/default_gravity") as float
var is_facing_right : bool = true

func _physics_process(_delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * _delta
	if velocity.x > 0:
		flip(true)
		
	elif velocity.x < 0:
		flip(false)
	
	move_and_slide()


func jump():
	velocity.y = jump_force


func return_ability():
	
	return ability_name


func flip(facing_right : bool):
	if facing_right:
		sprite.flip_h = false
		is_facing_right = true
		
	else :
		sprite.flip_h = true
		is_facing_right = false
