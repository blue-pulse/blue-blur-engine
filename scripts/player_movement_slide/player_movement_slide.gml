function player_movement_slide() {
	// Early exit
	if ((angle > 45 and angle < 316.41) or button_check("btn_down")) {
		is_rolling = true;
		player_set_state(states.rolling);
		audio_play_sfx(snd_player_roll);
		return;
	}

	// Decelerate
	if (!gnd_lock) {
		// Handle movement to the right
		if (button_check("btn_left")) {
			if (gnd_speed > 0) {
				gnd_speed -= decel;
				if (gnd_speed < 0) {
					gnd_speed = -0.5;
				}
			} else {
				is_pushing = false;
				dir = LEFT;
			}
		}
		
		// Handle movement to the right
		if (button_check("btn_right")) {
			if (gnd_speed < 0) {
				gnd_speed += decel;
				if (gnd_speed >= 0) {
					gnd_speed = 0.5;
				}
			} else {
				is_pushing = false;
				dir = RIGHT;
			}
		}
	}

	// Apply friction
	if (gnd_speed > 0) {
		gnd_speed = max(gnd_speed - frict, 0);
	} else if (gnd_speed < 0) {
		gnd_speed = min(gnd_speed + frict, 0);
	}
	
	// Stop sliding
	if (!forced_slide) {
		if (gnd_speed == 0 or abs(gnd_speed) < 1) {
			pos_y -= big_radius_y - small_radius_y;
			radius_x = big_radius_x;
			radius_y = big_radius_y;
			player_set_state(states.moving);
		}
	}
	
	// If forced to slide, continue sliding
	else if (gnd_speed == 0) {
		gnd_speed = 2 * dir;
	}

	// Convert ground inertia to speeds
	hor_speed = gnd_speed * dcos(angle);
	ver_speed = gnd_speed * -dsin(angle);

	// Limit horizontal speed
	gnd_speed = clamp(gnd_speed, -max_abs_speed, max_abs_speed);
	hor_speed = clamp(hor_speed, -max_abs_speed, max_abs_speed);
}
