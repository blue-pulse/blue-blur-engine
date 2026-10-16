function input_get_device() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Keyboard
	if (InputPlayerUsingKbm(PLAYER_SLOT)) {
		return input_devices.keyboard;
	}

	// Gamepad
	else if (InputPlayerUsingGamepad(PLAYER_SLOT)) {
		return input_devices.gamepad;
	}

	// Touch
	else if (InputPlayerUsingTouch(PLAYER_SLOT)) {
		return input_devices.touch;
	}

	// Other
	else {
		return input_devices.other;
	}
}
