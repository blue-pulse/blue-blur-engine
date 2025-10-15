function player_state_run(phase) {
	switch (phase) {
		// Start state
		case INIT:
			// Update variables
	        is_rolling = false;
			player_reset_combo();
	        break;
		
		// Run state
		case STEP:
			// Variables
			var input_dir = input_opposing(vb_left, vb_right);

			// Handle ground movement if not sliding down
			if (ground_lock <= 0) {
				if (input_dir != 0) {
					// Moving in the opposite direction
					if (hor_speed != 0 and sign(hor_speed) != input_dir) {
						// Turn around
						if (sign(image_xscale) == -input_dir and abs(hor_speed) <= skid_threshold) {
							player_set_state(player_state_turn);
							break;
						}
				
						// Skidding
						if (abs(hor_speed) > skid_threshold and mask_direction == gravity_direction) {
							player_play_sfx_skid();
							player_set_state(player_state_skid);
							break;
						}
						
						// Decelerate and reverse direction
						hor_speed += decel * input_dir;
						if (sign(hor_speed) == input_dir) {
							hor_speed = decel * input_dir;
						}
					}
					
					// Accelerate
					else {
						image_xscale = input_dir;
						if (abs(hor_speed) < speed_cap) {
							hor_speed += accel * input_dir;
							if (abs(hor_speed) > speed_cap) {
								hor_speed = speed_cap * input_dir;
							}
						}
					}
				}
				
				// Friction
				else {
					hor_speed -= min(abs(hor_speed), frict) * sign(hor_speed);
				}
			}
			
			// Update position
			if (!player_movement_ground()) {
				break;
			}
			
			// Falling
			if (!is_grounded) {
				player_state_airbone(INIT);
				break;
			}
			
			// Steep surfaces
	        if (abs(hor_speed) < stumble_threshold) {
				// Fall
	            if (relative_angle >= 90 and relative_angle <= 270) {
					player_state_airbone(INIT);
					break;
	            } 
				
				// Slide down
				else if (relative_angle >= 45 and relative_angle <= 315) {
					ground_lock = stumble_timer;
				}
	        }
			
			// Slope friction
			player_set_friction(slope_frict);
			
	        // Standing
			if (hor_speed == 0 and input_dir == 0) {
	            player_set_state(player_state_idle);
				break;
	        }
			
			// Jumping
	        if (input_pressed(vb_a)) {
				player_set_state(player_state_jump);
				break;
			}
			
			// Rolling
			if (input_dir == 0 and abs(hor_speed) >= roll_threshold and input_holded(vb_down)) {
				audio_play_sfx(snd_player_roll, REPLACE);
				player_is_rolling(INIT);
				break;
			}
			
			// Exit if pushing
			if (animation == anim_push and sign(image_xscale) == input_dir) {
				break;
			}
			
			// Animate
			player_play_run();
			
			// Set angle
	        image_angle = angle;
			break;
		
		// Stop state
		case STOP:
			ground_lock = 0;
			break;
	}
}