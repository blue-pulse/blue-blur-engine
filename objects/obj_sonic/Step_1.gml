if (allow_movement) {
	// Main logic
	sonic_update_state();
	player_main();
	player_boost();

	// Hitbox
	player_update_hitbox();
}
