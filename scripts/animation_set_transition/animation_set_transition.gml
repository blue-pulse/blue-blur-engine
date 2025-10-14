function animation_set_transition(_animation, _ending, _transition) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return new Transition(_animation, _ending, _transition);
}
