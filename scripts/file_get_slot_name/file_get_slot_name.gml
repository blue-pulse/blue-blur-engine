function file_get_slot_name(_index) {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Return value
	return $"slot_{_index}" + FILE_EXT;
}
