if (allow_movement) {
	// Update timers
	player_update_params();

	// State machine
	state(STEP);
	
	// Clamp speed
	hor_speed = clamp(hor_speed, -speed_cap, speed_cap);
	ver_speed = clamp(ver_speed, -speed_cap, speed_cap);
	
	// Show trail based on speed
	if (abs(hor_speed) >= 8 or abs(ver_speed) >= 8) {
		player_set_trail_span(80);
	}
	
	// Update values
	player_update_grid();
	player_update_rotation();
	player_update_animation();
}
