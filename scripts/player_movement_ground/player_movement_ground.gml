function player_movement_ground() {
	// Ride moving platforms
	with (ground_id) {
		// Horizontal motion
		var hor_offset = x - xprevious;
		if (hor_offset != 0) {
			other.x += hor_offset;
		}
		
		// Vertical motion
		var ver_offset = y - yprevious;
		if (ver_offset != 0) {
			other.y += ver_offset;
		}
	}
	
	// Variables for horizontal movement
	var total_steps = 1 + (abs(hor_speed) div hor_radius);
	var increment = hor_speed / total_steps;
	
	// Process movement loop
	repeat (total_steps) {
		// Apply movement step
		x += dcos(angle) * increment;
		y -= dsin(angle) * increment;
		
		// Die if out of bounds
		if (!player_in_view()) {
			player_is_dead(-1);
			return false;
		}
		
		// Find surrounding stage objects
		player_update_objects();
		
		// Handle wall collision
		var hit_wall = player_collision_wall(0);
		if (hit_wall) {
			// Try to eject from wall
			var wall_sign = player_wall_eject(hit_wall);
			
			// Trigger reaction
			if (player_get_reaction(hit_wall, wall_sign)) {
				return false;
			}
			
			// Stop if moving towards wall
			if (sign(hor_speed) == wall_sign) {
				// Cancel speed
				hor_speed = 0;
				
				// Set pushing animation
				var input_dir = input_opposing(vb_left, vb_right);
				if (input_dir == wall_sign and image_xscale == wall_sign) {
					player_wall_push(hit_wall, wall_sign);
				}
			}
		}
		
		// Handle floor collision
		var hit_floor = player_collision_floor(ver_radius * 2);
		if (hit_floor) {
			// Trigger reaction
			if (player_get_reaction(hit_floor, DIR_BOTTOM)) {
				return false;
			}
			
			// Get floor data
			player_set_ground(hit_floor);
		}
		
		// Fall off
		else {
			is_grounded = false; 
		}
		
		// Update mask direction
		if (is_grounded) {
			player_update_angle();
		}
		
		// Handle non-solid object collision
		if (player_collision_resource()) {
			return false;
		}
	}
	
	// Success
	return true;
}
