function player_collision_resource() {
	// Evaluate all non-terrain objects
	for (var i = array_length(resource_list) - 1; i > -1; --i) {
		// Get the current object
		var object = resource_list[i];
		
		// Continue if not intersecting it
		var facing_dir = mask_direction mod 180 != 0;
		if (!collision_box(x_radius, y_radius, facing_dir, object)) {
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
