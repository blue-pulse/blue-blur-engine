function data_read(_table, _keys=[]) {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Return value
	return script_execute_ext(db_read, array_concat([_table], _keys));
}
