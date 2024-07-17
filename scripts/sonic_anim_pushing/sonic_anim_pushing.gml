function sonic_anim_pushing() {
	// Set sprite
	sprite_index = spr_sonic_pushing;
	image_speed = 1;
	
	// Set image index
	if (floor(image_index) == 9) {
		image_index = 3;
	}
}
