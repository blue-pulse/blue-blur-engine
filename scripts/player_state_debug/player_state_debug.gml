function player_state_debug(phase) {
	switch (phase) {
		// Start state
		case INIT:
			// Set variables
			is_rolling = false;
			hor_speed = 0;
			ver_speed = 0;
			
			// Go airbone
			player_set_ground(noone);
			break;
		
		// Run state
		case STEP:
			// Fly around
			x += (input_holded(vb_right) - input_holded(vb_left)) * 8;
			y += (input_holded(vb_down) - input_holded(vb_up)) * 8;
			player_in_view();
			break;

		// Stop state
		case STOP:
			break;
	}
}
