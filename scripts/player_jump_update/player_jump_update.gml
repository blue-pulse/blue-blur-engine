function player_jump_update() {
	if (is_jumping) {
		if (!button_check("btn_1")) {
			// Shorten jump force
			if (vertical_speed < min_jump_height) {
				vertical_speed = min_jump_height;
			}
		}
	
		// Special mid-jump actions
		if (vertical_speed >= min_jump_height and button_check_pressed("btn_1")) {
			show_debug_message("xd");
		}
	}
}