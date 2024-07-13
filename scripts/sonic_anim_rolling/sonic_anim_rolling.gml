function sonic_anim_rolling() {
	// Set sprite
	sprite_index = spr_sonic_rolling;
	
	// Set image speed
	var current_speed = abs(ground_speed);
	image_speed = map(current_speed, 0.5, 8, 2, 3); 
}