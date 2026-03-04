// Kill player if they reached time limit
if (global.time > 35999) {
	with (Protagonist) {
		player_receive_damage(self, true);
	}
}

// Restart room
if (reset_timer and --reset_timer == 0) {
	room_fadeto(room);
}

// Create debug overlay
if (debug_mode and !is_faiding and input_pressed(vb_select)) {
	if (!instance_exists(obj_debug_menu)) {
		gui_create(obj_debug_menu);
	} else {
		instance_destroy(obj_debug_menu);
	}
}
