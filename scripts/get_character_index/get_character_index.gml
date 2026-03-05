function get_character_index(character) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return array_get_index(global.characters, character);
}
