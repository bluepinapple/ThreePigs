extends CharacterBody2D

@onready var sprite: Sprite2D = %Sprite
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var coyote_time: Timer = %CoyoteTime
@onready var cooldown: Sprite2D = %cooldown
@onready var anima_cooldown: AnimationPlayer = %AnimaCooldown
@onready var sbiling_controller: Node2D = %SbilingController
@onready var marker_2d: Marker2D = $SbilingController/Marker2D

var is_facing_right : bool = true
var use_speed = 1
var can_dash : bool = true
var is_dash_ability_enable : bool = false

var siblings : Array[CharacterBody2D] = []
var ability: Array[String] = []

func _ready() -> void:
	var cool_down_material = cooldown.material
	cool_down_material.set_shader_parameter("alpha",0.0)
	


func _physics_process(_delta: float) -> void:
	#if coyote_time.time_left > 0:
		#print(coyote_time.time_left)
	var was_on_floor = is_on_floor()
	move_and_slide()
	
	if is_on_floor() != was_on_floor:
		if was_on_floor:
			coyote_time.start()
		else :
			coyote_time.stop()
	#print(siblings)
	#for kid in siblings:
		#kid.global_position = kid.global_position.lerp(marker_2d.global_position,1-exp(-_delta*8))
	


func _process(_delta: float) -> void:
	if velocity.x > 0:
		flip(true)
		
	elif velocity.x < 0:
		flip(false)
	
	var current_a = cooldown.material.get_shader_parameter("a")
	if current_a!=1 and !can_dash:
		var new_a = clamp(current_a + use_speed * _delta, 0.0, 1.0)
		cooldown.material.set_shader_parameter("a",new_a)
		if new_a == 1:
			anima_cooldown.play("out")
			await anima_cooldown.animation_finished
			
			can_dash = true
	


func get_sibling_sink_position():
	
	return marker_2d.global_position



func set_sprite(pic:Texture):
	sprite.texture = pic
	


func flip(facing_right : bool):
	if facing_right:
		sprite.flip_h = false
		is_facing_right = true
		sbiling_controller.scale.x = 1
	else :
		sprite.flip_h = true
		is_facing_right = false
		sbiling_controller.scale.x = -1


func play_animation(animation_name : String):
	if animation_player.has_animation(animation_name):
		animation_player.play(animation_name)


func dash_cooling_down():
	can_dash = false
	anima_cooldown.play("in")
	cooldown.material.set_shader_parameter("a",0)


func _on_area_2d_body_entered(body: Node2D) -> void:
	#print(!siblings.has(body),body.is_in_group("sibling"))
	if body is CharacterBody2D:
		if !siblings.has(body) and body.is_in_group("sibling"):
			siblings.append(body)
			if body.return_ability().to_lower() == "dash":
				is_dash_ability_enable = true
	
	if body is TileMapLayer:
		print("tile")

func player_death():
	queue_free()
