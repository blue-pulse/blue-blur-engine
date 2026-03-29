function stage_setup_title() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Setup
	allow_culling = false;
	allow_gameplay = false;
	
	// Song
	bgm_sound = bgm_title;
	bgm_loop_start = 57.109;
	bgm_loop_end = 141.742;
	bgm_position = (sys_active) ? (40.35) : (0);
}
