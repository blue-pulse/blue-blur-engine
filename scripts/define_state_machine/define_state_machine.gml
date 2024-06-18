function State() constructor {
    static generic_function = function() {};
    create = generic_function;
    step = generic_function;
	draw = generic_function;
    destroy = generic_function;
}

function State_Machine() constructor {
	// Set default state
    static idle = new State();
	
	// Set variables
    state = idle;
    time = 0;

    // Set a new state
    set = function(new_state = idle) {
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