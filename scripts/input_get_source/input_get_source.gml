function input_get_source() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Keyboard
	if (InputPlayerUsingKbm(0)) {
		return vb_keyboard;
	}
	
	// Gamepad
	else if (InputPlayerUsingGamepad(0)) {
		return vb_gamepad;
	}

	// Touch
	else if (InputPlayerUsingTouch(0)) {
		return vb_touch;
	}
	
	// Generic
	else {
		return vb_generic;
	}
}
