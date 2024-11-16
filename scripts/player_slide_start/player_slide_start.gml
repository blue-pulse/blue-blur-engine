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
		player_set_state(states.slide);
		audio_play_speech(snd_attack);
	}
}
