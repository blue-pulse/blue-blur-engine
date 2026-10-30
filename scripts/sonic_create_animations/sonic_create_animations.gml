function sonic_create_animations() {
	// Variables
	var clips = {};

	// Balance
	clips.balance_back = animation_create(spr_sonic_balance_back);
	clips.balance_front = animation_create(spr_sonic_balance_front);

	// Crouch
	clips.crouch = animation_create(spr_sonic_crouch, { first_image: 3 });
	clips.crouch_start = animation_create(spr_sonic_crouch, { last_image: 2 });
	clips.crouch_stop = animation_create(spr_sonic_crouch, { last_image: 2, reversed: true });

	// Dashpanel
	clips.dashpanel = animation_create(spr_sonic_spindash, { speed: 1.25 });

	// Fall
	clips.fall_loop = animation_create(spr_sonic_fall, { first_image: 5 });
	clips.fall = animation_create(spr_sonic_fall, { last_image: 5, next: clips.fall_loop });
	clips.fall_fast_loop = animation_create(spr_sonic_fall_fast);
	clips.fall_fast = animation_create(spr_sonic_somersault, { next: clips.fall_fast_loop });
	clips.fall_slow_loop = animation_create(spr_sonic_fall_slow);
	clips.fall_slow = animation_create(spr_sonic_somersault, { next: clips.fall_slow_loop });

	// Hurt
	clips.hurt_loop = animation_create(spr_sonic_hurt, { first_image: 4, last_image: 4 });
	clips.hurt = animation_create(spr_sonic_hurt, { last_image: 3, next: clips.hurt_loop });

	// Idle
	clips.idle = animation_create(spr_sonic_idle);

	// Knock-out
	clips.knockout_loop = animation_create(spr_sonic_knockout, { first_image: 3 });
	clips.knockout = animation_create(spr_sonic_knockout, { last_image: 2, next: clips.knockout_loop });

	// Land
	clips.land = animation_create(spr_sonic_land);

	// Launch
	clips.launch = animation_create(spr_sonic_launch);

	// Push
	clips.push = animation_create(spr_sonic_push, { first_image: 3 });
	clips.push_start = animation_create(spr_sonic_push, { speed: 1.5, last_image: 2 });
	clips.push_end = animation_create(spr_sonic_push, { speed: 1.5, last_image: 2, reversed: true });

	// Recovery
	clips.recovery = animation_create(spr_sonic_recovery);

	// Rise
	clips.rise_loop = animation_create(spr_sonic_rise, { first_image: 1 });
	clips.rise = animation_create(spr_sonic_rise, { speed: 0.4, last_image: 0, next: clips.rise_loop });

	// Run
	clips.stroll = animation_create(spr_sonic_stroll);
	clips.walk = animation_create(spr_sonic_walk);
	clips.jog = animation_create(spr_sonic_jog);
	clips.run = animation_create(spr_sonic_run);
	clips.sprint = animation_create(spr_sonic_sprint);

	// Roll
	clips.roll_jump = animation_create(spr_sonic_roll_jump);
	clips.roll_fast = animation_create(spr_sonic_roll_fast);
	clips.roll_slow = animation_create(spr_sonic_roll_slow);

	// Search
	clips.lookup = animation_create(spr_sonic_lookup, { first_image: 3 });
	clips.lookup_start = animation_create(spr_sonic_lookup, { last_image: 2 });
	clips.lookup_stop = animation_create(spr_sonic_lookup, { last_image: 2, reversed: true });

	// Skid
	clips.skid_fast_loop = animation_create(spr_sonic_skid_fast, { first_image: 2, last_image: 3 });
	clips.skid_fast = animation_create(spr_sonic_skid_fast, { last_image: 1, next: clips.skid_fast_loop });
	clips.skid_slow_loop = animation_create(spr_sonic_skid_slow, { first_image: 1, last_image: 2 });
	clips.skid_slow = animation_create(spr_sonic_skid_slow, { speed: 0.65, last_image: 0, next: clips.skid_slow_loop });
	clips.skid_turn = animation_create(spr_sonic_skid_turn);

	// Somersault
	clips.somersault = animation_create(spr_sonic_somersault, { speed: 1.25 });

	// Spindash
	clips.spindash = animation_create(spr_sonic_spindash, { last_image: 3 });
	clips.spindash_charge = animation_create(spr_sonic_spindash, { first_image: 4, next: clips.spindash });

	// Turn
	clips.turn = animation_create(spr_sonic_turn);

	// Return value
	return clips;
}
