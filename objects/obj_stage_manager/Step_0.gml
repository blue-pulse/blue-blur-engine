// Reduce power mode when unfocused
game_reduce_power();

// Kill player if they reached time limit
if (global.time > 35999) {
	with (Protagonist) {
		player_receive_damage(self, true);
	}
}

// Create debug overlay
if (debug_mode and !is_fading and input_pressed(vb_select)) {
	if (!instance_exists(obj_debug_manager)) {
		gui_create(obj_debug_manager);
	} else {
		instance_destroy(obj_debug_manager);
	}
}
