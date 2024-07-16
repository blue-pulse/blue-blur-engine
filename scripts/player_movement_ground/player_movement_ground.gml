function player_movement_ground() {
	if (spindash_revolutions == -1) {
		if (!ground_lock) {
			if (button_check("btn_left")) {	
				if (ground_speed > 0) {
					// Decelerate
					ground_speed -= decel;
					
					if (ground_speed <= 0) {
						ground_speed = -0.5;
					}
				} else {
					// Change direction
					if (facing != left) {
						facing = left;
						is_pushing = false;
					}
					
					// Accelerate
					if (ground_speed > -top_speed) {
						ground_speed = max(ground_speed - accel, -top_speed);
					} 
				}
			} else if (button_check("btn_right")) {	
				if (ground_speed < 0) {		
					// Decelerate
					ground_speed += decel;
					
					if (ground_speed >= 0) {
						ground_speed = 0.5;
					}
				} else {
					// Change direction
					if (facing != right) {
						facing = right;
						is_pushing = false;
					}
					
					// Accelerate
					if (ground_speed < top_speed) {
						ground_speed = min(ground_speed + accel, top_speed);
					}
				}
			}
		
			// Perform skid. angle check here is different in comparison to collision mode checks
			if ((state != states.skidding) and (angle <= 45 or angle >= 316.41)) {
				if (button_check("btn_left") and (ground_speed >= 4) or button_check("btn_right") and (ground_speed <= -4)) {
					state = states.skidding;
					audio_play_sfx(snd_player_skid, true);
				}
			}
		}
	
		// Apply friction
		if (!button_check("btn_left") and !button_check("btn_right")) {
			if (ground_speed > 0) {
				ground_speed = max(ground_speed - frict, 0);
			} else {
				ground_speed = min(ground_speed + frict, 0);
			}
			is_pushing = false;
		}

		// Convert ground inertia to speed
		horizontal_speed = ground_speed * dcos(angle);
		vertical_speed = ground_speed * -dsin(angle);
	
		// Set animation
		if (is_pushing) {
			state = states.pushing;
		} else if (ground_speed == 0) {
			// Same unsymmetrical angle check, just like above...
			if (angle <= 45 or angle >= 316.41) {
				if (button_check("btn_up")) {
					state = states.searching;
				} else if (button_check("btn_down")) {
					state = states.crouching;
				} else {
					state = states.idle;
				}
			}
		} else {
			if (state != states.skidding) {
				state = states.moving;
			} else if ((ground_speed > 0) and button_check("btn_right") or (ground_speed < 0) and button_check("btn_left")) {
				state = states.moving;
			}
		}
	}
}