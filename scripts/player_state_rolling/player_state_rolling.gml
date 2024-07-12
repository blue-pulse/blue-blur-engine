function player_state_rolling() {
	if (is_grounded and !is_rolling) {
		if (forced_roll or (!button_check("btn_left") and !button_check("btn_right")) and spindash_revolutions == -1) {
		    // Check if we should roll up
			if (button_check("btn_down") and abs(ground_speed) >= 0.5) {
			    var manual_roll = true;
			} else {
			    var manual_roll = false;
			}
	
			// Roll up
			if (manual_roll or forced_roll) {
				pos_y += default_radius_y - small_radius_y;
				radius_y = small_radius_y;
				radius_x = small_radius_x;
				is_rolling = true;
				state = states.rolling;
				audio_play_sfx(snd_player_rolling);
			}
		}
	}
}