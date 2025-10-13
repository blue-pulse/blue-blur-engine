function player_state_idle(phase) {
	switch (phase) {
		// Start state
		case INIT:
			// Update variables
	        is_rolling = false;
			player_reset_combo();
			player_update_cliff();
			
			// Animate idle
			if (cliff_dir == 0) {
				animation_play(anim_idle);
			}
			
			// Animate balance
			else if (cliff_dir == image_xscale) {
				animation_play(anim_balance_front);
			} else {
				animation_play(anim_balance_back);
			}
			
			// Set angle
			image_angle = gravity_direction;
			break;
		
		// Run state
		case STEP:
			// Variables
			var input_dir = input_opposing(vb_left, vb_right);
			
			// Update position
			if (!player_movement_ground()) {
				exit;
			}
			
			// Falling
			if (!is_grounded) {
				player_is_falling(INIT);
				exit;
			}
			
			// Fall from steep surfaces
	        if (relative_angle >= 90 and relative_angle <= 270) {
	            player_is_falling(INIT);
				exit;
	        }
			
			// Slide down from steep surfaces
			else if (relative_angle >= 45 and relative_angle <= 315) {
				ground_lock = stumble_timer;
				player_set_state(player_state_run);
				exit;
			}
			
			// Turn-around
			if (input_dir != 0 and sign(image_xscale) != input_dir) {
				player_set_state(player_state_turn);
				exit;
			}
			
	        // Running
	        if (input_dir != 0 or hor_speed != 0) {
	            player_set_state(player_state_run);
				exit;
	        }
			
			// Jumping
	        if (input_pressed(vb_a)) {
				player_is_falling(-2);
				exit;
			}
			
			// Idle actions
			if (cliff_dir == 0) {
				// Look-up
				if (input_holded(vb_up)) {
					player_set_state(player_state_search);
					exit;
				}
				
				// Crouch
				if (input_holded(vb_down)) {
					player_set_state(player_is_crouching);
					exit;
				}
			}
			break;
			
		// Stop state
		case STOP:
			break;
	}
}