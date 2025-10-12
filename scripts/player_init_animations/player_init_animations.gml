function player_init_animations() {
	// Initialize variables
	snip_create_event();
	
	// Airtricks
	anim_airtrick_a = new Snip(sprite_index, 1);
	anim_airtrick_b = new Snip(sprite_index, 1);
	anim_airtrick_c = new Snip(sprite_index, 1);
	anim_airtrick_d = new Snip(sprite_index, 1);
	anim_airtrick_e = new Snip(sprite_index, 1);
	anim_airtrick_f = new Snip(sprite_index, 1);
	anim_airtrick_g = new Snip(sprite_index, 1);
	
	// Balance
	anim_balance = new Snip(sprite_index, 1);
	anim_balance_flip = new Snip(sprite_index, 1);
	anim_balance_panic = new Snip(sprite_index, 1);
	anim_balance_turn = new Snip(sprite_index, 1);
	
	// Crouch
	anim_crouch = new Snip(sprite_index, 1);
	anim_crouch_start = new Snip(sprite_index, 1);
	anim_crouch_stop = new Snip(sprite_index, 1);
	snip_set_backward(anim_crouch_stop);
	
	// Fall
	anim_fall_a = new Snip(sprite_index, 1);
	anim_fall_a_start = new Snip(sprite_index, 1);
	anim_fall_b = new Snip(sprite_index, 1);
	anim_fall_c = new Snip(sprite_index, 1);
	
	// Hurt
	anim_hurt = new Snip(sprite_index, 1);
	anim_hurt_start = new Snip(sprite_index, 1);
	
	// Idle
	anim_idle = new Snip(sprite_index, 1);
	
	// Knock-out
	anim_knockout = new Snip(sprite_index, 1);
	anim_knockout_start = new Snip(sprite_index, 1);
	
	// Land
	anim_land = new Snip(sprite_index, 1);
	
	// Launch
	anim_launch = new Snip(sprite_index, 1);
	
	// Move
	anim_stroll = new Snip(sprite_index, 1);
	anim_walk = new Snip(sprite_index, 1);
	anim_jog = new Snip(sprite_index, 1);
	anim_run = new Snip(sprite_index, 1);
	anim_sprint = new Snip(sprite_index, 1);
	
	// Push
	anim_push = new Snip(sprite_index, 1);
	anim_push_start = new Snip(sprite_index, 1);
	
	// Roll
	anim_roll = new Snip(sprite_index, 1);
	anim_roll_fast = new Snip(sprite_index, 1);
	anim_roll_slow = new Snip(sprite_index, 1);
	
	// Search
	anim_search = new Snip(sprite_index, 1);
	anim_search_start = new Snip(sprite_index, 1);
	anim_search_stop = new Snip(sprite_index, 1);
	snip_set_backward(anim_search_stop);
	
	// Skid
	anim_skid_slow = new Snip(sprite_index, 1);
	anim_skid_slow_start = new Snip(sprite_index, 1);
	anim_skid_fast = new Snip(sprite_index, 1);
	anim_skid_fast_start = new Snip(sprite_index, 1);
	
	// Slide
	anim_slide = new Snip(sprite_index, 1);
	
	// Spindash
	anim_spindash = new Snip(sprite_index, 1);
	anim_spindash_charge = new Snip(sprite_index, 1);
	
	// Stand up
	anim_stand_a = new Snip(sprite_index, 1);
	anim_stand_b = new Snip(sprite_index, 1);
	
	// Stomp
	anim_stomp = new Snip(sprite_index, 1);
	anim_stomp_land = new Snip(sprite_index, 1);
	
	// Transition snips
	anim_duck = new Snip(sprite_index, 1);
	anim_somersault = new Snip(sprite_index, 1);
	
	// Create successors
	snip_set_successor(anim_airtrick_a, anim_fall_c, true);
	snip_set_successor(anim_airtrick_b, anim_fall_c, true);
	snip_set_successor(anim_airtrick_c, anim_fall_c, true);
	snip_set_successor(anim_airtrick_d, anim_fall_c, true);
	snip_set_successor(anim_airtrick_e, anim_fall_c, true);
	snip_set_successor(anim_airtrick_f, anim_fall_c, true);
	snip_set_successor(anim_airtrick_g, anim_fall_c, true);
	snip_set_successor(anim_hurt_start, anim_hurt, true);
	snip_set_successor(anim_spindash_charge, anim_spindash, true);
	
	// Create transitions
	new Transition(anim_airtrick_a, anim_fall_c, anim_somersault);
	new Transition(anim_airtrick_b, anim_fall_c, anim_somersault);
	new Transition(anim_airtrick_c, anim_fall_c, anim_somersault);
	new Transition(anim_airtrick_d, anim_fall_c, anim_somersault);
	new Transition(anim_airtrick_e, anim_fall_c, anim_somersault);
	new Transition(anim_airtrick_f, anim_fall_c, anim_somersault);
	new Transition(anim_airtrick_g, anim_fall_c, anim_somersault);
	new Transition(anim_crouch, anim_idle, anim_crouch_stop);
	new Transition(anim_crouch, anim_push, anim_push_start);
	new Transition(anim_fall_a, anim_crouch, anim_crouch_start);
	new Transition(anim_fall_a, anim_crouch, anim_crouch_start);
	new Transition(anim_fall_a, anim_idle, anim_land);
	new Transition(anim_fall_a, anim_search, anim_search_start);
	new Transition(anim_fall_a, anim_search, anim_search_start);
	new Transition(anim_fall_b, anim_crouch, anim_crouch_start);
	new Transition(anim_fall_b, anim_crouch, anim_crouch_start);
	new Transition(anim_fall_b, anim_idle, anim_land);
	new Transition(anim_fall_b, anim_search, anim_search_start);
	new Transition(anim_fall_b, anim_search, anim_search_start);
	new Transition(anim_fall_c, anim_crouch, anim_crouch_start);
	new Transition(anim_fall_c, anim_idle, anim_land);
	new Transition(anim_fall_c, anim_search, anim_search_start);
	new Transition(anim_hurt, anim_knockout, anim_knockout_start);
	new Transition(anim_idle, anim_crouch, anim_crouch_start);
	new Transition(anim_idle, anim_fall_a, anim_somersault);
	new Transition(anim_idle, anim_search, anim_search_start);
	new Transition(anim_jog, anim_fall_a, anim_somersault);
	new Transition(anim_jog, anim_skid_slow, anim_skid_slow_start);
	new Transition(anim_jog, anim_slide, anim_duck);
	new Transition(anim_knockout, anim_balance, anim_stand_b);
	new Transition(anim_knockout, anim_balance_flip, anim_stand_b);
	new Transition(anim_knockout, anim_balance_panic, anim_stand_b);
	new Transition(anim_knockout, anim_balance_turn, anim_stand_b);
	new Transition(anim_knockout, anim_idle, anim_stand_b);
	new Transition(anim_knockout, anim_idle, anim_stand_b);
	new Transition(anim_knockout, anim_idle, anim_stand_b);
	new Transition(anim_launch, anim_roll_fast, anim_somersault);
	new Transition(anim_push, anim_crouch, anim_crouch_start);
	new Transition(anim_push, anim_search, anim_search_start);
	new Transition(anim_roll, anim_fall_b, anim_somersault);
	new Transition(anim_roll_fast, anim_crouch, anim_crouch_start);
	new Transition(anim_roll_fast, anim_fall_b, anim_somersault);
	new Transition(anim_roll_fast, anim_idle, anim_land);
	new Transition(anim_roll_fast, anim_launch, anim_somersault);
	new Transition(anim_roll_fast, anim_search, anim_search_start);
	new Transition(anim_roll_fast, anim_stomp, anim_somersault);
	new Transition(anim_roll_slow, anim_idle, anim_stand_a);
	new Transition(anim_run, anim_fall_a, anim_somersault);
	new Transition(anim_run, anim_skid_fast, anim_skid_fast_start);
	new Transition(anim_run, anim_slide, anim_duck);
	new Transition(anim_search, anim_idle, anim_search_stop);
	new Transition(anim_search, anim_push, anim_push_start);
	new Transition(anim_skid_fast, anim_fall_a, anim_somersault);
	new Transition(anim_skid_slow, anim_fall_a, anim_somersault);
	new Transition(anim_slide, anim_fall_a, anim_somersault);
	new Transition(anim_slide, anim_idle, anim_stand_a);
	new Transition(anim_slide, anim_stroll, anim_stand_a);
	new Transition(anim_somersault, anim_fall_a, anim_fall_a_start);
	new Transition(anim_sprint, anim_fall_a, anim_somersault);
	new Transition(anim_sprint, anim_skid_fast, anim_skid_fast_start);
	new Transition(anim_sprint, anim_slide, anim_duck);
	new Transition(anim_stomp, anim_idle, anim_stomp_land);
	new Transition(anim_stomp, anim_jog, anim_somersault);
	new Transition(anim_stomp, anim_run, anim_somersault);
	new Transition(anim_stomp, anim_sprint, anim_somersault);
	new Transition(anim_stomp, anim_stroll, anim_somersault);
	new Transition(anim_stomp, anim_stroll, anim_somersault);
	new Transition(anim_stomp, anim_walk, anim_somersault);
	new Transition(anim_stroll, anim_crouch, anim_crouch_start);
	new Transition(anim_stroll, anim_fall_a, anim_somersault);
	new Transition(anim_stroll, anim_push, anim_push_start);
	new Transition(anim_stroll, anim_search, anim_search_start);
	new Transition(anim_stroll, anim_slide, anim_duck);
	new Transition(anim_walk, anim_fall_a, anim_somersault);
	new Transition(anim_walk, anim_slide, anim_duck);
}
