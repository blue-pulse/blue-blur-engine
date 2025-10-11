function player_state_init(phase) {
	switch (phase) {
		// Start state
	    case INIT:
	        break;
		
		// Run state
	    case STEP:
			player_set_state(player_state_idle);
	        break;
		
		// Stop state
	    case STOP:
	        break;
	}
}
