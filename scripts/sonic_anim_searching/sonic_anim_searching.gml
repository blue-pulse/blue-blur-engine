function sonic_anim_searching() {
	// Set sprite
	sprite_index = spr_sonic_searching;
	image_speed = !(floor(image_index) == 3);
	
	// Reset image index
	if (button_check_pressed("btn_up") or button_check_released("btn_down")) {
		image_index = 0;
	}
}