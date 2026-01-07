function player_state_idle(phase) {
	switch (phase) {
		// Start state
		case INIT:
			// Update variables
	        is_rolling = false;
			player_reset_combo();
			player_update_cliff();
			break;
		
		// Run state
		case STEP:
			// Variables
			var input_dir = input_opposing(vb_right, vb_left);
			
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
			
			// Wait for next frame
			if (ground_lock) {
				break;
			}
			
			// Turn-around
			if (input_dir != 0 and dir != input_dir) {
				player_set_state(player_state_turn);
				break;
			}
			
	        // Running
	        if (input_dir != 0 or hor_speed != 0) {
	            player_set_state(player_state_run);
				break;
	        }
			
			// Jumping
	        if (input_pressed(vb_a)) {
				player_set_state(player_state_jump);
				break;
			}
			
			// Idle actions
			if (cliff_dir == 0) {
				// Animate idle
				animation_play(anim_idle);
				
				// Looking up
				if (input_holded(vb_up)) {
					player_set_state(player_state_search);
					break;
				}
				
				// Crouching
				if (input_holded(vb_down)) {
					player_set_state(player_state_crouch);
					break;
				}
			} else {
			    // Animate balance
				var anim_balance = (cliff_dir == dir) ? (anim_balance_front) : (anim_balance_back);
			    animation_play(anim_balance);
			}
			break;
			
		// Stop state
		case STOP:
			break;
	}
}