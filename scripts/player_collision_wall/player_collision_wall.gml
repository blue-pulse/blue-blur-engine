function player_collision_wall(radius) {
	// Evaluate all solids
	for (var i = array_length(terrain_list) - 1; i > -1; --i) {
		// Get the current solid
		var object = terrain_list[i];
		
		// Continue if passing through or not intersecting it
		if (object.semisolid or !collision_ray(x_wall_radius + radius, 0, mask_direction, object)) {
			continue;
		}
		
		// Confirm matching solid
		return object;
	}
	
	// No solid found
	return noone;
}
