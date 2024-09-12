function player_movement_roll() {
	// Decelerate
	if (!gnd_lock) {
		// Handle movement to the left
		if (button_check("btn_left")) {
			if (gnd_speed > 0) {
				gnd_speed -= roll_decel;
				if (gnd_speed < 0) {
					gnd_speed = -0.5;
				}
			} else {
				dir = LEFT;
				is_pushing = false;
			}
		}
		
		// Handle movement to the right
		if (button_check("btn_right")) {
			if (gnd_speed < 0) {
				gnd_speed += roll_decel;
				if (gnd_speed >= 0) {
					gnd_speed = 0.5;
				}
			} else {
				dir = RIGHT;
				is_pushing = false;
			}
		}
	}

	// Apply friction
	if (gnd_speed > 0) {
		gnd_speed = max(gnd_speed - roll_frict, 0);
	} else if (gnd_speed < 0) {
		gnd_speed = min(gnd_speed + roll_frict, 0);
	}

	// Unroll
	if (!forced_roll) {
		if (gnd_speed == 0 or abs(gnd_speed) < 0.5) {
			pos_y -= df_radius_y - sm_radius_y;
			radius_x = df_radius_x;
			radius_y = df_radius_y;
			is_rolling = false;
			player_set_state(states.idle);
		}
	}

	// If forced to roll, continue rolling
	else if (gnd_speed == 0) {
		gnd_speed = 4 * dir;
	}
	
	// Convert ground inertia to speeds
	hor_speed = gnd_speed * dcos(angle);
	ver_speed = gnd_speed * -dsin(angle);

	// Limit horizontal velocity
	gnd_speed = clamp(gnd_speed, -max_abs_speed, max_abs_speed);
	hor_speed = clamp(hor_speed, -max_abs_speed, max_abs_speed);

}
