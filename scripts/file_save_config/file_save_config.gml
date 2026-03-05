function file_save_config() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Save the active slot index
	ssave_get(config_file).save();
}
