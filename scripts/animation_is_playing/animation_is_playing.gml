function animation_is_playing(_animation, allow_transition=true) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Set value
	return snip_is_playing(_animation, allow_transition);
}
