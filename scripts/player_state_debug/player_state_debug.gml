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
			x += input_axis(vb_right, vb_left) * 8;
			y += input_axis(vb_down, vb_up) * 8;
			player_in_room();
			break;

		// Stop state
		case STOP:
			break;
	}
}
