function player_state_homing(phase) {
	switch (phase) {
		// Start state
		case INIT:
			// Set flags
			is_jumping = false;
			break;
		
		// Run state
		case STEP:
			// Update position
			if (!player_movement_air()) {
				break;
			}
			
			// Fall if the reticle can no longer be locked on to
			if (!player_can_lock_on(Reticle.target)) {
				// Variables
				is_jumping = true;
				allow_jump_action = false;
				ver_speed = -dsin(relative_angle) * hor_speed;
				hor_speed = dcos(relative_angle) * hor_speed;
			
				// Destroy reticle
				instance_destroy(Reticle);
				
				// Set state
				player_set_ground(noone);
				player_set_state(player_state_jump, STEP);
				break;
			}
			
			// Move towards the reticle
			var homing_speed = 12;
			var dir = point_direction(x, y, Reticle.x, Reticle.y) - mask_direction;
			hor_speed = lengthdir_x(homing_speed, dir);
			ver_speed = lengthdir_y(homing_speed, dir);
			break;
		
		// Stop state
		case STOP:
			break;
	}
}
