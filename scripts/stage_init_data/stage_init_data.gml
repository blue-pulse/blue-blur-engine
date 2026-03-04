function stage_init_data() {
	// Setup level
	switch (room) {
		// Main title
		case rm_title:
			stage_setup_title();
			break;
		
		// Hub world
		case rm_hub_world:
			stage_setup_hub_world();
			break;
		
		// Test Zone
		case rm_test_zone:
			stage_setup_test_zone();
			break;
	}
	
	// Setup music
	audio_stop_all();
	if (audio_exists(bgm_sound)) {
		audio_play_bgm(bgm_sound, bgm_loop_start, bgm_loop_end);
	}
}
