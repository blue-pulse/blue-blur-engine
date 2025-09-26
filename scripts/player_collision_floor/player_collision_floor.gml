function player_collision_floor(height) {
	// Extend mask up to height
	for (var i = 0; i < height; ++i) {
		// Evaluate all solids
		for (var j = array_length(solid_objects) - 1; j > -1; --j) {
			// Get the current object
			var object = solid_objects[j];
			
			// Continue if passing through it
			if (object.semisolid and collision_ray(x_radius, 0, mask_direction, object)) {
				continue;
			}
			
			// Continue if not intersecting it
			if (!collision_box_vertical(x_radius, i, mask_direction, object)) {
				continue;
			}
			
			// Confirm matching object
			return object;
		}
	}
	
	// No solid found
	return noone;
}
