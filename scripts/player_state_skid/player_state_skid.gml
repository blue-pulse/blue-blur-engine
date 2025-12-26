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
			
			// Early exit
			if (input_dir == 0 or mask_direction != gravity_direction) {
	            player_set_state(player_state_run);
				break;
			}
			
			// Handle ground movement
			if (sign(hor_speed) != input_dir) {
				if (ground_lock == 0) {
					// Apply deceleration
					hor_speed += decel * input_dir;
						
					// Trying to turn aroung
					if (sign(hor_speed) == input_dir) {
						hor_speed = decel * input_dir;
							
						// Turn around
						if (sign(image_xscale) != sign(hor_speed)) {
							animation_play(anim_skid_turn);
							player_set_state(player_state_turn);
						} else {
							player_set_state(player_state_run);
						}
						break;
					}
				}
			} else {
				player_set_state(player_state_run);
				break;
			}
			
			// Update position
			if (!player_movement_ground()) {
				break;
			}
			
			// Falling
			if (!is_grounded) {
				player_set_state(player_state_airbone);
				break;
			}
						
			// Steep surfaces
	        if (abs(hor_speed) < stumble_threshold) {
				// Fall
	            if (relative_angle >= 90 and relative_angle <= 270) {
					player_set_state(player_state_airbone);
					break;
	            } 
				
				// Slide down
				else if (relative_angle >= 45 and relative_angle <= 315) {
					ground_lock = stumble_timer;
					player_set_state(player_state_run);
					break;
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
				//audio_play_sfx(sfxRoll);
				player_is_rolling(INIT);
				break;
			}
			
			// Set angle
	        image_angle = angle;
			
			// Skid dust
			if (hor_speed != 0 and ticks mod 4 == 0) {
				var height = ver_radius - 6;
				var pos_x = floor(x + dsin(angle) * height);
				var pos_y = floor(y + dcos(angle) * height);
				part_particles_create(Particles, pos_x, pos_y, skid_dust, 1);
			}
	        break;
		
		// Stop state
	    case STOP:
	        break;
	}
}
