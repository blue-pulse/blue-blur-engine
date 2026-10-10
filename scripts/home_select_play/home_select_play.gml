function home_select_play() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Select slot
	var delta = input_pressed(vb_right) - input_pressed(vb_left);
	if (delta != 0) {
		mixer_play_effect(snd_menu_select, REPLACE);
		slot_active = ((delta + slot_active + MAX_SLOTS - 1) % MAX_SLOTS) + 1
	}
}
