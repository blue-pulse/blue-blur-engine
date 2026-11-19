function stage_init_title() {
	// Setup
	allow_culling = false;
	allow_gameplay = false;
	
	// Song
	bgm_sound = bgm_title;
	bgm_loop_start = 57.109;
	bgm_loop_end = 141.742;
	bgm_position = (game_get_state() == states.active) ? (40.35) : (0);
}
