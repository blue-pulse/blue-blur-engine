function player_roll_start() {
	// Early exit
	if (state == states.spindash or (!forced_roll and (button_check("btn_left") or button_check("btn_right")))) {
		return;
	}

	// Check if we should roll up
	var manual_roll = (abs(gnd_speed) >= 0.5 and button_check("btn_down"));
	if (manual_roll or forced_roll) {
		pos_y += big_radius_y - small_radius_y;
		radius_y = small_radius_y;
		radius_x = small_radius_x;
		is_rolling = true;
		player_set_state(states.rolling);
		audio_play_sfx(snd_player_roll);
	}
}
