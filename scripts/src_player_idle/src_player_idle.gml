function init_player_idle_state() {
	idle = new State();
	idle.step = function() {
	    if (keyboard_check_pressed(vk_f1)) {
			show_debug_message("idle");
	    }
	}
}