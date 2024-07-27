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
		if (button_check("btn_left")) {
			// Decelerate
			if hor_speed > 0 {
				hor_speed -= air_accel;
			}

			// Accelerate
			else if (hor_speed > -max_hor_speed) {
				hor_speed -= air_accel;
				if (hor_speed <= -max_hor_speed) {
					hor_speed = -max_hor_speed;
				}
			}
			dir = LEFT;
		}
		if (button_check("btn_right")) {
			// Decelerate
			if (hor_speed < 0) {
				hor_speed += air_accel;
			}

			// Accelerate
			else if (hor_speed < max_hor_speed) {
				hor_speed += air_accel;
				if (hor_speed >= max_hor_speed) {
					hor_speed = max_hor_speed;
				}
			}
			dir = RIGHT;
		}
	}
	
	// Airspeed cap
	ver_speed = clamp(ver_speed, -max_abs_speed, max_abs_speed);

	// Apply air drag
	if (!is_being_hurt and ver_speed < 0 and ver_speed > -4) {
		hor_speed -= floor(hor_speed / 0.125) / 256;
	}
}
