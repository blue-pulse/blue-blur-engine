function init_stage_data() {
	// Setup level
	switch (room) {
		case rm_test_zone:
			init_test_zone();
			break;
	}
	
	// Setup music
	audio_play_bgm(bgm_sound, bgm_loop_start, bgm_loop_end);
}
