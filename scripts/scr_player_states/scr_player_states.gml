function set_player_states(){
	idle = new State();
	idle.step = function() {
	    if (keyboard_check_pressed(vk_f1)) {
			show_debug_message("Idle");
	    }
	}

	moving = new State();
	moving.step = function() {
	    if (keyboard_check_pressed(vk_f2)) {
			show_debug_message("Moving");
	    }
	}
	
	skidding = new State();
	pushing = new State();
	looking_up = new State();
	crouching = new State();
	
	set_state(idle);
}