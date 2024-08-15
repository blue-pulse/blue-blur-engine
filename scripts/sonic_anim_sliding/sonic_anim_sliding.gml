function sonic_anim_sliding() {
	// Set sprite
	sprite_index = spr_sonic_sliding;
	image_speed = 1;
	
	// Set image index
	if (floor(image_index) == 6) {
		image_index = 4;
		image_speed = 0.5;
	}
}
