function player_roll_start() {
	// Early exit
	if (spindash_revolutions != -1 or (!forced_roll and (button_check("btn_left") or button_check("btn_right")))) {
		return;
	}

	// Check if we should roll up
	var manual_roll = (abs(gnd_speed) >= 0.5 and button_check("btn_down"));
	if (manual_roll or forced_roll) {
		pos_y += df_radius_y - sm_radius_y;
		radius_y = sm_radius_y;
		radius_x = sm_radius_x;
		is_rolling = true;
		player_set_state(states.rolling);
		audio_play_sfx(snd_player_roll);
	}
}
