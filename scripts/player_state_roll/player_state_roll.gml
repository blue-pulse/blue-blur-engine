function player_state_roll(phase) {
	switch (phase) {
		// Start state
		case INIT:
			// Variables
	        is_rolling = true;
			allow_jump_action = false;
			
			// FX
			play_roll_anim();
			if (state_prev != player_state_spindash) {
				audio_play_sfx(snd_player_roll, REPLACE);
			}
	        break;
		
		// Run state
		case STEP:
			// Deceleration
			if (ground_lock <= 0) {
				// Left
				if (hor_speed > 0 and input_holded(vb_left)) {
					hor_speed -= roll_decel;
					if (hor_speed < 0) {
						hor_speed = 0;
					}
				}
				
				// Right
				if (hor_speed < 0 and input_holded(vb_right)) {
					hor_speed += roll_decel;
					if (hor_speed > 0) {
						hor_speed = 0;
					}
				}
				
				// Friction
				var abs_speed = abs(hor_speed);
				hor_speed -= sign(hor_speed) * min(abs_speed, roll_frict);
			}
			
			// Update position
			if (!player_movement_ground()) {
				break;
			}
			
			// Falling
			if (!is_grounded) {
				image_angle = gravity_direction;
				player_set_state(player_state_airbone);
				break;
			}
			
			// Slide down steep surfaces
	        if (abs(hor_speed) < stumble_threshold) {
	            if (relative_angle >= 90 and relative_angle <= 270) {
					image_angle = gravity_direction;
					player_set_state(player_state_airbone);
					break;
	            } else if (relative_angle >= 45 and relative_angle <= 315) {
					ground_lock = stumble_timer;
				}
	        }
			
			// Slope friction
			if (sign(hor_speed) == sign(dsin(relative_angle))) {
				player_set_friction(slope_frict_up);
			} else {
				player_set_friction(slope_frict_down);
			}
			
			// Jumping
	        if (input_pressed(vb_a)) {
				player_set_state(player_state_jump);
				break;
			}
			
			// Unroll
			if (abs(hor_speed) < unroll_threshold) {
				player_set_state(player_state_run);
				break;
			}
			
			// Animate
			play_roll_anim();
			
	        // Set facing direction
			if ((hor_speed < 0 and input_holded(vb_left)) or (hor_speed > 0 and input_holded(vb_right))) {
	            image_xscale = sign(hor_speed);
	        }
			break;
		
		// Stop state
		case STOP:
			break;	
	}
}
