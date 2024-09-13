if (allow_movement) {
	// Update states
	player_physics_update();
	
	// Update hitbox based on state
	player_hitbox_update();
}
