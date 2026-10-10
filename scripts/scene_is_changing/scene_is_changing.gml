function scene_is_changing() {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Return boolean
	return is_fading != noone;
}
