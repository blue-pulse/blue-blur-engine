function animation_get_frame() {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Return value
	return __animation_playback.frame;
}
