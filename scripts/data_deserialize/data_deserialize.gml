function data_deserialize(_buffer) {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Return value
	return db_buffer_read(_buffer);
}
