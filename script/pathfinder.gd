extends Node2D

const FACE = preload("res://scene/face.tscn")

@export var tile_map_layer: TileMapLayer

var graph : AStar2D
@export var cell_size = 16
@export var jumpHeight = 4
@export var jumpDistance = 4

func _ready() -> void:
	graph = AStar2D.new()
	
	if tile_map_layer == null and get_tree().get_first_node_in_group("tile") != null:
		tile_map_layer = get_tree().get_first_node_in_group("tile")
	
	if tile_map_layer != null:
		create_map()
		connect_points()


func find_closest_point_id(pos):
	var closest_point = graph.get_closest_point(pos)
	
	return graph.get_point_position(closest_point)


func find_path(start,end):
	var frist_point = graph.get_closest_point(start)
	var last_point = graph.get_closest_point(end)
	var path = graph.get_id_path(frist_point,last_point)
	
	if path.size() == 0:
		return path
	
	var action = []
	
	var lastPos = null
	
	for point in path:
		var pos = graph.get_point_position(point)
		var stat = cell_type(pos, true, true)
		
		if lastPos and lastPos[1] >= pos[1] - (cell_size * jumpHeight) and ((lastPos[0] < pos[0] and stat[0] < 0) or (lastPos[0] > pos[0] and stat[1] < 0)):
			action.append(null)
		lastPos = pos
		
		if point == path[0] and len(path) > 1:
			var nextPos = graph.get_point_position(path[1])
			if start.distance_to(nextPos) > pos.distance_to(nextPos): 
				action.append(pos)
		elif point == path[-1] and len(path) > 1:
			if (graph.get_point_position(path[-2]).distance_to(end) < pos.distance_to(end)):
				action.append(pos)
		else:
			action.append(pos)
	
	
	action.append(end)
	return action


#func _draw() -> void:
	#var points = graph.get_point_ids()
	#
	#for point in points:
		#var closeRight = -1
		#var closeLeftDrop = -1
		#var closeRightDrop = -1
		#var pos = graph.get_point_position(point)
		#var type = cell_type(pos,true,true)
		##print(pos,type)
		#
		#var pointsToJoin = []
		#var noBiJoin = []
		#
		#if type != null:
			#for newPoint in points:
				#var newPos = graph.get_point_position(newPoint)
				#if type[1] == 0  and  newPos[1] == pos[1] and newPos[0] > pos[0]:
					#if closeRight < 0 or newPos[0] < graph.get_point_position(closeRight)[0]:
						#closeRight = newPoint
				#
				#if type[0] == -1:
					#
					#if newPos[0] == pos[0] - cell_size  and newPos[1] > pos[1]:
						#if closeLeftDrop < 0 or newPos[1] < graph.get_point_position(closeLeftDrop)[1]:
							#closeLeftDrop = newPoint
					#
					#if (newPos[1] >= pos[1] - (cell_size * jumpHeight) and newPos[1] <= pos[1] and \
					#newPos[0] > pos[0] - (cell_size * (jumpDistance + 2)) and newPos[0] < pos[0]) and cell_type(newPos, true, true)[1] == -1 :
						#pointsToJoin.append(newPoint)
						#
				#if type[1] == -1:
					#
					#if newPos[0] == pos[0] + cell_size  and newPos[1] > pos[1]:
						#if closeRightDrop < 0 or newPos[1] < graph.get_point_position(closeRightDrop)[1]:
							#closeRightDrop = newPoint
					#
					#if (newPos[1] >= pos[1] - (cell_size * jumpHeight) and newPos[1] <= pos[1] and \
					#newPos[0] < pos[0] + (cell_size * (jumpDistance + 2)) and newPos[0] > pos[0]) and cell_type(newPos, true, true)[0] == -1 :
						#pointsToJoin.append(newPoint)
			#
			#
			#if closeLeftDrop > 0:
				#if graph.get_point_position(closeLeftDrop)[1] <= pos[1] + (cell_size * jumpHeight):
					#pointsToJoin.append(closeLeftDrop)
				#else :
					#noBiJoin.append(closeLeftDrop)
				#
			#
			#if closeRightDrop > 0:
				#if graph.get_point_position(closeRightDrop)[1] <= pos[1] + (cell_size * jumpHeight):
					#pointsToJoin.append(closeRightDrop)
				#else :
					#noBiJoin.append(closeRightDrop)
				#
			#
			#if closeRight > 0:
				#pointsToJoin.append(closeRight)
			#
			#for joinpoint in noBiJoin:
				#draw_line(Vector2(pos.x,pos.y - 5),Vector2(graph.get_point_position(joinpoint).x,graph.get_point_position(joinpoint).y-5),Color.BLUE_VIOLET,1)
			#
			#for join in pointsToJoin:
				#draw_line(Vector2(pos.x,pos.y - 5),Vector2(graph.get_point_position(join).x,graph.get_point_position(join).y-5),Color.CADET_BLUE,1)


func connect_points():
	var points = graph.get_point_ids()
	
	for point in points:
		var closeRight = -1
		var closeLeftDrop = -1
		var closeRightDrop = -1
		var pos = graph.get_point_position(point)
		var type = cell_type(pos,true,true)
		#print(pos,type)
		
		var pointsToJoin = []
		var noBiJoin = []
		
		if type != null:
			for newPoint in points:
				var newPos = graph.get_point_position(newPoint)
				if type[1] == 0  and  newPos[1] == pos[1] and newPos[0] > pos[0]:
					if closeRight < 0 or newPos[0] < graph.get_point_position(closeRight)[0]:
						closeRight = newPoint
				
				if type[0] == -1:
					
					if newPos[0] == pos[0] - cell_size  and newPos[1] > pos[1]:
						if closeLeftDrop < 0 or newPos[1] < graph.get_point_position(closeLeftDrop)[1]:
							closeLeftDrop = newPoint
					
					if (newPos[1] >= pos[1] - (cell_size * jumpHeight) and newPos[1] <= pos[1] and \
					newPos[0] > pos[0] - (cell_size * (jumpDistance + 2)) and newPos[0] < pos[0]) and cell_type(newPos, true, true)[1] == -1 :
						pointsToJoin.append(newPoint)
						
				if type[1] == -1:
					
					if newPos[0] == pos[0] + cell_size  and newPos[1] > pos[1]:
						if closeRightDrop < 0 or newPos[1] < graph.get_point_position(closeRightDrop)[1]:
							closeRightDrop = newPoint
					
					if (newPos[1] >= pos[1] - (cell_size * jumpHeight) and newPos[1] <= pos[1] and \
					newPos[0] < pos[0] + (cell_size * (jumpDistance + 2)) and newPos[0] > pos[0]) and cell_type(newPos, true, true)[0] == -1 :
						pointsToJoin.append(newPoint)
			
			
			if closeLeftDrop > 0:
				if graph.get_point_position(closeLeftDrop)[1] <= pos[1] + (cell_size * jumpHeight):
					pointsToJoin.append(closeLeftDrop)
				else :
					noBiJoin.append(closeLeftDrop)
				
			
			if closeRightDrop > 0:
				if graph.get_point_position(closeRightDrop)[1] <= pos[1] + (cell_size * jumpHeight):
					pointsToJoin.append(closeRightDrop)
				else :
					noBiJoin.append(closeRightDrop)
				
			
			if closeRight > 0:
				pointsToJoin.append(closeRight)
			
			for joinpoint in noBiJoin:
				graph.connect_points(point,joinpoint,false)
				
			for join in pointsToJoin:
				graph.connect_points(point,join)


func create_map():
	var cells = tile_map_layer.get_used_cells()
	#print(cells)
	for cell in cells:
		var type = cell_type(cell)
		
		#if type and type != Vector2i.ZERO :
		if type != null:
			create_point(cell)
			
			if type[0] == -1:
				var nearest_one = null
				for i in cells:
					if i[0] == cell[0]-1 and i[1] > cell[1]:
						if !nearest_one:
							nearest_one = i
						else :
							if nearest_one[1] - cell[1] > i[1] - cell[1]:
								nearest_one = i
				if nearest_one:
					create_point(nearest_one)
			
			if type[1] == -1:
				var nearest_one = null
				for i in cells:
					if i[0] == cell[0] + 1 and i[1] > cell[1]:
						if !nearest_one:
							nearest_one = i
						else :
							if nearest_one[1] - cell[1] > i[1] - cell[1]:
								nearest_one = i
			
				if nearest_one:
					create_point(nearest_one)
	


func cell_type(pos,global : bool = false,isAbove : bool = false):
	if global:
		pos = tile_map_layer.local_to_map(pos)
		#print(pos)
	if isAbove:
		pos = Vector2i(pos[0],pos[1] + 1)
	
	#print(pos)
	var cells = tile_map_layer.get_used_cells()
	
	if Vector2i(pos[0],pos[1]-1) in cells:
		return null
	
	var result = Vector2i(0,0)
	
	if Vector2i(pos[0]-1,pos[1]-1) in cells:#cell[0]左上边有cell为1
		result[0] = 1
		
	elif !Vector2i(pos[0]-1,pos[1]) in cells :#cell左上边没有cell,cell[0]左边没有cell为-1
		result[0] = -1
	
	if Vector2i(pos[0]+1,pos[1]-1) in cells:#cell[1]右上边有cell为1
		result[1] = 1
	
	elif !Vector2i(pos[0] + 1,pos[1]) in cells:#cell右上边没有cell，cell[1]右边没有cell为-1
		result[1] = -1
	
	return result


func create_point(cell):
	var above = Vector2i(cell[0],cell[1]-1)
	
	var face = FACE.instantiate()
	var pos = tile_map_layer.map_to_local(above) 
	if graph.get_closest_point(pos) == -1:
		pass
	elif graph.get_point_position(graph.get_closest_point(pos)) == pos:
		return
	
	
	
	face.position = pos
	var type = cell_type(pos,true,true)
	#print(type)
	add_child(face)
	if type != null:
		face.set_label_text(type)
	
	graph.add_point(graph.get_available_point_id(),pos)
