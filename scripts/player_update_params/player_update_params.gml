function player_update_params() {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Recovery frames handling
	if (recovery_timer) {
		alpha = (recovery_timer & 4 > 0) * 1;
		if (--recovery_timer == 0) {
			alpha = 1;
		}
	}
	
	// Ground flags
	if (is_grounded) {
		// Reset flags
		allow_jump_action = false;
		
		// Reduce ground lock
		if (ground_lock) {	
			--ground_lock;
		}
	}
}
