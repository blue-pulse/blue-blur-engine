if (allow_movement) {
	// Parameters
	player_update_params();
	sonic_update_physics();
	
	// Animation
	sonic_update_animation();
	player_update_rotation();
}
