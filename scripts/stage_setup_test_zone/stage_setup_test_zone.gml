function stage_setup_test_zone() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Setup
	allow_culling = true;
	allow_gameplay = true;
	
	// Set level description
	name = "Test  Zone";
	desc = "Practice  your  skills !";
	
	// Set music
	bgm_sound = bgm_test_zone;
	bgm_loop_start = 18.608;
	bgm_loop_end = 90.826;
	bgm_position = 0;
}
