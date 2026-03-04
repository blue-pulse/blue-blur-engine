function player_set_trail_span(_trail_span) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Logic
	trail_span = _trail_span;
	trail_reference = _trail_span;
}
