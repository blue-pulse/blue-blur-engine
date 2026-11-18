function input_pressed_any(_buttons) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return InputPressedMany(_buttons, PLAYER_SLOT);
}
