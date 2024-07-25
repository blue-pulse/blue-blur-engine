function input_get_device() {
	return input_source_using(INPUT_GAMEPAD) ? (INPUT_GAMEPAD) : (INPUT_KEYBOARD);
}
