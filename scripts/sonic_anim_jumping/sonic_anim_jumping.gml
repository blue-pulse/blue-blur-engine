function sonic_anim_jumping() {
	// Set sprite
	sprite_index = spr_sonic_jumping;
	
	// Set image speed
	var current_speed = abs(ground_speed);
	image_speed = map(current_speed, 0, 8, 2, 3); 
}