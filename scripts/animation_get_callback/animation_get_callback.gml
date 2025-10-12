function animation_get_callback(_animation, frame=undefined) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	if (!frame) {
		return snip_get_completion_script(_animation);
	}
	return snip_get_frame_script(_animation, frame);
}
