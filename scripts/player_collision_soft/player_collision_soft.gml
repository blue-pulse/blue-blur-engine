function player_collision_soft() {
	// Evaluate all non-solids
	for (var n = array_length(soft_objects) - 1; n > -1; --n)
	{
		// Get the current non-solid
		var inst = soft_objects[n];
		
		// Continue if not intersecting it
		if (collision_box(x_radius, y_radius, (mask_direction mod 180 != 0), inst) == noone) continue;
		
		// Trigger reaction; abort state if applicable
		if (player_react(inst)) return true;
	}
	
	// Do not abort state
	return false;
}