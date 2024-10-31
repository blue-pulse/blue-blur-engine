function player_update_physics() {
	if (is_underwater) {
		// Underwater parameters
		accel = 0.0234375;
		air_accel = 0.046875;
		decel = 0.25;
		frict = 0.0234375;
		jmp_height = -3.5;
		min_jmp_height = -2;
		max_hor_speed = 3;
		roll_decel = 0.125;
		roll_frict = 0.01171875;
	} else {
		// Common parameters
		accel = 0.046875;
		air_accel = 0.09375;
		decel = 0.5;
		frict = 0.046875;
		jmp_height = -6.5;
		min_jmp_height = -4;
		max_hor_speed = 6;
		roll_decel = 0.125;
		roll_frict = 0.0234375;
	}
}