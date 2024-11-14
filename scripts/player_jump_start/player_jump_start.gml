function player_jump_start() {
	// Early exit
	if (!button_check_pressed("btn_1") or state == states.spindash) {
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
	hor_speed += jump_height * dsin(angle);
	ver_speed += jump_height * dcos(angle);
	is_grounded = false;
	is_jumping = true;
	is_pushing = false;
	on_object = false;
	stick_to_convex = false;

	// Update player position
	if (!is_rolling) {
		is_rolling = true;
		pos_y += big_radius_y - small_radius_y;
	}
	
	// Change player's radius
	radius_x = small_radius_x;
	radius_y = small_radius_y;
	player_set_state(states.jumping);

    // SFX
    audio_play_sfx(snd_player_jump);
    audio_play_sfx(snd_player_wind);

	// Return action result
	return is_jumping;
}
