function player_jump_start() {
	// Early exit
	if (!button_check_pressed("btn_1") or spindash_revolutions != -1) {
		return;
	}

	// Check if there is a room between player's head and ceiling above them
	switch (collision_mode[0]) {
		case 0:
			if (tile_find_2v(pos_x - radius_x, pos_y - radius_y, pos_x + radius_x, pos_y - radius_y, false, noone, plane)[0] < 6) {
				return;
			}
			break;
		case 1:
			if (tile_find_2h(pos_x - radius_y, pos_y - radius_x, pos_x - radius_y, pos_y + radius_x, false, noone, plane)[0] < 6) {
				return;
			}
			break;
		case 2:
			// There is no check when on the actual ceiling
			break;
		case 3:
			if (tile_find_2h(pos_x + radius_y, pos_y - radius_x, pos_x + radius_y, pos_y + radius_x, true, noone, plane)[0] < 6) {
				return;
			}
			break;
	}

	// Change player's parameters
	hor_speed += jmp_height * dsin(angle);
	ver_speed += jmp_height * dcos(angle);
	is_grounded = false;
	is_jumping = true;
	is_pushing = false;
	on_object = false;
	stick_to_convex = false;
	radius_x = df_radius_x;
	radius_y = df_radius_y;
	player_set_state(states.jumping);

	// Change player's radius
	if (!is_rolling) {
		is_rolling = true;
		pos_y += df_radius_y - sm_radius_y;
		radius_x = sm_radius_x;
		radius_y = sm_radius_y;
	} else {
		radius_x = sm_radius_x;
		radius_y = sm_radius_y;
	}

    // FX
    audio_play_sfx(snd_player_jump);
    audio_play_sfx(snd_player_wind);

	// Return action result
	return is_jumping;
}
