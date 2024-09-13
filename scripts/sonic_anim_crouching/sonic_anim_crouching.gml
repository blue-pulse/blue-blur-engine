function sonic_anim_crouching() {
	// Set sprite
	sprite_index = spr_sonic_crouching;
	image_speed = !(floor(image_index) == 3);
	
	// Reset image index
	if (button_check_pressed("btn_down") or button_check_released("btn_up")) {
		image_index = 0;
	}
}
