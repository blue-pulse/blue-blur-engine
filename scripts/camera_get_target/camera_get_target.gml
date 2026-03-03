function camera_get_target() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return Camera.target;
}
