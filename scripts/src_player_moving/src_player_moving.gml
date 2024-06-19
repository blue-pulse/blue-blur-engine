function init_player_moving_state(){
	moving = new State();
	moving.step = function() {
	    if (keyboard_check_pressed(vk_f1)) {
			show_debug_message("moving");
	    }
	}
}