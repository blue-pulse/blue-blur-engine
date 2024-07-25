function player_movement_air() {
	// Rotate angle back to 360 degrees
	if (angle < 180) {
		angle = max(angle - 2.8125, 0);
	} else {
		angle = min(angle + 2.8125, 360);
	}

	// Limit vertical speed if not jumping
	if (!is_jumping and ver_speed < -max_ver_speed) {
		ver_speed = -max_ver_speed;
	}

	if (!air_lock) {
		// Go left
		if (button_check("btn_left")) {
			if (hor_speed > 0) {
				// Decelerate
				hor_speed -= air_accel;
			} else if (hor_speed > -max_hor_speed) {
				// Accelerate
				hor_speed -= air_accel;

				if (hor_speed <= -max_hor_speed) {
					hor_speed = -max_hor_speed;
				}
			}

			// Set direction
			dir = LEFT;
		}

		// Go right
		if (button_check("btn_right")) {
			if (hor_speed < 0) {
				// Decelerate
				hor_speed += air_accel;
			} else if (hor_speed < max_hor_speed) {
				// Accelerate
				hor_speed += air_accel;

				if (hor_speed >= max_hor_speed) {
					hor_speed = max_hor_speed;
				}
			}

			// Set direction
			dir = RIGHT;
		}
	}

	// Apply air drag
	if (!is_being_hurt and ver_speed < 0 and ver_speed > -4) {
		hor_speed -= floor(hor_speed / 0.125) / 256;
	}
}
