function animation_set_successor(_animation, _successor, allow_transition=true) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return snip_set_successor(_animation, _successor, true);
}
