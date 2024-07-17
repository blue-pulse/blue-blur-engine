function sonic_anim_landing() {
	// Set sprite
	sprite_index = spr_sonic_landing;
	image_speed = 1;
	
	// Set image index
	if (floor(image_index) == 6) {
		image_index = 3;
	}
}