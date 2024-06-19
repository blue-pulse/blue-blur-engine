function init_player_skidding_state(){
	skidding = new State();
	skidding.step = function() {
	    if (keyboard_check_pressed(vk_f1)) {
			show_debug_message("skidding");
	    }
	}
}