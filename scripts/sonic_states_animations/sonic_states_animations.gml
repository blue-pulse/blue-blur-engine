function sonic_states_animations() {
	// Variables
	var current_index = floor(image_index);
	
	// Handle animations
	switch (state) {
		case states.idle:
			sprite_index = spr_sonic_idle;
			image_speed = 0.2;
			break;
		case states.crouching:
			sprite_index = spr_sonic_crouching;
			image_speed = ((current_index == 3) and button_check("btn_down")) ? (0) : (0.5);
			break;
		case states.rolling:
			sprite_index = spr_sonic_rolling;
			image_speed = clamp(abs(ground_speed), 0.65, 1.25);
			break;
		case states.spindash:
			sprite_index = spr_sonic_spindash;
			image_speed = 0.65;
			
			if ((current_index == 3) or (current_index == 7)) {
				image_index = 0;
			} else if (button_check_pressed("btn_1")) {
				image_index = 4;
			}
			break;
		default:
			sprite_index = spr_sonic_idle;
			image_index = 0;
			image_speed = 0;
			break;
	}
}