function framework_end() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Stop audio
	print("[INFO] Stoping audio...");
	audio_stop_all();
	
	// Wait before ending process
	alarm_set(0, 45);
}
