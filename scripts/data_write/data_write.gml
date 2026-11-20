function data_write(_table, _value, _keys=[]) {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Write value
	script_execute_ext(db_write, array_concat([_table, _value], _keys));
}
