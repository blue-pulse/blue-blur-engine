function input_vibrate(_strength, _frames) {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Convert the duration to milliseconds
	var _duration = _frames * MS_PER_SECOND / MAX_FPS;

	// Vibrate the gamepad
	InputVibrateConstant(_strength, 0, _duration, PLAYER_SLOT);
}
