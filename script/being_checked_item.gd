extends Node2D
@onready var sprite: Sprite2D = %Sprite
@onready var polygon: CollisionPolygon2D = %Polygon
@onready var node_2d: Node2D = %Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var esilon :float = 2.0

var is_mouse_entered : bool = false

func _ready() -> void:
	global_position = get_viewport().get_visible_rect().size / 2
	generate_coll_from_texture()


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


func _on_area_2d_mouse_entered() -> void:
	is_mouse_entered = true


func _on_area_2d_mouse_exited() -> void:
	is_mouse_entered = false


func play_anima_in():
	animation_player.play("in")


func play_anima_out():
	animation_player.play("out")


func queue_free_self():
	queue_free()
