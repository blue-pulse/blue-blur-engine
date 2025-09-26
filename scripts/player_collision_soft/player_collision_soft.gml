function player_collision_soft() {
	// Evaluate all non-terrain objects
	for (var i = array_length(soft_objects) - 1; i > -1; --i) {
		// Get the current object
		var object = soft_objects[i];
		
		// Continue if not intersecting it
		if (!collision_box(x_radius, y_radius, (mask_direction mod 180 != 0), object)) {
			continue;
		}
		
		// Trigger reaction to end current state
		if (player_react(object)) {
			return true;
		}
	}
	
	// Do not abort state
	return false;
}
