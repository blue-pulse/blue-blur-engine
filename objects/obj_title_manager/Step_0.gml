// Blink message
if (state == 0) {
	if (message_alpha >= 1) {
		state = 1;
	} else {
		message_alpha += message_speed;
	}
} else {
	if (message_alpha <= 0.25) {
		state = 0;
	} else {
		message_alpha -= message_speed;
	}
}

// Skip frame
if (is_fading) {
	exit;
}

// Press enter to continue
if (!allow_transition and input_pressed(vb_start)) {
	allow_transition = true;
	message_speed = 0.1;
	audio_play_sfx(snd_menu_confirm);
}

// Transition to next room
if (transition_x >= transition_goal) {
	room_fadeto(rm_home, 40, c_black, true);
} else if (allow_transition) {
	transition_x += transition_speed;
}
