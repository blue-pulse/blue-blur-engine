function player_in_cliff() {
	// Variables
	var height = ver_radius * 2;
	var left_sensor = false;
	var right_sensor = false;
	
	// Reset cliff direction
	cliff_sign = 0;
	
	// Evaluate all solids
	for (var i = array_length(terrain_list) - 1; i > -1; --i) {
		// Get the current solid
		var object = terrain_list[i];
		
		// Center collision means not on a cliff
		if (collision_ray_vertical(0, height, mask_direction, object)) {
			exit;
		}
		
		// Check left sensor
		if (!left_sensor and collision_ray_vertical(-hor_radius, height, mask_direction, object)) {
			left_sensor = true;
		}
		
		// Check right sensor
		if (!right_sensor and collision_ray_vertical(hor_radius, height, mask_direction, object)) {
			right_sensor = true;
		}
	}
	
	// Check if only one edge is touching
	if (left_sensor xor right_sensor) {
		cliff_sign = left_sensor - right_sensor;
	}
}
