// Skip frame
if (is_fading) {
	exit;
}

// Select Slot
var input_right = input_pressed(vb_right);
var input_left = input_pressed(vb_left);
//selected_slot += input_right - input_left;
//selected_slot = ((selected_slot + MAX_SLOTS - 1) % MAX_SLOTS) + 1

// SFX
if (input_right or input_left) {
	audio_play_sfx(snd_menu_select, REPLACE);
}

// Press enter to continue
if (input_pressed(vb_start)) {
	game_load_save(selected_slot);
	audio_play_sfx(snd_menu_confirm);
	room_fadeto(next_room, 60, c_black, true);
}

// Press escape to exit
else if (input_pressed(vb_back)) {
	audio_play_sfx(snd_pause_stop);
	framework_stop();
}

// Press escape to exit
else if (input_pressed(vb_select)) {
	screen_set_fullscreen(!is_fullscreen);
}
