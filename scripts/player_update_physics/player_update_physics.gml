function player_update_physics() {
	// Speed values
	speed_cap = 6;
	land_acceleration = 0.046875;
	land_deceleration = 0.5;
	land_friction = 0.046875;
	air_acceleration = 0.09375;
	roll_deceleration = 0.125;
	roll_friction = 0.0234375;
	
	// Aerial values
	gravity_cap = 16;
	gravity_force = 0.21875;
	recoil_gravity = 0.1875;
	jump_height = 6.5;
	jump_release = 4;
	
	// Superspeed modification
	if (superspeed_time > 0) {
		speed_cap *= 2;
		land_acceleration *= 2;
		land_friction *= 2;
		air_acceleration *= 2;
		roll_friction *= 2;
	}
}
