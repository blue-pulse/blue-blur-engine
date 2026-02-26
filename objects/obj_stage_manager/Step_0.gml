// Restart room
if (reset_timer and --reset_timer == 0) {
	room_fadeto(room);
}

// Create debug overlay
if (debug_mode and input_pressed(vb_select) and !fade_exists()) {
	if (!instance_exists(obj_debug_menu)) {
		instance_create_depth(0, 0, depths.gui, obj_debug_menu);
	} else {
		instance_destroy(obj_debug_menu);
	}
}
