function sonic_anim_falling() {
	// Set sprite
	sprite_index = spr_sonic_falling;
	image_speed = 1;
	
	// Set image index
	if (floor(image_index) == 5) {
		image_index = 2;
	}
}