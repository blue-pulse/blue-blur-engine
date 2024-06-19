function init_player_pushing_state(){
	pushing = new State();
	pushing.step = function() {
	    if (keyboard_check_pressed(vk_f1)) {
			show_debug_message("pushing");
	    }
	}
}