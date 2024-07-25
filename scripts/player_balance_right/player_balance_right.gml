function player_balance_right(panic_condition) {
	if (dir == RIGHT) {
		state = states.balancing;
	} else if (dir == LEFT) {
		state = states.balancing_flip;
	}

	if (panic_condition) {
		if (dir == LEFT) {
			state = states.balancing_turn;
			dir = RIGHT;
		} else {
			state = states.balancing_panic;
		}
	}
}
