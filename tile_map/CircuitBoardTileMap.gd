extends TileMap

const right_neighbor = Vector2(1, 3)
const left_neighbor = Vector2(2, 3)
const both_neighbors = Vector2(3, 3)
const no_neighbor = Vector2(4, 3)

func _ready():
	add_lower_borders()

func add_lower_borders():
	var cells = get_used_cells()
	for cell in cells:
		var lower_neighbor = get_cell(cell.x, cell.y + 1)
		if (lower_neighbor == -1):
			set_cell(cell.x, cell.y + 1, 1, false, false, false, find_neighbor_vector(cell.x, cell.y + 1))

func is_border(x: int, y: int):
	var coords = get_cell_autotile_coord(x, y)
	return coords == right_neighbor \
		or coords == left_neighbor \
		or coords == no_neighbor \
		or coords == both_neighbors

func find_neighbor_vector(x: int, y: int):
	var left = get_cell(x - 1, y)
	var left_up = get_cell(x - 1, y - 1) if not is_border(x - 1, y - 1) else -1
	var right = get_cell(x + 1, y)
	var right_up = get_cell(x + 1, y - 1) if not is_border(x + 1, y - 1) else -1

	if left == -1 and right == -1 and right_up == -1 and left_up == -1:
		return no_neighbor
	elif (right == 1 or right_up ==1) and left_up == -1:
		return right_neighbor
	elif (left == 1 or left_up == 1) and right_up == -1:
		return left_neighbor
	else:
		return both_neighbors
