function stage_setup_home() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Setup
	allow_culling = false;
	allow_gameplay = false;
	
	// Song
	bgm_sound = bgm_home;
	bgm_loop_start = 133.964;
	bgm_loop_end = 222.701;
}
