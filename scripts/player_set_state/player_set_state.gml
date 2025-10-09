function player_set_state(_state, phase=INIT) {
	// Set variables
	state_prev = state;
	state = _state;
	
	// End previous state
	state_prev(STOP);

	// Execute state
	state(phase);
}
