// State machine
script_execute(state, 0);
if (state == player_is_dead) {
	exit;
}

// Save position
player_save_position();
