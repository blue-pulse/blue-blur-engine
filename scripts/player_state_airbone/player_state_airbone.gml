function player_state_airbone(phase) {
	switch (phase) {
		// Start state
		case INIT:
			// Variables
			ver_speed = -dsin(relative_angle) * hor_speed;
			hor_speed = dcos(relative_angle) * hor_speed;
			player_set_ground(noone);
			
			// Animate
			if (!is_rolling) {
				animation_play(anim_fall_fast);
			}
			break;

		// Run state
		case STEP:
			// Handle aerial acceleration
			if (input_holded(vb_left)) {
				image_xscale = -1;
				if (hor_speed > -speed_cap) {
	                hor_speed = max(hor_speed - air_accel, -speed_cap);
				}
			} else if (input_holded(vb_right)) {
				image_xscale = 1;
	            if (hor_speed < speed_cap) {
	                hor_speed = min(hor_speed + air_accel, speed_cap);
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
			
			// Jump actions
			if (is_rolling) {
				begin_jump_action();
			}
			
			// Curl up
			else if (input_pressed(vb_a)) {
				// Set flags
				allow_jump_action = true;
				is_rolling = true;
				
				// Animate
				var abs_speed = abs(hor_speed);
				var anim_speed = map(abs_speed, 0, 8, 2, 3);
				animation_play(anim_spin_fast, anim_speed);
		        image_angle = gravity_direction;
			
				// Sound
			    audio_play_sfx(snd_player_wind, REPLACE);
				break;
			}
			
			// Animate
			if (animation == anim_rise and ver_speed >= 0) {
				animation_play(anim_freefall);
			}
			
			// Rotate angle
			if (!is_rolling and image_angle != angle) {
				var angle_diff = angle_difference(angle, image_angle);
				image_angle = angle_wrap(image_angle + sign(angle_diff) * 5);
	        }
			break;
		
		// Stop state
		case STOP:
			break;
	}
}