extends GridMap

export(Array, PackedScene) var scene_array : Array = [];

func _ready():
	for cell in get_used_cells():
		var cell_id : int = get_cell_item(cell.x, cell.y, cell.z);
		if cell_id + 1 > scene_array.size():
			continue;
		if scene_array[cell_id] == null:
			continue;
		var child : Spatial = scene_array[cell_id].instance();
		child.name += str(cell);
		add_child(child);
		child.global_transform.origin = map_to_world(cell.x, cell.y, cell.z);
		set_cell_item(cell.x, cell.y, cell.z, -1);
