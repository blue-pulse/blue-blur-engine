function player_set_state_machine() {
	// Object
	state_machine = new State_Machine();
	
	// Methods
	set_state = function(state) {
		state_machine.set(state);
	}

	get_state = function() {
		return state_machine.state;
	}

	run_state = function() {
		state_machine.run();
	}
}