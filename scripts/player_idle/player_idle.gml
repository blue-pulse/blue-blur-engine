function player_idle() {
	idle = new State();
	idle.step = function() {
	    if (keyboard_check_pressed(vk_f1)) {
			show_debug_message("idle");
	    }
	}
}