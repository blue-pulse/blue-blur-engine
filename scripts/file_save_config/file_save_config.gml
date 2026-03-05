function file_save_config() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Save the config
	ssave_get(cls_config).save();
}
