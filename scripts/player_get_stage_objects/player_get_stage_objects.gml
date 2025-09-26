function player_get_stage_objects() {
	// Erase recorded objects
	terrain_list = [];
	resource_list = [];
	
	// Initialize bounding rectangle
	var pos_x = floor(x);
	var pos_y = floor(y);
	var sine = dsin(mask_direction);
	var cosine = dcos(mask_direction);
	
	var pos_x_1 = pos_x - (cosine * x_wall_radius * 2) - (sine * y_radius * 2);
	var pos_y_1 = pos_y + (sine * x_wall_radius * 2) - (cosine * y_radius * 2);
	var pos_x_2 = pos_x + (cosine * x_wall_radius * 2) + (sine * y_radius * 2);
	var pos_y_2 = pos_y - (sine * x_wall_radius * 2) + (cosine * y_radius * 2);
	
	// Evaluate all stage objects
	with (obj_resource) {
		// Continue if not intersecting the bounding rectangle
		if (!collision_rectangle(pos_x_1, pos_y_1, pos_x_2, pos_y_2, id, true, false)) {
			continue;
		}
		
		// Get all solid objects
		if (!object_is_ancestor(object_index, obj_solid)) {
			// Continue if no reaction exists
			if (!reaction_index) {
				continue;
			}
			array_push(other.resource_list, id);
		}
		
		// Get all resources
		else {
			// Continue on collision layer mismatch
			if (plane != -1 and plane != other.plane) {
				continue;
			}
			array_push(other.terrain_list, id);
		}
	}
}
