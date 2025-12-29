function player_state_jump(phase) {
	switch (phase) {
		// Start state
	    case INIT:
			// Set flags
	        is_jumping = true;
	        is_rolling = true;
	        allow_jump_action = true;
			
	        // Movement
			var sine = dsin(relative_angle);
			var cosine = dcos(relative_angle);
			ver_speed = (-sine * hor_speed) - (cosine * jump_height);
	        hor_speed = (cosine * hor_speed) - (sine * jump_height);
			player_set_ground(noone);
			
			// FX
			play_jump_anim();
		    audio_play_sfx(snd_player_jump, REPLACE);
		    audio_play_sfx(snd_player_wind, REPLACE);
	        break;
		
		// Run state
	    case STEP:
			// Handle aerial acceleration
			if (input_holded(vb_left)) {
				image_xscale = -1;
				if (hor_speed > -max_speed) {
	                hor_speed = max(hor_speed - air_accel, -max_speed);
				}
			} else if (input_holded(vb_right)) {
				image_xscale = 1;
	            if (hor_speed < max_speed) {
	                hor_speed = min(hor_speed + air_accel, max_speed);
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
			
			// Variable jump height
	        if (is_jumping and ver_speed < -jump_min_height and !input_holded(vb_a)) {
	            ver_speed = -jump_min_height;
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
	        break;
		
		// Stop state
	    case STOP:
	        break;
	}
}
