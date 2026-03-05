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
if (input_pressed(vb_start) and !is_fading) {
	blink_speed = fast_blinking;
	audio_play_sfx(snd_menu_confirm);
	room_fadeto(next_room, 60, c_black, true);
}

// Press select to exit
if (input_pressed(vb_select) and !is_fading) {
	blink_speed = fast_blinking;
	audio_play_sfx(snd_menu_confirm);
	room_fadeto(rm_stop_game, 60, c_black, true);
}
