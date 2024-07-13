function sonic_states_anim() {
	switch (state) {
		case states.idle:
			sonic_anim_idle();
			break;
		case states.moving:
			if abs(ground_speed) < 6 {
				sprite_index = spr_sonic_walking;
				image_speed = floor(max(1, 9 - abs(ground_speed)));
			} else {
				sprite_index = abs(ground_speed) < 10 ? spr_sonic_jogging : spr_sonic_running;
				image_speed = floor(max(1, 9 - abs(ground_speed)));
			}
			break;
		case states.jumping:
			sonic_anim_jumping();
			break;
		case states.rolling:
			sonic_anim_rolling();
			break;
		case states.searching:
			sonic_anim_searching();
			break;
		case states.crouching:
			sonic_anim_crouching();
			break;
		case states.spindash:
			sonic_anim_spindash();
			break;
		case states.pushing:
			sonic_anim_pushing();
			break;
		case states.balancing:
			sonic_anim_balancing();
			break;
		case states.balancing_turn:
			sonic_anim_balancing_turn();
			break;
		case states.balancing_flip:
			sonic_anim_balancing_flip();
			break;
		case states.balancing_panic:
			sonic_anim_balancing_panic();
			break;
		default:
			sprite_index = spr_sonic_default;
			break;
	}
}