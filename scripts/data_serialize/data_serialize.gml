function data_serialize(_table) {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Return value
	return db_buffer_create(_table);
}
