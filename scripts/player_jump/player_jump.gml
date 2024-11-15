function player_jump() {
	// Early exit
	if (!is_jumping) {
		return;
	}

	// Shorten jump force
	if (ver_speed < min_jump_height and !button_check("btn_1")) {
		ver_speed = min_jump_height;
	}
	
	// VFX
	instance_create_vfx(pos_x, pos_y, obj_jumpball);
	
	// Homing dash
	if (is_dashing) {
		if (state == states.jumping) {
			player_draw_trail();
		}
	} else if (ver_speed >= min_jump_height and button_check_pressed("btn_1")) {
		air_lock = true;
		is_dashing = true;
		hor_speed = 8 * dir;
		ver_speed = 0;
		player_set_state(states.jumping);
		audio_play_sfx(ast_dash.snd_sfx);
	}
}
