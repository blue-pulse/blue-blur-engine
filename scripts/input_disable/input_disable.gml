function input_disable() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Block the player
	InputPlayerSetBlocked(true, PLAYER_SLOT);
}
