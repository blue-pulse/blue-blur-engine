function player_state_hurt(phase) {
	switch (phase) {
		// Start state
		case INIT:
			// Set variables
	        is_rolling = false;
			force_roll = false;
			player_set_ground(noone);
			
			// Animate
			animation_play(anim_hurt);
			break;
		
		// Run state
		case STEP:
			// Update position
			if (!player_movement_air()) {
				recovery_timer = 120;
				break;
			}
			
			// Landing
			if (is_grounded) {
				// Temporary invencibility
				hor_speed = 0;
				recovery_timer = 120;
				
				// Knock-out
				player_set_state(player_state_knockout);
				break;
			}
			
			// Gravity
			if (ver_speed < grav_cap) {
				ver_speed = min(ver_speed + grav_recoil, grav_cap);
			}
			break;
		
		// Stop state
		case STOP:
			break;
	}
}
