function player_state_dashpanel(phase) {
	switch (phase) {
		// Start state
		case INIT:
			// Update variables
			is_rolling = true;
			ground_lock = 16;
			animation_play(anim_dashpanel);
			break;

		// Run state
		case STEP:
			// Update position
			if (!player_movement_ground()) {
				break;
			}
			
			// Falling
			if (!is_grounded) {
				player_set_state(player_state_roll);
				break;
			}
						
			// Fall from steep surfaces
	        if (relative_angle >= 90 and relative_angle <= 270) {
	            player_set_state(player_state_airbone);
				break;
	        }
			
			// Slide down from steep surfaces
			else if (relative_angle >= 45 and relative_angle <= 315) {
				ground_lock = stumble_timer;
				player_set_state(player_state_roll);
				break;
			}
			
			// Set new state
			if (!ground_lock) {
				var new_state = (force_roll) ? (player_state_roll) : (player_state_run);
				player_set_state(new_state);
			}
			break;
			
		// Stop state
		case STOP:
			break;
	}
}