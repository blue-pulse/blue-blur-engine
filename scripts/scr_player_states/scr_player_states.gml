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
	
	set_state(idle);
}