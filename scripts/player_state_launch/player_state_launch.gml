function player_state_launch(phase) {
	switch (phase) {
		// Start state
		case INIT:
			player_set_ground(noone);
			animation_play(anim_launch);
			break;

		// Run state
		case STEP:			
	        // Update position
			if (!player_movement_air()) {
				break;
			}
			
	        // Landing
	        if (is_grounded) {
				if (hor_speed == 0) {
					player_set_state(player_state_idle);
				} else {
					player_set_state(player_state_run);
				}
				break;
	        }
	
	        // Air friction
	        if (ver_speed < 0 and ver_speed > -4 and abs(hor_speed) > air_threshold) {
				hor_speed *= air_frict;
	        }
			
	        // Gravity
			if (ver_speed < grav_cap) {
				ver_speed = min(ver_speed + grav_force, grav_cap);
			}
			
			// Airbone
			if (!air_lock) {
				// Set state
				player_set_state(player_state_airbone, STEP);
				
				// Animate
				if (!is_rolling) {
					animation_play(anim_fall_fast);
				}
				break;
			}
			break;
		
		// Stop state
		case STOP:
			break;
	}
}
