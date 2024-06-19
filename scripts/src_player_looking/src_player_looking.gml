function init_player_looking_state(){
	looking = new State();
	looking.step = function() {
	    if (keyboard_check_pressed(vk_f1)) {
			show_debug_message("looking");
	    }
	}
}