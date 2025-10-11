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
				player_set_animation(anim_idle);
			}
			
			// Animate balance
			else if (cliff_dir == image_xscale) {
				player_set_animation(anim_balance_front);
			} else {
				player_set_animation(anim_balance_back);
			}
			
			// Set angle
			image_angle = gravity_direction;
			break;
		
		// Run state
		case STEP:
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
				gnd_lock = slide_timer;
				player_state_run(INIT);
				exit;
			}

	        // Running
	        if (hor_speed != 0 or input_check(vb_left) or input_check(vb_right)) {
	            player_state_run(INIT);
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
				if (input_check(vb_up)) {
					player_is_looking(INIT);
					exit;
				}
				
				// Crouch
				if (input_check(vb_down)) {
					player_is_crouching(INIT);
					exit;
				}
			}
			break;
			
		// Stop state
		case STOP:
			break;
	}
}