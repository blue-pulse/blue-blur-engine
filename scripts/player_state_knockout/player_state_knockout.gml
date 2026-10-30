function player_state_knockout(phase) {
	switch (phase) {
		// Start state
		case INIT:
			break;
		
		// Run state
		case STEP:
			// Update position
			if (!player_movement_ground()) {
				break;
			}
			
			// Stand up
			if (recovery_timer <= 50) {
				player_set_state(player_state_idle);
			}
			break;
		
		// Stop state
		case STOP:
			ground_lock = 30;
			break;
	}
}
