function file_set_config(parameter, value) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return the active slot index
	return ssave_get(config_file).set(parameter, value);
}
