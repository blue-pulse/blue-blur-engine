function framework_end() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Stop audio
	print("[INFO] Stoping audio...");
	audio_stop_all();
	
	// Save before closing
	print("[INFO] Saving data...");
	file_save_userdata();
	file_save_config();
	
	// Wait before ending process
	alarm_set(0, 45);
}
