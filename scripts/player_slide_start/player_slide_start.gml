function player_slide_start() {
	// Early exit
	if (is_rolling or state == states.spindash) {
		return;
	}
	
	// Check if we should slide
	var manual_slide = (abs(gnd_speed) >= 2 and button_check_pressed("btn_2"));
	if (manual_slide or forced_slide) {
		pos_y += big_radius_y - small_radius_y;
		radius_y = small_radius_y;
		radius_x = small_radius_x;
		is_sliding = true;
		player_set_state(states.sliding);
		audio_play_speech(ast_attack.snd_clips);
	}
}
