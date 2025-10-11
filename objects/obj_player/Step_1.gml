if (allow_movement) {
	// Update timers
	player_update_params();

	// State machine
	state(STEP);

	// Save position
	player_update_grid();

	// Update animation
	player_update_animation();
}
