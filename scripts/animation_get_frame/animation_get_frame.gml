function animation_get_frame() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return ae_snip_current_frame;
}
