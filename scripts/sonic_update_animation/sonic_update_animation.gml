function sonic_update_animation() {
	switch (state) {
		case states.idle:
			sonic_anim_idle();
			break;
		case states.moving:
			sonic_anim_moving();
			break;
		case states.falling:
			sonic_anim_falling();
			break;
		case states.jumping:
			sonic_anim_jumping();
			break;
		case states.landing:
			sonic_anim_landing();
			break;
		case states.searching:
			sonic_anim_searching();
			break;
		case states.crouching:
			sonic_anim_crouching();
			break;
		case states.rolling:
			sonic_anim_rolling();
			break;
		case states.spindash:
			sonic_anim_spindash();
			break;
		case states.skidding:
			sonic_anim_skidding();
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
		case states.stomping:
			sonic_anim_stomping();
			break;
		case states.sliding:
			sonic_anim_sliding();
			break;
	}
}
