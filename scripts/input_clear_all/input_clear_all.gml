function input_clear_all() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Clear every button
	InputVerbConsumeAll(PLAYER_SLOT);
}
