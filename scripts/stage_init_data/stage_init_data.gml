function stage_init_data() {
	// Setup level
	switch (room) {
		// Main title
		case rm_title:
			stage_setup_title();
			break;
			
		// Test Zone
		case rm_test_zone:
			stage_setup_test_zone();
			break;
	}
	
	// Setup music
	if (audio_exists(bgm_sound)) {
		audio_play_bgm(bgm_sound, bgm_loop_start, bgm_loop_end);
	}
}
