function player_skidding(){
	skidding = new State();
	skidding.step = function() {
	    if (keyboard_check_pressed(vk_f1)) {
			show_debug_message("skidding");
	    }
	}
}