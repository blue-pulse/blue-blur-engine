function player_jump_update() {
	if (is_jumping) {
		if (!button_check("btn_1")) {
			// Shorten jump force
			if (ver_speed < min_jump_height) {
				ver_speed = min_jump_height;
			}
		}

		// Special mid-jump actions
		if (state == states.jumping) {
			if (is_dashing) {
				// VFX
				player_draw_trail();
			} else if (ver_speed >= min_jump_height and button_check_pressed("btn_1")) {
				// Speed
				is_dashing = true;
				air_lock = true;
				hor_speed = 8 * dir;
				ver_speed = 0;
				
				// SFX
				audio_play_sfx(ast_dash.snd_sfx);
			}
		}
	}
}
