function player_stop_trail() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Logic
	player_set_trail_span(0);
}
