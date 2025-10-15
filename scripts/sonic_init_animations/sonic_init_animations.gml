function sonic_init_animations(){
	// Initialize variables
	snip_create_event();
	
	// Balance
	anim_balance_back = animation_create(spr_sonic_balance_back);
	anim_balance_front = animation_create(spr_sonic_balance_front);
	
	// Crouch
	anim_crouch = animation_create(spr_sonic_crouch, 1, 3, -1);
	anim_crouch_start = animation_create(spr_sonic_crouch, 1, 0, 2);
	anim_crouch_stop = animation_create(spr_sonic_crouch, -1, 0, 2);
	
	// Idle
	anim_idle = animation_create(spr_sonic_idle);
	
	// Push
	anim_push = animation_create(spr_sonic_push, 1, 3, -1);
	anim_push_start = animation_create(spr_sonic_push, 1.5, 0, 2);
	
	// Run
	anim_stroll = animation_create(spr_sonic_stroll);
	anim_walk = animation_create(spr_sonic_walk);
	anim_jog = animation_create(spr_sonic_jog);
	anim_run = animation_create(spr_sonic_run);
	anim_sprint = animation_create(spr_sonic_sprint);
	anim_peelout = animation_create(spr_sonic_peelout);
	
	// Roll
	anim_roll = new Snip(spr_sonic_roll, 1);
	
	// Search
	anim_search = animation_create(spr_sonic_search, 1, 3, -1);
	anim_search_start = animation_create(spr_sonic_search, 1, 0, 2);
	anim_search_stop = animation_create(spr_sonic_search, -1, 0, 2);
	
	// Skid
	anim_skid_fast = animation_create(spr_sonic_skid_fast, 1, 0, 1);
	anim_skid_fast_loop = animation_create(spr_sonic_skid_fast, 1, 2, 3);
	anim_skid_slow = animation_create(spr_sonic_skid_slow, 1, 0, 0);
	anim_skid_slow_loop = animation_create(spr_sonic_skid_slow, 1, 1, 2);
	anim_skid_turn = animation_create(spr_sonic_skid_turn);
	
	// Spin
	anim_spin_fast = new Snip(spr_sonic_spin_fast, 1);
	anim_spin_slow = new Snip(spr_sonic_spin_slow, 1);
	anim_spindash = animation_create(spr_sonic_spindash);
	anim_spindash_charge =animation_create(spr_sonic_spindash_charge);
	
	// Turn
	anim_turn = animation_create(spr_sonic_turn);
	
	// Additional parameters
	animation_set_callback(anim_skid_turn, player_set_state, player_state_idle);
	animation_set_callback(anim_turn, player_set_state, player_state_idle);
	animation_set_successor(anim_skid_fast, anim_skid_fast_loop);
	animation_set_successor(anim_skid_slow, anim_skid_slow_loop);
	animation_set_successor(anim_spindash_charge, anim_spindash);
}
