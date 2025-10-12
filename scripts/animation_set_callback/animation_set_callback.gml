function animation_set_callback(_animation, callback, args=undefined, frame=undefined) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	if (!frame) {
		return snip_set_completion_script(_animation, frame, args);
	}
	return snip_set_frame_script(_animation, frame, callback, args);
}
