function player_in_cliff() {
	// Reset cliff direction
	cliff_sign = 0;
	
	// Initialize
	var left = false;
	var right = false;
	var height = ver_radius * 2;
	
	// Evaluate all solids
	for (var n = array_length(terrain_list) - 1; n > -1; --n)
	{
		// Get the current solid
		var inst = terrain_list[n];
		
		// Check sensors
		if (collision_ray_vertical(0, height, mask_direction, inst) != noone)
		{
			// Center collision means not on a cliff
			exit;
		}
		if (not left and collision_ray_vertical(-hor_radius, height, mask_direction, inst) != noone)
		{
			left = true;
		}
		if (not right and collision_ray_vertical(hor_radius, height, mask_direction, inst) != noone)
		{
			right = true;
		}
	}
	
	// Check if only one edge is touching
	if (left xor right) cliff_sign = left - right;
}
