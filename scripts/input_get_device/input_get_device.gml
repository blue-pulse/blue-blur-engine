function input_get_device() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Keyboard
	if (InputPlayerUsingKbm(0)) {
		return input_devices.keyboard;
	}

	// Gamepad
	else if (InputPlayerUsingGamepad(0)) {
		return input_devices.gamepad;
	}

	// Touch
	else if (InputPlayerUsingTouch(0)) {
		return input_devices.touch;
	}

	// Other
	else {
		return input_devices.other;
	}
}
