function file_get_config() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return the active slot index
	return ssave_get(config_file);
}
