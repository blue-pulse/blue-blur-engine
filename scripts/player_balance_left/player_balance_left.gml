function player_balance_left(panic_condition) {
	// Play main animations
	if (dir == LEFT) {
		state = states.balancing;
	} else if (dir == RIGHT) {
		state = states.balancing_flip;
	}

	// Play additional animations
	if (panic_condition) {
		if (dir == RIGHT) {
			state = states.balancing_turn;
			dir = LEFT;
		} else {
			state = states.balancing_panic;
		}
	}
}
