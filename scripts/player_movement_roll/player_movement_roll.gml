function player_movement_roll() {
	// Decelerate
	if (!ground_lock) {
		if (button_check("btn_left")) {
			if (ground_speed > 0) {
				ground_speed -= roll_decel;
				if (ground_speed < 0) {
					ground_speed = -0.5;
				}
			} else {
				is_pushing = false;
				facing = LEFT;
			}
		}
		
		if (button_check("btn_right")) {
			if (ground_speed < 0) {
				ground_speed += roll_decel;
				if (ground_speed >= 0) {
					ground_speed = 0.5;
				}
			} else {
				is_pushing = false;
				facing = RIGHT;
			}
		}
	}

	// Apply friction
	if (ground_speed > 0) {
		ground_speed = max(ground_speed - roll_frict, 0);
	} else if (ground_speed < 0) {
		ground_speed = min(ground_speed + roll_frict, 0);
	}
	
	// Convert ground inertia to speeds
	hor_speed = ground_speed *  dcos(angle);
	ver_speed = ground_speed * -dsin(angle);
	
	// Limit rolling speed
	hor_speed = clamp(hor_speed, -16, 16);

	// Unroll
	if (!forced_roll) {
		if (ground_speed == 0 or abs(ground_speed) < 0.5) {
			pos_y -= default_radius_y - small_radius_y;
			radius_x = default_radius_x;
			radius_y = default_radius_y;		
			is_rolling = false;
			state = states.idle;
		}
	} else if (ground_speed == 0) {
		// If forced to roll, continue rolling
		ground_speed = 2;
	}
}
