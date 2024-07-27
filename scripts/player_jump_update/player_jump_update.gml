function player_jump_update() {
	// Early exit
	if (!is_jumping) {
		return;
	}

	// Shorten jump force
	if (ver_speed < min_jump_height and !button_check("btn_1")) {
		ver_speed = min_jump_height;
	}

	// Homing dash
	if (state == states.jumping) {
		if (is_dashing) {
			player_draw_trail();
		} else if (ver_speed >= min_jump_height and button_check_pressed("btn_1")) {
			air_lock = true;
			is_dashing = true;
			hor_speed = 8 * dir;
			ver_speed = 0;
			audio_play_sfx(ast_dash.snd_sfx);
		}
	}
}
