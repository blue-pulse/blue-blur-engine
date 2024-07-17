function player_jump_start() {
    if (button_check_pressed("btn_1") and spindash_revolutions == -1) {
        // Check if there is a room between player's head and ceiling above them
        switch (collision_mode[0]) {
            case 0:
                if (tile_find_2v(pos_x - radius_x, pos_y - radius_y, pos_x + radius_x, pos_y - radius_y, false, noone, plane)[0] < 6) {
                    return false;
                }
                break;
            case 1:
                if (tile_find_2h(pos_x - radius_y, pos_y - radius_x, pos_x - radius_y, pos_y + radius_x, false, noone, plane)[0] < 6) {
                    return false;
                }
                break;
            case 2:
                // There is no check when on the actual ceiling!
                break;
            case 3:
                if (tile_find_2h(pos_x + radius_y, pos_y - radius_x, pos_x + radius_y, pos_y + radius_x, true, noone, plane)[0] < 6) {
                    return false;
                }
                break;
        }

        // Handle parameters
        hor_speed += jump_height * dsin(angle);
        ver_speed += jump_height * dcos(angle);
        is_pushing = false;
        is_grounded = false;
        on_object = false;
        stick_to_convex = false;
        is_jumping = true;
        state = states.jumping;
        radius_x = default_radius_x;
        radius_y = default_radius_y;

        // Reset radius
        if (!is_rolling) {
            pos_y += default_radius_y - small_radius_y;
            radius_x = small_radius_x;
            radius_y = small_radius_y;
            is_rolling = true;
        } else {
            air_lock = false;
            radius_x = small_radius_x;
            radius_y = small_radius_y;
        }

        // Play sound effects
        audio_play_sfx(snd_player_jump);
        audio_play_sfx(snd_player_wind);
    }

    // Return action result
    return is_jumping;
}
