function mixer_is_loaded() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return boolean
	return easyaudio_is_loaded();
}
