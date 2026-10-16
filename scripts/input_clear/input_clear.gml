function input_clear(button) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Clear the button
	InputVerbConsume(button, PLAYER_SLOT);
}
