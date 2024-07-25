function player_boost_handle() {
	// Variables
	static air_timer = 45;
	static afterimage_counter = 0;
	var allowed_states = [states.idle, states.moving, states.jumping];
	var denied_states = [states.skidding, states.rolling];

	// Stop boost
	if (is_boosting and (air_timer <= 0 or stamina <= 0 or abs(gnd_speed) <= 6 or !button_check("btn_3") or array_contains(denied_states, state))) {
		// Parameters
		is_boosting = false;
		air_timer = 45;

		// SFX
		audio_stop_sound(snd_player_boost);
		audio_stop_sound(snd_player_boost_loop);
		return;
	}
	
	// Handle boost
	if (!is_pushing and stamina > 0) {
		// Start boosting
		if (!is_boosting and button_check_pressed("btn_3") and array_contains(allowed_states, state)) {
			// Flags
			is_boosting = true;

			// Parameters
			gnd_speed = max_hor_speed * dir;
			hor_speed = gnd_speed * dcos(angle);
			stamina -= 1.5;

			// VFX
			instance_create_vfx(pos_x, pos_y, obj_boost_aura);
			instance_create_vfx(pos_x, pos_y, obj_boost_wave);
			
			// Voice clip
			var voice_clip = array_rand(ast_boost.snd_clips);
			audio_play_speech(voice_clip);
			
			// SFX
			audio_play_sfx(snd_player_boost);
			audio_play_sfx(snd_player_boost_start);
			audio_play_sfx(snd_player_boost_loop, false, true);
		}
		
		// Continue boosting
		if (is_boosting and button_check("btn_3")) {
			// Handle parameters when grounded
			if (is_grounded) {
				// Show spark effect
				if (afterimage_counter == 6 and gnd_speed != 0) {
					instance_create_vfx(xprevious, yprevious, obj_boost_spark, true);
				}
				
				// Reset air timer
				air_timer = 45;
			} else {
				// Decrease air timer
				air_timer--;
			}
			
			// Show afterimages
			if (afterimage_counter >= 7) {
				afterimage_counter = 0;
				instance_create_vfx(xprevious, yprevious, obj_afterimage, true);
			}
			
			// Finally
			stamina -= 0.35;
			afterimage_counter++;
		}
	}
}
