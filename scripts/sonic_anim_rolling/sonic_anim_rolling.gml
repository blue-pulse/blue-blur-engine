function sonic_anim_rolling() {
	var current_speed = abs(gnd_speed);
	if (current_speed > 2) {
		sprite_index = spr_sonic_rolling;
		image_speed = map(current_speed, 2, 8, 2, 2.5); 
	} else {
		sprite_index = spr_sonic_rolling_slow;
		image_speed = clamp(current_speed, 1, 2);
	}
}
