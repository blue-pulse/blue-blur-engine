function player_set_state(_state, reset_index = true) {
	// Reset image index
	if (reset_index) {
		image_index = 0;
		image_speed = 1;
	}
	
	// Set new state
	state = _state;
}