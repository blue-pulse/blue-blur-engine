function stage_setup_title() {
	// Setup
	allow_culling = false;
	audio_group_stop_all(grp_bgm);
	
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
