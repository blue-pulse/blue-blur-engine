function stage_setup_title() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Setup
	allow_culling = false;
	allow_gameplay = false;
	
	// Play random song
	if (random_range(0, 1)) {
		bgm_sound = bgm_title_a;
		bgm_loop_start = 58.628;
		bgm_loop_end = 143.266;
	} else {
		bgm_sound = bgm_title_b;
		bgm_loop_start = 133.964;
		bgm_loop_end = 222.701;
	}
}
