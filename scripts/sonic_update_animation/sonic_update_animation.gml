function sonic_update_animation() {
	switch (state) {
		case states.idle:
			sonic_anim_idle();
			break;
		case states.move:
			sonic_anim_moving();
			break;
		case states.fall:
			sonic_anim_falling();
			break;
		case states.jump:
			sonic_anim_jumping();
			break;
		case states.land:
			sonic_anim_landing();
			break;
		case states.search:
			sonic_anim_searching();
			break;
		case states.crouch:
			sonic_anim_crouching();
			break;
		case states.roll:
			sonic_anim_rolling();
			break;
		case states.spindash:
			sonic_anim_spindash();
			break;
		case states.skid:
			sonic_anim_skidding();
			break;
		case states.push:
			sonic_anim_pushing();
			break;
		case states.balance:
			sonic_anim_balancing();
			break;
		case states.balance_turn:
			sonic_anim_balancing_turn();
			break;
		case states.balance_flip:
			sonic_anim_balancing_flip();
			break;
		case states.balance_panic:
			sonic_anim_balancing_panic();
			break;
		case states.stomp:
			sonic_anim_stomping();
			break;
		case states.slide:
			sonic_anim_sliding();
			break;
	}
}
