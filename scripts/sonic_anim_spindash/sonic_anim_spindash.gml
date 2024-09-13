function sonic_anim_spindash() {
	// Set sprite
	sprite_index = spr_sonic_spindash;
	image_speed = 1;

	// Set image index
	if (floor(image_index) == 3) {
		image_index = 0;
	} else if (button_check_pressed("btn_1")) {
		image_index = 4;
	}
}
