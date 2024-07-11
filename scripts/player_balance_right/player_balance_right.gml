function player_balance_right(panic_condition) {
	if (facing == right) {
		state = states.balance;
	} else if (facing == left) {
		state = states.balance_flip;
	}
	
	if (panic_condition) {
		if (facing == left) {
			state = states.balance_turn;
			facing = right;
		} else {
			state = states.balance_panic;
		}
	}
}