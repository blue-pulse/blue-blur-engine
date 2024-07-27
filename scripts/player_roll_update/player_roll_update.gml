function player_roll_update() {
	// Early exit
	if (!forced_roll and(button_check("btn_left") or button_check("btn_right")) or spindash_revolutions != -1) {
		return;
	}

	// Check if we should roll up
	var manual_roll = (button_check("btn_down") and abs(gnd_speed) >= 0.5);

	// Roll up
	if (manual_roll or forced_roll) {
		pos_y += df_radius_y - sm_radius_y;
		radius_y = sm_radius_y;
		radius_x = sm_radius_x;
		is_rolling = true;
		state = states.rolling;
		audio_play_sfx(snd_player_roll);
	}
}
