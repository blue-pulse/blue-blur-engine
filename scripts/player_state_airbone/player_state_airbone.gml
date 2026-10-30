function player_state_airbone(phase) {
	switch (phase) {
		// Start state
		case INIT:
			// Variables
			force_roll = false;
			ver_speed = -dsin(relative_angle) * hor_speed;
			hor_speed = dcos(relative_angle) * hor_speed;
			player_set_ground(noone);
			break;

		// Run state
		case STEP:
			if (!air_lock) {
				// Left acceleration
				if (input_held(vb_left)) {
					dir = -1;
					if (hor_speed > -max_speed) {
		                hor_speed = max(hor_speed - air_accel, -max_speed);
					}
				}
			
				// Right acceleration
				if (input_held(vb_right)) {
					dir = 1;
		            if (hor_speed < max_speed) {
		                hor_speed = min(hor_speed + air_accel, max_speed);
		            }
				}
			}
			
	        // Update position
			if (!player_movement_air()) {
				break;
			}
			
	        // Landing
	        if (is_grounded) {
				if (hor_speed == 0) {
					player_set_state(player_state_idle);
				} else {
					player_set_state(player_state_run);
				}
				break;
	        }
	
	        // Air friction
	        if (ver_speed < 0 and ver_speed > -4 and abs(hor_speed) > air_threshold) {
				hor_speed *= air_frict;
	        }
			
	        // Gravity
			if (ver_speed < grav_cap) {
				ver_speed = min(ver_speed + grav_force, grav_cap);
			}
			
			// Wait for next frame
			if (air_lock) {
				break;
			}
			
			// Jump actions
			if (is_rolling) {
				player_routine_midair();
			}
			
			// Curl up
			else if (input_pressed(vb_a)) {
				// Set flags
				is_jumping = true;
				is_rolling = true;
				allow_jump_action = true;
				
				// FX
				rotation = gravity_direction;
				is_rising = false;
				curl_ups++;
			    mixer_play_effect(snd_player_wind, REPLACE);
				break;
			}
			
			// Stop rising
			if (is_rising and ver_speed >= 0) {
				is_rising = false;
			}
			break;
		
		// Stop state
		case STOP:
			is_rising = false;
			break;
	}
}
