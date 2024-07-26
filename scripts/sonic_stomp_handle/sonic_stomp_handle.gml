function sonic_stomp_handle() {
	// Variables
	static afterimage_counter = 0;
	
	// Start stomp
    if (!is_grounded and !is_stomping and air_timer >= 10 and button_check_pressed("btn_2")) {
		// Change speed
		gnd_speed = 0;
		hor_speed = 0;
		ver_speed = 8;
		
		// Flags
		air_lock = true;
		is_jumping = false;
		is_stomping = true;
		state = states.stomping;
		
		// VFX
		instance_create_vfx(x, y + 8, obj_stomp_aura);
		
		// SFX
		var voice_clip = array_rand(ast_stomp.snd_clips);
		audio_play_speech(voice_clip);
		audio_play_sfx(snd_player_stomp_start);
		return noone;
    }
	
	// Stop stomp when grounded
	if (is_stomping) {
		if (is_grounded) {
			// Reset flags
			is_stomping = false;
			player_reset_on_floor();
			
			// SFX
			audio_stop_sound(snd_player_stomp_start);
			audio_play_sfx(snd_player_stomp_end);
		} else {
			// VFX
			afterimage_counter++;
			if (afterimage_counter >= 5) {
				afterimage_counter = 0;
				instance_create_vfx(xprevious, yprevious, obj_afterimage, true);
			}
		}
	}
}
