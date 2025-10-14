function input_shake(strength, duration) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return InputVibrateConstant(strength, 0, duration, 0);
}
