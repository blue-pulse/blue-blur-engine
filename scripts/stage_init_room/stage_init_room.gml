function stage_init_room() {
	// Setup level
	switch (room) {
		// Main title
		case rm_title:
			stage_init_title();
			break
			
		// Main title
		case rm_home:
			stage_init_home();
			break;
		
		// Hub world
		case rm_hub_world:
			stage_init_hub_world();
			break;
		
		// Test Zone
		case rm_test_zone:
			stage_init_test_zone();
			break;
	}
	
	// Setup music
	audio_stop_all();
	if (audio_exists(bgm_sound)) {
		mixer_play_music(bgm_sound, bgm_loop_start, bgm_loop_end, bgm_position);
	}
}
