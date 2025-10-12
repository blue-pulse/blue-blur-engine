function animation_ended() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	var current_frame = ae_snip_current_frame;
	var last_frame = ae_snip_current_snip.snip_frame_end
	return (current_frame == last_frame);
}
