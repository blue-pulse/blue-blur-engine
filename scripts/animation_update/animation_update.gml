function animation_update() {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Advance the animation and show its frame
	resnip_step(__animation_playback);
	resnip_instance_sync(__animation_playback);
}
