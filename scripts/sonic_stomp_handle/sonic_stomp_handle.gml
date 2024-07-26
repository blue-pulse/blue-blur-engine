function sonic_stomp_handle() {
	if (is_stomping) {
		// Draw trail while stomping
		player_draw_trail();
	} else if (!is_grounded and ver_speed >= min_jump_height and button_check_pressed("btn_2")) {
		// Change speed
		hor_speed = 0;
		ver_speed = 8;
		
		// Flags
		air_lock = true;
		is_jumping = false;
		is_stomping = true;
		
		// VFX
		image_index = 0;
		state = states.stomping;
		instance_create_vfx(prev_pos_x, prev_pos_y, obj_stomp_aura);
		
		// SFX
		audio_play_speech(ast_stomp.snd_clips);
		audio_play_sfx(snd_player_stomp_start);
    }
}
