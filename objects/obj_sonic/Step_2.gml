if (allow_movement) {
	// Update physics parameters
	sonic_params_update();
	
	// Update animations
	sonic_states_anim();
	player_rotation_update();
}
