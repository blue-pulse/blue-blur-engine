function player_spindash_start() {
	// Variables
	static spindash_charge = 0;
	static spindash_pitch = 1;

	// Start spindash
	if (state != states.spindash) {
		if (state == states.crouch and button_check_pressed("btn_1")) {
			// Parameters
			hor_speed = 0;
			spindash_charge = 0;
			spindash_pitch = 1;
			player_set_state(states.spindash, false);

			// Effects
			instance_create_vfx(pos_x, pos_y + radius_y, obj_spindash_dust);
			audio_play_sfx(snd_player_spindash_charge);
			screen_shake(7);
		}
	}

	// Charge spindash
	else if (button_check("btn_down")) {
		if (button_check_pressed("btn_1")) {
			// Increase the revolutions
			spindash_charge = min(spindash_charge + 2, max_abs_speed);
			spindash_pitch = min(spindash_charge + 0.1, 1.15);

			// Effects
			var snd_charge = audio_play_sfx(snd_player_spindash_charge);
			audio_sound_pitch(snd_charge, spindash_pitch);
			screen_shake(7);
		} else {
			// Decrease the revolutions
			spindash_charge -= floor(spindash_charge / 0.125) / 256;
		}
	}

	// Release spindash
	else {
		// Parameters
		is_rolling = true;
		gnd_speed = (8 + round(spindash_charge) / 2) * dir;
		radius_x = small_radius_x;
		radius_y = small_radius_y;
		pos_y += big_radius_y - small_radius_y;
		player_set_state(states.roll);

		// Convert ground speed to real speed
		hor_speed = gnd_speed * dcos(angle);
		ver_speed = gnd_speed * -dsin(angle);
		
		// Effects
		audio_stop_sound(snd_player_spindash_charge);
		audio_play_sfx(snd_player_spindash_release);
		screen_shake(15);
	}

	// Return flag
	return is_rolling;
}
