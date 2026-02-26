// Blink message
if (state == 0) {
	if (alpha >= 1) {
		state = 1;
	} else {
		alpha += blink_speed;
	}
} else {
	if (alpha <= 0.25) {
		state = 0;
	} else {
		alpha -= blink_speed;
	}
}

// Press start to continue
if (input_pressed(vb_start)) {
	// Change blink speed
	blink_speed = 0.1;
	
	// Start to fade
	if (!is_faiding) {
		audio_stop_all();
		audio_play_sfx(snd_menu_confirm);
		room_fadeto(next_room, 60);
	}
}
