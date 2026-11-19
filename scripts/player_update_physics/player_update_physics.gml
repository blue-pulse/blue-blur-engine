function player_update_physics() {
	// Speed values
	max_speed = 6;
	accel = 0.046875;
	decel = 0.5;
	frict = 0.046875;
	air_accel = 0.09375;
	roll_decel = 0.125;
	roll_frict = 0.0234375;
	
	// Aerial values
	grav_cap = 16;
	grav_force = 0.21875;
	grav_recoil = 0.1875;
	jump_height = 6.5;
	jump_min_height = 4;
}
