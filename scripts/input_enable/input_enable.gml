function input_enable() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Unblock the player
	InputPlayerSetBlocked(false, PLAYER_SLOT);
}
