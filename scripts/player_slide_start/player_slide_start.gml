function player_slide_start() {
	// Early exit
	if (is_rolling or spindash_revolutions != -1) {
		return;
	}
	
	// Check if we should slide
	var manual_slide = (abs(gnd_speed) >= 2 and button_check_pressed("btn_2"));
	if (manual_slide or forced_slide) {
		pos_y += df_radius_y - sm_radius_y;
		radius_y = sm_radius_y;
		radius_x = sm_radius_x;
		is_sliding = true;
		player_set_state(states.sliding);
		audio_play_speech(ast_attack.snd_clips);
	}
}
