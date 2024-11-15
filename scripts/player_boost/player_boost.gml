function player_boost() {
	// Variables
	static air_timer = 45;
	var allowed_states = [states.idle, states.moving, states.jumping, states.landing, states.falling];
	var denied_states = [states.pushing, states.sliding, states.skidding, states.rolling];

	// Handling when boost is inactive
	if (!is_boosting) {
		// When boost isn't active
		air_timer = 45;
		audio_stop_sound(snd_player_boost);
		audio_stop_sound(snd_player_boost_loop);
	} else if (is_dashing or air_timer <= 0 or stamina <= 0 or abs(gnd_speed) <= 6 or !button_check("btn_3") or array_contains(denied_states, state)) {
		// Stop boost
		is_boosting = false;
		return;
	}
	
	// Handling when boost is active
	if (stamina > 0) {
		// Start boosting
		if (!is_boosting and button_check_pressed("btn_3") and array_contains(allowed_states, state)) {
			// Flags
			is_boosting = true;

			// Parameters
			gnd_speed = max_hor_speed * dir;
			hor_speed = gnd_speed * dcos(angle);
			stamina -= (infinite_stamina) ? (0) : (1.5);

			// VFX
			screen_shake(25);
			instance_create_vfx(pos_x, pos_y, obj_boost_aura);
			instance_create_vfx(pos_x, pos_y, obj_boost_wave);

			// SFX
			audio_play_speech(ast_boost.snd_clips);
			audio_play_sfx(snd_player_boost);
			audio_play_sfx(snd_player_boost_start);
			audio_play_sfx(snd_player_boost_loop, false, true);
		}
		
		// Continue boosting
		if (is_boosting and button_check("btn_3")) {
			// Parameters
			stamina -= (infinite_stamina) ? (0) : (0.35);
			air_timer = (is_grounded) ? (45) : (air_timer - 1);
			
			// Effects
			player_draw_trail(true);
		}
	}
}
