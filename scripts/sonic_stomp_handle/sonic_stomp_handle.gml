function sonic_stomp_handle() {
	static afterimage_counter = 0;
	
    if (!is_grounded and !is_stomping and air_timer >= 10 and button_check_pressed("btn_2")) {
		gnd_speed = 0;
		hor_speed = 0;
		ver_speed = 8;
		is_jumping = false;
		air_lock = true;
		is_stomping = true;
		state = states.stomping;
		audio_play_sfx(snd_player_stomp_start);
		return noone;
    }
	
	if (is_stomping) {
		if (is_grounded) {
			is_stomping = false;
			audio_stop_sound(snd_player_stomp_start);
			audio_play_sfx(snd_player_stomp_end);
			player_reset_on_floor();
		} else {
			afterimage_counter++;
			if (afterimage_counter >= 5) {
				afterimage_counter = 0;
				instance_create_vfx(xprevious, yprevious, obj_afterimage, true);
			}
		}
	}
}
