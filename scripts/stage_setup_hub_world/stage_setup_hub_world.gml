function stage_setup_hub_world() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Setup
	allow_culling = true;
	allow_gameplay = true;
	
	// Set level description
	name = "Hub  World";
	desc = "Go  wherever  you  want !";
	
	// Set music
	bgm_sound = bgm_hub_world;
	bgm_loop_start = 25.314;
	bgm_loop_end = 82.148;
}
