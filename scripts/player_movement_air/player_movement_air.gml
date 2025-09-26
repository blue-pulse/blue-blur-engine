function player_movement_air() {
	// Variables
	var total_steps = 1 + (abs(hor_speed) div hor_radius);
	var steps = hor_speed / total_steps;
	
	// Process horizontal movement loop
	repeat (total_steps) {
		// Apply movement step
		x += dcos(angle) * steps;
		y -= dsin(angle) * steps;
		
		// Die if out of bounds
		if (!player_in_camera_bounds()) {
			player_is_dead(-1);
			return false;
		}
		
		// Find surrounding stage objects
		player_get_stage_objects();
		
		// Handle wall collision
		var hit_wall = player_collision_wall(0);
		if (hit_wall) {
			// Eject from wall
			var wall_sign = player_wall_eject(hit_wall);
			
			// Trigger reaction
			if (player_get_reaction(hit_wall, wall_sign)) {
				return false;
			}
			
			// Stop if moving towards wall
			if (sign(hor_speed) == wall_sign) {
				hor_speed = 0;
			}
		}
		
		// Handle non-solid object collision
		if (player_collision_resource()) {
			return false;
		}
	}
	
	// Initialize vertical movement loop
	total_steps = 1 + (abs(ver_speed) div ver_radius);
	steps = ver_speed / total_steps;
	
	// Process vertical movement loop
	repeat (total_steps) {
		// Apply movement steps
		x += dsin(angle) * steps;
		y += dcos(angle) * steps;
		
		// Die if out of bounds
		if (!player_in_camera_bounds()) {
			player_is_dead(-1);
			return false;
		}
		
		// Find surrounding stage objects
		player_get_stage_objects();
		
		// Floor collision
		if (ver_speed >= 0) {
			var hit_floor = player_collision_floor(ver_radius);
			if (hit_floor) {
				// Trigger reaction
				if (player_get_reaction(hit_floor, DIR_BOTTOM)) return false;
				
				// Get floor data
				player_set_ground(hit_floor);
				
				// Update mask direction
				player_rotate_mask();
			}
		}
		
		// Ceiling collision
		else {
			var hit_floor = player_collision_ceiling(ver_radius);
			if (hit_floor) {
				// Trigger reaction
				if (player_get_reaction(hit_floor, DIR_TOP)) {
					return false;
				}
				
				// Rotate mask to ceiling
				mask_direction = (mask_direction + 180) mod 360;
				
				// Get ceiling data
				player_set_ground(hit_floor);
				
				// Abort if rising too slow or ceiling is too shallow
				if (ver_speed > ceiling_land_threshold or (relative_angle > 135 and relative_angle < 225)) {
					// Slide against ceiling
					var sine = dsin(relative_angle);
					var cosine = dcos(relative_angle);
					var g_speed = (cosine * hor_speed) - (sine * ver_speed);
	                hor_speed = cosine * g_speed;
					ver_speed = -sine * g_speed;
					
					// Reset air state and exit loop
					player_set_ground(noone);
					break;
				}
			}
		}
		
		// Landing
		if (ground_id) {
			// Calculate landing speed
			if (abs(hor_speed) <= abs(ver_speed) and relative_angle >= 22.5 and relative_angle <= 337.5) {
				// Scale speed to incline
			    hor_speed = -ver_speed * sign(dsin(relative_angle));
			    if (relative_angle < 45 or relative_angle > 315) hor_speed *= 0.5;
			}
			
			// Stop falling
			ver_speed = 0;
			
			// Set flags and exit loop
			jumping = false;
			camera.ground_mode = true;
			break;
		}
		
		// Handle wall collision (again)
		hit_wall = player_collision_wall(0);
		if (hit_wall) {
			player_wall_eject(hit_wall);
		}
		
		// Handle non-solid object collision
		if (player_collision_resource()) {
			return false;
		}
	}
	
	// Success
	return true;
}
