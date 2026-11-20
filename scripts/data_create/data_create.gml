function data_create(_initial_data) {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Return value
	return db_create(_initial_data);
}
