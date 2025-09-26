function player_collision_floor(height) {
	// Extend mask up to height
	for (var oy = 0; oy < height; ++oy)
	{
		// Evaluate all solids
		for (var n = array_length(solid_objects) - 1; n > -1; --n)
		{
			// Get the current solid
			var inst = solid_objects[n];
			
			// Continue if...
			if (inst.semisolid and collision_ray(x_radius, 0, mask_direction, inst) != noone) continue; // Passing through it
			if (collision_box_vertical(x_radius, oy, mask_direction, inst) == noone) continue; // Not intersecting it
			
			// Confirm matching solid
			return inst;
		}
	}
	
	// No solid found
	return noone;
}
