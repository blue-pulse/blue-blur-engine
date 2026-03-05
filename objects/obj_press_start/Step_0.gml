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

// Skip frame
if (is_fading) {
	exit;
}

// Press enter to continue
if (input_pressed(vb_start)) {
	blink_speed = fast_blinking;
	audio_play_sfx(snd_menu_confirm);
	room_fadeto(next_room, 60, c_black, true);
}

// Press escape to exit
else if (input_pressed(vb_back)) {
	audio_play_sfx(snd_pause_stop);
	room_fadeto(rm_stop_game, 60, c_black, true);
}
