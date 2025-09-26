function player_collision_ceiling(height)
{
	// Extend mask up to height
	for (var oy = 0; oy < height; ++oy)
	{
		// Evaluate all solids
		for (var n = array_length(solid_objects) - 1; n > -1; --n)
		{
			// Get the current solid
			var inst = solid_objects[n];
			
			// Continue if passing through or not intersecting it
			if (inst.semisolid or collision_box_vertical(x_radius, -oy, mask_direction, inst) == noone) continue;
			
			// Confirm matching solid
			return inst;
		}
	}
	
	// No solid found
	return noone;
}
