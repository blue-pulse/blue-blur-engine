function resolve_character(index) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return array_get(global.characters, index);
}
