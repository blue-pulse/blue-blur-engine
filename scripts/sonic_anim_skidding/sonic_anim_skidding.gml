function sonic_anim_skidding() {
	if (is_grounded and (angle <= 45 or angle >= 316.41)) {
		switch (sprite_index) {
			case spr_sonic_skidding:
				if (floor(image_index) == 3) {
					image_index = 1;
				}
				break;
			case spr_sonic_skidding_fast:
				if (floor(image_index) == 6) {
					image_index = 3;
				}
				break;
			default:
				var current_speed = abs(gnd_speed);
				image_index = 0;
				sprite_index = (current_speed > 8) ? (spr_sonic_skidding_fast) : (spr_sonic_skidding);
				break;
		}
	} else {
		image_index = 0;
		state = states.falling;
	}
}
