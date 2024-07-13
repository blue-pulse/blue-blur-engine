function player_balance_right(panic_condition) {
	if (facing == right) {
		state = states.balancing;
	} else if (facing == left) {
		state = states.balancing_flip;
	}
	
	if (panic_condition) {
		if (facing == left) {
			state = states.balancing_turn;
			facing = right;
		} else {
			state = states.balancing_panic;
		}
	}
}