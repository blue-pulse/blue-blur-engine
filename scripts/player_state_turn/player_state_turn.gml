function player_state_turn(phase) {
	switch (phase) {
		// Start state
	    case INIT:
			// Set animation
			if (abs(hor_speed) == decel) {
				animation_play(anim_skid_turn);
			} else {
				animation_play(anim_turn);
			}
			
			// Update variables
			dir = -dir;
			hor_speed = 0;
	        break;
		
		// Run state
	    case STEP:
			// Update position
			if (!player_movement_ground()) {
				break;
			}
			
			// Falling
			if (!is_grounded) {
				player_set_state(player_state_airbone);
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
				player_set_state(player_state_run);
				break;
			}

			// Return to idle
			if (!animation_get_callback(animation) and animation_ended()) {
				player_set_state(player_state_idle)
				break;
			}

			// Jumping
	        if (input_pressed(vb_a)) {
				player_set_state(player_state_jump);
				break;
			}
			
			// Rolling
			if (abs(hor_speed) >= roll_threshold and input_holded(vb_down) and input_opposing(vb_right, vb_left)) {
				player_set_state(player_state_roll);
				break;
			}
	        break;
		
		// Stop state
	    case STOP:
	        break;
	}
}
