function player_state_skid(phase) {
	switch (phase) {
		// Start state
	    case INIT:
			// Set animation
			if (abs(hor_speed) >= 6) {
				animation_play(anim_skid_fast);
			} else {
				animation_play(anim_skid_slow);
			}
	        break;
		
		// Run state
	    case STEP:
			// Variables
			var input_dir = input_opposing(vb_left, vb_right);
			
			// Handle ground movement
			if (input_dir != 0) {
				if (sign(hor_speed) != input_dir) {
					if (ground_lock == 0) {
						// Apply deceleration
						hor_speed += decel * input_dir;
						
						// Turn around
						if (sign(hor_speed) == input_dir) {
							hor_speed = decel * input_dir;

	                        if (sign(image_xscale) != sign(hor_speed)) {
	                            animation_play(anim_skid_turn);
	                            player_set_state(player_state_turn);
								exit;
	                        }

	                        player_set_state(player_state_run);
							exit;
	                    }
					}
				}
				
				// Continue running
				else {
					player_set_state(player_state_run);
					exit;
				}
			} else {
	            player_set_state(player_state_run);
				exit;
	        }
			
			// Update position
			if (!player_movement_ground()) {
				exit;
			}
			
			// Falling
			if (!is_grounded) {
				player_is_falling(INIT);
				exit;
			}
						
			// Steep surfaces
	        if (abs(hor_speed) < stumble_threshold) {
				// Fall
	            if (relative_angle >= 90 and relative_angle <= 270) {
					player_is_falling(INIT);
					exit;
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
				exit;
	        }
			
			// Jumping
	        if (input_pressed(vb_a)) {
				player_is_falling(-2);
				exit;
			}
			
			// Rolling
			if (input_dir == 0 and abs(hor_speed) >= roll_threshold and input_holded(vb_down)) {
				//audio_play_sfx(sfxRoll);
				player_is_rolling(INIT);
				exit;
			}

			// Brake dust
			if (hor_speed != 0 and ticks mod 4 == 0) {
				var height = ver_radius - 6;
				var pos_x = floor(x) + dsin(angle) * height;
				var pos_y = floor(y) + dcos(angle) * height;
				part_particles_create(global.particles, pos_x, pos_y, global.brake_dust, 1);
			}
	        break;
		
		// Stop state
	    case STOP:
	        break;
	}
}
