function dev_command_toggle_noclip(_player) {
	// Switch between flying and falling
	with (_player) {
		if (state != player_state_noclip) {
			player_set_state(player_state_noclip);
		} else {
			player_set_state(player_state_airbone);
		}
	}
}
