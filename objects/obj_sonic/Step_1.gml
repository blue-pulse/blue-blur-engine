if (allow_movement) {
	// Update states
	sonic_states_update();
	player_physics_update();
	
	// Update boost flag
	player_boost_update();
	
	// Update hitbox based on state
	player_hitbox_update();
}
