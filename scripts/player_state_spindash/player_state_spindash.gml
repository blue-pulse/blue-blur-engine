function player_state_spindash(phase) {
	switch (phase) {
		// Start state
		case INIT:
			// Set variables
			is_rolling = true;
			spindash_charge = 0;
			spindash_pitch = 1;
			hor_speed = 0;
			ver_speed = 0;
			
			// FX
			screen_shake(7);
			animation_play(anim_spindash);
			audio_play_sfx(snd_player_spindash_charge, REPLACE);
			break;

		// Run state
		case STEP:
			// Update position
			if (!player_movement_ground()) {
				break;
			}
			
			// Falling
			if (!is_grounded) {
				player_set_state(player_state_roll);
				break;
			}
						
			// Fall from steep surfaces
	        if (relative_angle >= 90 and relative_angle <= 270) {
	            player_set_state(player_state_airbone);
				break;
	        }
			
			// Slide down from steep surfaces
			else if (relative_angle >= 45 and relative_angle <= 315) {
				ground_lock = stumble_timer;
				player_set_state(player_state_roll);;
				break;
			}
			
			// Decrease revolutions
			if (spindash_charge > 0) {
				var atrophy = floor(spindash_charge / 0.125);
				spindash_charge -= atrophy / 256;
			}
			
			// Charging
			if (input_pressed(vb_a)) {
				// Increase revolutions
				spindash_charge = min(spindash_charge + 2, 8);
				
				// SFX
				if (spindash_charge and audio_is_playing(snd_player_spindash_charge)) {
					spindash_pitch = min(spindash_charge + 0.1, 1.15);
				} else {
					spindash_pitch = 1;
				}
				var sound = audio_play_sfx(snd_player_spindash_charge, REPLACE);
				audio_sound_pitch(sound, spindash_pitch);
				
				// VFX
				animation_play(anim_spindash_charge);
				screen_shake(7);
			}
			
	        // Release
			if (!input_holded(vb_down)) {
				// Launch
				var dash_speed = 10 + round(spindash_charge) / 2;
				hor_speed = dash_speed * dir;
				player_set_state(player_state_roll)
				
				// FX
				audio_stop_sound(snd_player_spindash_charge);
				audio_play_sfx(snd_player_spindash_release, REPLACE);
				screen_shake(15);
			}
			break;
			
		// Stop state
		case STOP:
			break;
	}
}