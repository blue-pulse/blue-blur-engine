function player_state_search(phase) {
	switch (phase) {
		// Start state
		case INIT:
			// Set animation
			animation_play(anim_search);
			break;

		// Run state
		case STEP:
			// Update position
			if (!player_movement_ground()) {
				break;
			}
			
			// Falling
			if (!is_grounded) {
				player_is_falling(INIT);
				break;
			}
			
			// Fall from steep surfaces
	        if (relative_angle >= 90 and relative_angle <= 270) {
	            player_is_falling(INIT);
				break;
	        }
			
			// Slide down from steep surfaces
			else if (relative_angle >= 45 and relative_angle <= 315) {
				ground_lock = stumble_timer;
				player_set_state(player_state_run);
				break;
			}
			
	        // Idle
			if (!input_holded(vb_up)) {
				player_set_state(player_state_idle);
				break;
			}
			
			// Running
	        if (hor_speed != 0) {
				player_set_state(player_state_run);
				break;
			}
			
			// Peelouting
	        if (input_pressed(vb_a)) {
				player_is_peelouting(INIT);
				break;
			}
		
		// Stop state
		case STOP:
			break;
	}
}