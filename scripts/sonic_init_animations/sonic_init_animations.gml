function sonic_init_animations() {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Initialize variables
	animation_init();

	// Balance
	anim_balance_back = animation_create(spr_sonic_balance_back);
	anim_balance_front = animation_create(spr_sonic_balance_front);

	// Crouch
	anim_crouch = animation_create(spr_sonic_crouch, { first_image: 3 });
	anim_crouch_start = animation_create(spr_sonic_crouch, { last_image: 2 });
	anim_crouch_stop = animation_create(spr_sonic_crouch, { last_image: 2, reversed: true });

	// Dashpanel
	anim_dashpanel = animation_create(spr_sonic_spindash, { speed: 1.25 });

	// Fall
	anim_fall_loop = animation_create(spr_sonic_fall, { first_image: 5 });
	anim_fall = animation_create(spr_sonic_fall, { last_image: 5, next: anim_fall_loop });
	anim_fall_fast_loop = animation_create(spr_sonic_fall_fast);
	anim_fall_fast = animation_create(spr_sonic_somersault, { next: anim_fall_fast_loop });
	anim_fall_slow_loop = animation_create(spr_sonic_fall_slow);
	anim_fall_slow = animation_create(spr_sonic_somersault, { next: anim_fall_slow_loop });

	// Hurt
	anim_hurt_loop = animation_create(spr_sonic_hurt, { first_image: 4, last_image: 4 });
	anim_hurt = animation_create(spr_sonic_hurt, { last_image: 3, next: anim_hurt_loop });

	// Idle
	anim_idle = animation_create(spr_sonic_idle);

	// Knock-out
	anim_knockout_loop = animation_create(spr_sonic_knockout, { first_image: 3 });
	anim_knockout = animation_create(spr_sonic_knockout, { last_image: 2, next: anim_knockout_loop });

	// Land
	anim_land = animation_create(spr_sonic_land);

	// Launch
	anim_launch = animation_create(spr_sonic_launch);

	// Push
	anim_push = animation_create(spr_sonic_push, { first_image: 3 });
	anim_push_start = animation_create(spr_sonic_push, { speed: 1.5, last_image: 2 });
	anim_push_end = animation_create(spr_sonic_push, { speed: 1.5, last_image: 2, reversed: true });

	// Recovery
	anim_recovery = animation_create(spr_sonic_recovery);

	// Rise
	anim_rise_loop = animation_create(spr_sonic_rise, { first_image: 1 });
	anim_rise = animation_create(spr_sonic_rise, { last_image: 0, next: anim_rise_loop });

	// Run
	anim_stroll = animation_create(spr_sonic_stroll);
	anim_walk = animation_create(spr_sonic_walk);
	anim_jog = animation_create(spr_sonic_jog);
	anim_run = animation_create(spr_sonic_run);
	anim_sprint = animation_create(spr_sonic_sprint);

	// Roll
	anim_roll_jump = animation_create(spr_sonic_roll_jump);
	anim_roll_fast = animation_create(spr_sonic_roll_fast);
	anim_roll_slow = animation_create(spr_sonic_roll_slow);

	// Search
	anim_lookup = animation_create(spr_sonic_lookup, { first_image: 3 });
	anim_lookup_start = animation_create(spr_sonic_lookup, { last_image: 2 });
	anim_lookup_stop = animation_create(spr_sonic_lookup, { last_image: 2, reversed: true });

	// Skid
	anim_skid_fast_loop = animation_create(spr_sonic_skid_fast, { first_image: 2, last_image: 3 });
	anim_skid_fast = animation_create(spr_sonic_skid_fast, { last_image: 1, next: anim_skid_fast_loop });
	anim_skid_slow_loop = animation_create(spr_sonic_skid_slow, { first_image: 1, last_image: 2 });
	anim_skid_slow = animation_create(spr_sonic_skid_slow, { last_image: 0, next: anim_skid_slow_loop });
	anim_skid_turn = animation_create(spr_sonic_skid_turn);

	// Somersault
	anim_somersault = animation_create(spr_sonic_somersault, { speed: 1.25 });

	// Spindash
	anim_spindash = animation_create(spr_sonic_spindash, { last_image: 3 });
	anim_spindash_charge = animation_create(spr_sonic_spindash, { first_image: 4, next: anim_spindash });

	// Turn
	anim_turn = animation_create(spr_sonic_turn);
}
