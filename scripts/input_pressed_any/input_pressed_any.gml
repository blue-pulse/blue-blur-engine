function input_pressed_any(buttons) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return InputPressedMany(buttons, PLAYER_SLOT);
}
