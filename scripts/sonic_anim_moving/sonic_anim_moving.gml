function sonic_anim_moving() {
	var current_speed = abs(gnd_speed);
	if (current_speed > 0 and current_speed < 2.4) {
		sprite_index = spr_sonic_strolling;
		image_speed = clamp(current_speed, 0.67, 1);
	} else if (current_speed >= 2.4 and current_speed < 4) {
		sprite_index = spr_sonic_walking;
		image_speed = clamp(current_speed, 0.67, 1);
	} else if (current_speed >= 4 and current_speed < 6.1) {
		sprite_index = spr_sonic_jogging;
		image_speed = map(current_speed, 4, 6.1, 1, 2);
	} else if (current_speed >= 6.1 and current_speed < 10) {
		sprite_index = spr_sonic_running;
		image_speed = map(current_speed, 6.1, 10, 1.5, 2.5);
	} else if (current_speed >= 10) {
		sprite_index = spr_sonic_sprinting;
		image_speed = map(current_speed, 10, max_abs_speed, 1.35, 2.5);
	}
}
