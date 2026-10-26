function animation_is_last_frame() {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Variables
	var playback = __animation_playback;
	var last_frame = (playback.direction == RESNIP_FORWARD) ? playback.snip.count - 1 : 0;

	// Return boolean
	return playback.frame == last_frame;
}
