function player_state_turn(phase) {
	switch (phase) {
		// Start state
	    case INIT:
			// Update variables
			image_xscale *= -1;
			hor_speed = 0;
			
			// Set animation
			if (animation != anim_skid_turn) {
				animation_play(anim_turn);
			}
	        break;
		
		// Run state
	    case STEP:
			// Variables
			var input_dir = input_opposing(vb_left, vb_right);
			
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
			
			// Return to idle
			if (!animation_get_callback(animation) and animation_ended()) {
				player_set_state(player_state_idle)
				break;
			}

			// Jumping
	        if (input_pressed(vb_a)) {
				player_is_falling(-2);
				break;
			}
			
			// Rolling
			if (input_dir == 0 and abs(hor_speed) >= roll_threshold and input_holded(vb_down)) {
				//audio_play_sfx(sfxRoll);
				player_is_rolling(INIT);
				break;
			}
	        break;
		
		// Stop state
	    case STOP:
	        break;
	}
}
