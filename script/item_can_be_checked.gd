extends Node2D
@onready var sprite: Sprite2D = %Sprite
@onready var polygon: CollisionPolygon2D = %Polygon
@onready var positions: Node2D = %position

@export var esilon :float = 2.0
@export var zoom_in_size : float = 1.1

var is_mouse_entered : bool = false
var is_player_in : bool = false
var item_id : int = 1

func _ready() -> void:
	generate_coll_from_texture()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton && event.is_action_released("mouse_left") && is_mouse_entered && is_player_in:
		GameEvent.emit_can_be_checked_item_clicked(item_id)



func set_item_id(id : int):
	item_id = id


func set_sprite_pic(pic:Texture):
	sprite.texture = pic


func generate_coll_from_texture():
	var pic_texture = sprite.texture
	var bitmap = BitMap.new()
	
	if ! pic_texture:
		print("该宝器没有图片")
		return
	bitmap.create_from_image_alpha(pic_texture.get_image())
	
	var points = bitmap.opaque_to_polygons(Rect2(Vector2(),bitmap.get_size()),esilon)
	
	#print(points)
	if points.size() > 0:
		var offset = -bitmap.get_size() / 2.0
		var adjusted_polygon = PackedVector2Array()
		for point in points[0]:
			adjusted_polygon.append(point + offset)
		polygon.polygon = adjusted_polygon
	

func pointed():
	var tween = create_tween()
		
	tween.tween_property(positions,"scale",Vector2.ONE * zoom_in_size,.2).set_ease(Tween.EASE_IN_OUT)


func lose_pointed():
	var tween = create_tween()
	
	tween.tween_property(positions,"scale",Vector2.ONE,.2).set_ease(Tween.EASE_IN_OUT)


func _on_area_2d_mouse_entered() -> void:
	is_mouse_entered = true
	
	if is_player_in:
		pointed()


func _on_area_2d_mouse_exited() -> void:
	is_mouse_entered = false
	
	lose_pointed()



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_player_in = true
		#print("player_in")
		
		if is_mouse_entered:
	
			pointed()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_player_in = false
		if is_mouse_entered:
	
			lose_pointed()
