function sonic_anim_sliding() {
	// Set sprite
	sprite_index = spr_sonic_sliding;
	image_speed = (image_index < 4) ? (2) : (1);
	
	// Set image index
	if (floor(image_index) == 7) {
		image_index = 4;
	}
}
