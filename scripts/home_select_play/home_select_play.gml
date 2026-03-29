function home_select_play() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Select slot
	var delta = input_pressed(vb_right) - input_pressed(vb_left);
	if (delta != 0) {
		audio_play_sfx(snd_menu_select, REPLACE);
		slot_active = ((delta + slot_active + MAX_SLOTS - 1) % MAX_SLOTS) + 1
	}
	
	// Load save
	game_load_save(slot_active);
	audio_play_sfx(snd_menu_confirm);
	room_fadeto(next_room, 60, c_black, true);
}
