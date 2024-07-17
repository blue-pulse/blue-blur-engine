function sonic_anim_jumping() {
	if (ver_speed < 3) {
		// Rolling in the air
		var current_speed = abs(ground_speed);
		sprite_index = spr_sonic_rolling_fast;
		image_speed = map(current_speed, 0, 8, 2, 3); 
	} else {
		// Trying to land
		image_index = 0;
		state = states.landing;
	}
}