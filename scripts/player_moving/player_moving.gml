function player_moving(){
	moving = new State();
	moving.step = function() {
	    if (keyboard_check_pressed(vk_f1)) {
			show_debug_message("moving");
	    }
	}
}