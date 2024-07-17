function player_balance_left(panic_condition) {
	if (facing == left) {
		state = states.balancing;
	} else if (facing == right) {
		state = states.balancing_flip;
	}
	
	if (panic_condition) {
		if (facing == right) {
			state = states.balancing_turn;
			facing = left;
		} else {
			state = states.balancing_panic;
		}
	}
}