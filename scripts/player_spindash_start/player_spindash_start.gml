function player_spindash_start() {
	// Variables
	static spindash_sound_pitch = 1;
	
    // Start spindash
    if (spindash_revolutions == -1) {
        if ((state == states.crouching) and button_check_pressed("btn_1")) {
			// Handle parameters
            spindash_revolutions = 0;
            hor_speed = 0;
			
			// Play sound effect
            audio_sound_pitch(snd_player_spindash_charge, spindash_sound_pitch);
            audio_play_sfx(snd_player_spindash_charge);
        }
    } else if (button_check("btn_down")) {
        // Charge spindash
        if (button_check_pressed("btn_1")) {
			// Increase the revolutions
            spindash_revolutions = min(spindash_revolutions + 2, 8);
			
			// Play sound effect
            spindash_sound_pitch += spindash_revolutions / 100;
            audio_sound_pitch(snd_player_spindash_charge, min(1.15, spindash_sound_pitch));
            audio_play_sfx(snd_player_spindash_charge);
        } else {
            spindash_revolutions -= floor(spindash_revolutions / 0.125) / 256;
        }
    } else {
        // Release spindash
        ground_speed = (8 + round(spindash_revolutions) / 2) * facing;
        is_rolling = true;
        spindash_revolutions = -1;
        state = states.rolling;

        // Handle hitbox
        radius_x = small_radius_x;
        radius_y = small_radius_y;
        pos_y += default_radius_y - small_radius_y;

        // Convert ground_speed to speed
        hor_speed = ground_speed * dcos(angle);
        ver_speed = ground_speed * -dsin(angle);

        // Handle sound effects
        spindash_sound_pitch = 1;
        audio_stop_sound(snd_player_spindash_charge);
        audio_play_sfx(snd_player_spindash_release);
    }

    // Set state
    if (spindash_revolutions >= 0) {
        state = states.spindash;
    }

    // Return action result
    return is_rolling;
}