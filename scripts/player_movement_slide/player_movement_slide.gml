function player_movement_slide() {
	// Early exit
	if (angle > 45 and angle < 316.41) {
		is_sliding = false;
		is_rolling = true;
		player_set_state(states.rolling);
		audio_play_sfx(snd_player_roll);
		return;
	}
	
	// Decelerate
	if (!gnd_lock) {
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

	// Convert ground inertia to speeds
	hor_speed = gnd_speed * dcos(angle);
	ver_speed = gnd_speed * -dsin(angle);

	// Speed cap
	gnd_speed = clamp(gnd_speed, -max_abs_speed, max_abs_speed);
	hor_speed = clamp(hor_speed, -max_abs_speed, max_abs_speed);
	
	// Stop sliding
	if (abs(gnd_speed) <= 1 or !button_check("btn_2")) {
		pos_y -= df_radius_y - sm_radius_y;
		radius_x = df_radius_x;
		radius_y = df_radius_y;
		is_sliding = false;
		player_set_state(states.moving);
	}
}
