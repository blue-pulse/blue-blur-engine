function buffer_destroy(buffer) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Logic
	if (buffer_exists(buffer)) {
		buffer_delete(buffer);
	}
}
