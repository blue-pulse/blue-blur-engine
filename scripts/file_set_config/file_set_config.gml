function file_set_config(param, value) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Set the given parameter
	ssave_get(cls_config).set(param, value);
}
