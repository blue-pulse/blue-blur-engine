function player_balance_right(panic_condition) {
	// Play main animations
	if (dir == RIGHT) {
		state = states.balancing;
	} else if (dir == LEFT) {
		state = states.balancing_flip;
	}

	// Play additional animations for Sonic
	if (panic_condition) {
		if (dir == LEFT) {
			state = states.balancing_turn;
			dir = RIGHT;
		} else {
			state = states.balancing_panic;
		}
	}
}
