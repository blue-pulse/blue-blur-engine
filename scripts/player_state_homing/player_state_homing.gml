function player_is_homing(phase) {
	switch (phase) {
		// Start state
		case INIT:
			// Set flags
			state = player_is_homing;
			is_jumping = false;
			break;
		
		// Run state
		case STEP:
			// Update position
			if (!player_movement_air()) {
				break;
			}
			
			// Fall if the reticle can no longer be locked on to
			if (!player_can_lock_on(obj_reticle.target)) {
				// Variables
				is_jumping = true;
				jump_action = false;
				ver_speed = -dsin(relative_angle) * hor_speed;
				hor_speed = dcos(relative_angle) * hor_speed;
			
				// Destroy reticle
				instance_destroy(obj_reticle);
				
				// Set state
				player_set_ground(noone);
				player_set_state(player_state_jump, STEP);
				break;
			}
			
			// Move towards the reticle
			var homing_speed = 12;
			var dir = point_direction(x, y, obj_reticle.x, obj_reticle.y) - mask_direction;
			hor_speed = lengthdir_x(homing_speed, dir);
			ver_speed = lengthdir_y(homing_speed, dir);
			break;
		
		// Stop state
		case STOP:
			break;
	}
}
