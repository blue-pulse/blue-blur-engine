function player_state_skid(phase) {
	switch (phase) {
		// Start state
	    case INIT:
			// Set animation
			if (abs(hor_speed) >= 6) {
				player_set_animation(anim_skid_fast);
			} else {
				player_set_animation(anim_skid_slow);
			}
	        break;
		
		// Run state
	    case STEP:
	        break;
		
		// Stop state
	    case STOP:
	        break;
	}
}
