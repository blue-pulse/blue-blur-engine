function player_state_lock(phase) {
	switch (phase) {
		// Start state
		case INIT:
			is_rolling = false;
			hor_speed = 0;
			ver_speed = 0;
			break;
		
		// Run state
		case STEP:
			break;

		// Stop state
		case STOP:
			break;
	}
}
