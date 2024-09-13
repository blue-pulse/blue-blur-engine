function player_balance_right(panic_condition) {
	// Play main animations
	if (dir == RIGHT) {
		player_set_state(states.balancing, false);
	} else if (dir == LEFT) {
		player_set_state(states.balancing_flip, false);
	}

	// Play additional animations for Sonic
	if (panic_condition) {
		if (dir == LEFT) {
			player_set_state(states.balancing_turn, false);
			dir = RIGHT;
		} else {
			player_set_state(states.balancing_panic, false);
		}
	}
}
