function pause_is_allowed() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	return (
		// Game is paused
		input_pressed(vb_start) and game_has_focus() and
		
		// Player is alive
		instance_exists(Protagonist) and Protagonist.state != player_state_death and
		
		// No fading in process
		!is_fading
	);
}
