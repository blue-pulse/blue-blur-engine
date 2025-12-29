function player_state_hurt(phase) {
	switch (phase) {
		// Start state
		case INIT:
			// Set variables
	        is_rolling = false;
			allow_jump_action = false;
			player_set_ground(noone);
			
			// Animate
			screen_shake(15);
			animation_play(anim_hurt);
			rotation = gravity_direction;
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
