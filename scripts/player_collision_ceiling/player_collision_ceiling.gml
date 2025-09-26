function player_collision_ceiling(height) {
	// Extend mask up to height
	for (var i = 0; i < height; ++i) {
		// Evaluate all solids
		for (var j = array_length(terrain_list) - 1; j > -1; --j) {
			// Get the current object
			var object = terrain_list[j];
			
			// Continue if passing through or not intersecting it
			if (object.semisolid or !collision_box_vertical(hor_radius, -i, mask_direction, object)) {
				continue;
			}
			
			// Confirm matching object
			return object;
		}
	}
	
	// No solid found
	return noone;
}
