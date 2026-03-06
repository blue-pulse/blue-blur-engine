function pause_is_allowed() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return boolean
	return (
		// Game is unpaused
		paused_room == noone and
		
		// Trying to pause
		input_pressed(vb_start) and 
		
		// Player is alive
		instance_exists(Protagonist) and Protagonist.state != player_state_death and
		
		// No fading in process
		!is_fading and hud_is_visible()
	);
}
