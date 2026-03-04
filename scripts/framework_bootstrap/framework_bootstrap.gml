function framework_bootstrap() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Use a new seed
	randomize();
	
	// Allow input
	input_enable_device();
	input_clear_all();
	
	// Reset values
	ticks = 0;
	is_paused = false;
}
