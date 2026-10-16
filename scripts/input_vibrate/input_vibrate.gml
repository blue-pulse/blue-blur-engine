function input_vibrate(strength, frames) {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Convert the duration to milliseconds
	var duration = frames * MS_PER_SECOND / MAX_FPS;

	// Return value
	return InputVibrateConstant(strength, 0, duration, 0);
}
