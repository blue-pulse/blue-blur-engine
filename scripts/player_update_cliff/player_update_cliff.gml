function player_update_cliff() {
	// Variables
	var height = ver_radius * 2;
	var left_sensor_hit = false;
	var right_sensor_hit = false;
	
	// Reset cliff direction
	cliff_dir = 0;
	
	// Evaluate all solids
	for (var i = array_length(terrain_list) - 1; i > -1; --i) {
		// Get the current solid
		var object = terrain_list[i];
		
		// Center collision means not on a cliff
		if (collision_ray_vertical(0, height, mask_direction, object)) {
			exit;
		}
		
		// Check left sensor
		if (!left_sensor_hit and collision_ray_vertical(-hor_radius, height, mask_direction, object)) {
			left_sensor_hit = true;
		}
		
		// Check right sensor
		if (!right_sensor_hit and collision_ray_vertical(hor_radius, height, mask_direction, object)) {
			right_sensor_hit = true;
		}
	}
	
	// Check if only one edge is touching
	if (left_sensor_hit xor right_sensor_hit) {
		cliff_dir = left_sensor_hit - right_sensor_hit;
	}
}
