function angle_wrap(value) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return ((value mod 360) + 360) mod 360;
}
