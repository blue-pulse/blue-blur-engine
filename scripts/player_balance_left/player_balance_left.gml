function player_balance_left(panic_condition) {
	// Play main animations
	if (dir == LEFT) {
		player_set_state(states.balance, false);
	} else if (dir == RIGHT) {
		player_set_state(states.balance_flip, false);
	}

	// Play additional animations
	if (panic_condition) {
		if (dir == RIGHT) {
			player_set_state(states.balance_turn, false);
			dir = LEFT;
		} else {
			player_set_state(states.balance_panic, false);
		}
	}
}
