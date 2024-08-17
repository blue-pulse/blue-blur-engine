function player_slide_update() {
	// Early exit
	if (is_rolling or abs(gnd_speed) < 3 or !button_check_pressed("btn_2")) {
		return;
	}
	
	// Parameters
	pos_y += df_radius_y - sm_radius_y;
	radius_y = sm_radius_y;
	radius_x = sm_radius_x;
	is_sliding = true;
	player_set_state(states.sliding);
	
	// SFX
	audio_play_speech(ast_attack.snd_clips);
	audio_play_sfx(snd_player_slide);
}
