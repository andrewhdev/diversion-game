extends Node2D

const center_offset := Vector2(16, 16)

onready var board = $CircuitBoardTileMap

var line_points: PoolVector2Array = []
var last_tile_coords := Vector2(-1, -1)

func _ready():
	pass # Replace with function body.

func is_adjacent(vec1: Vector2, vec2: Vector2):
	var abs_x = abs(vec1.x - vec2.x)
	var abs_y = abs(vec1.y - vec2.y)
	return (abs_x == 1 and abs_y == 0) or (abs_y == 1 and abs_x == 0)

func has_point(position: Vector2):
	return $WireTileMap.get_cellv(position) == 0

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		place_point(false)

func place_point(temp: bool):
	var mouse_pos = get_global_mouse_position()
	var tile = board.world_to_map(mouse_pos)
	var last_tile_is_adjacent = true if last_tile_coords == Vector2(-1, -1) else is_adjacent(tile, last_tile_coords)
	if board.get_cellv(tile) == 1 and not board.is_border(tile.x, tile.y) and last_tile_is_adjacent and not has_point(tile):
		$WireTileMap.set_cellv(tile, 0)
		var line_pos = board.map_to_world(tile) + center_offset
		line_points.append(line_pos)
		last_tile_coords = tile
		$Line2D.set_points(line_points)
