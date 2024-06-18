function State() constructor {
    static generic_function = function() {};
    create = generic_function;
    step = generic_function;
	draw = generic_function;
    destroy = generic_function;
}

function State_Machine() constructor {
	// Set default state
    static null_state = new State();
	
	// Set variables
    state = null_state;
    time = 0;

    // Set a new state
    set = function(new_state = null_state) {
		// Destroy current state
        state.destroy();
		
		// Start new state
        state = new_state;
        state.create();
        time = 0;
    }

    // Run current state
    run = function() {
        state.step();
        time++;
    }
}