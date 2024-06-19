function init_player_crouching_state(){
	crouching = new State();
	crouching.step = function() {
	    if (keyboard_check_pressed(vk_f1)) {
			show_debug_message("crouching");
	    }
	}
}