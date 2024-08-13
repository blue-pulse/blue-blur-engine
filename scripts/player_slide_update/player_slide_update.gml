function player_slide_update() {
	// Early exit
	if (!is_rolling and spindash_revolutions != -1) {
		return;
	}

	// Slide
	if (button_check("btn_2") and abs(gnd_speed) >= 3) {
		pos_y += df_radius_y - sm_radius_y;
		radius_y = sm_radius_y;
		radius_x = sm_radius_x;
		is_rolling = true;
		is_sliding = true;
		state = states.sliding;
		audio_play_speech(ast_attack.snd_clips);
	}
}
