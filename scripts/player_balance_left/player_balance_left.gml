function player_balance_left(panic_condition) {
	if (facing == left) {
		state = states.balance;
	} else if (facing == right) {
		state = states.balance_flip;
	}
	
	if (panic_condition) {
		if (facing == right) {
			state = states.balance_turn;
			facing = left;
		} else {
			state = states.balance_panic;
		}
	}
}