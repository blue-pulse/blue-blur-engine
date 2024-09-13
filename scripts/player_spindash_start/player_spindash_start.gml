function player_spindash_start() {
	// Variables
	static spindash_sound_pitch = 1;

	// Start spindash
	if (spindash_revolutions == -1) {
		if (state == states.crouching and button_check_pressed("btn_1")) {
			// Parameters
			spindash_revolutions = 0;
			hor_speed = 0;

			// VFX
			shake_effect(7);
			instance_create_vfx(pos_x, pos_y + radius_y, obj_spindash_dust);

			// SFX
			audio_sound_pitch(snd_player_spindash_charge, spindash_sound_pitch);
			audio_play_sfx(snd_player_spindash_charge);
		}
	}

	// Charge spindash
	else if (button_check("btn_down")) {
		if (button_check_pressed("btn_1")) {
			// Increase the revolutions
			spindash_revolutions = min(spindash_revolutions + 2, 16);

			// VFX
			shake_effect(7);

			// SFX
			spindash_sound_pitch += spindash_revolutions / 100;
			audio_sound_pitch(snd_player_spindash_charge, min(1.15, spindash_sound_pitch));
			audio_play_sfx(snd_player_spindash_charge);
		} else {
			// Decrease the revolutions
			spindash_revolutions -= floor(spindash_revolutions / 0.125) / 256;
		}
	}

	// Release spindash
	else {
		// Parameters
		gnd_speed = (8 + round(spindash_revolutions) / 2) * dir;
		spindash_revolutions = -1;
		is_rolling = true;
		player_set_state(states.rolling);

		// Player's radius
		radius_x = sm_radius_x;
		radius_y = sm_radius_y;
		pos_y += df_radius_y - sm_radius_y;

		// VFX
		shake_effect(15);

		// SFX
		spindash_sound_pitch = 1;
		audio_stop_sound(snd_player_spindash_charge);
		audio_play_sfx(snd_player_spindash_release);

		// Convert ground speed to real speed
		hor_speed = gnd_speed * dcos(angle);
		ver_speed = gnd_speed * -dsin(angle);
	}

	// Apply spindash animation
	if (spindash_revolutions >= 0) {
		player_set_state(states.spindash, false);
	}

	// Return flag
	return is_rolling;
}
