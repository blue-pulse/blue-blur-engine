function animation_is_playing(_animation) {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Return boolean
	return animation == _animation or __animation_playback.snip == _animation.__snip;
}
