function player_collision_actor() {
	// Evaluate all non-terrain objects
	for (var i = array_length(actor_list) - 1; i > -1; --i) {
		// Get the current object
		var object = actor_list[i];
		
		// Continue if not intersecting it
		var facing_dir = (mask_direction mod 180) != 0;
		if (!collision_box(hor_radius, ver_radius, facing_dir, object)) {
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
