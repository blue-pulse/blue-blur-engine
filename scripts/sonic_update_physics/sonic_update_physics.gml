function sonic_update_physics() {
	if (is_underwater) {
		// Underwater parameters
		accel = 0.0234375;
		air_accel = 0.046875;
		decel = 0.25;
		roll_decel = 0.125;
		frict = 0.0234375;
		roll_frict = 0.01171875;
		jump_height = -3.5;
		min_jump_height = -2;
		max_hor_speed = 3;
	} else {
		if (is_boosting) {
			// Boosting parameters
			accel = 0.09375;
			air_accel = 0.1875;
			frict = 0.09375;
			roll_frict = 0.046875;
			max_hor_speed = 12;
		} else {
			// Common parameters
			accel = 0.046875;
			air_accel = 0.09375;
			frict = 0.046875;
			roll_frict = 0.0234375;
			max_hor_speed = 10;
		}
		// Finally
		decel = 0.5;
		roll_decel = 0.125;
		jump_height = -6.5;
		min_jump_height = -4;
		stamina = clamp(stamina, 0, 100);
	}
}
