function file_is_slot_valid(_index) {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Return value
	return (_index >= 1 and _index <= MAX_SLOTS);
}
