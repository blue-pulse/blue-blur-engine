function input_clear(_button) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Clear the button
	InputVerbConsume(_button, PLAYER_SLOT);
}
