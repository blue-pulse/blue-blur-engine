// Reduce power mode when unfocused
game_reduce_power();

// Kill player if they reached time limit
if (global.time > 35999) {
	with (game_get_player()) {
		player_receive_damage(self, true);
	}
}

// Toggle the dev tools
if (debug_mode and !scene_is_changing() and input_pressed(vb_select)) {
	dev_toggle();
}
