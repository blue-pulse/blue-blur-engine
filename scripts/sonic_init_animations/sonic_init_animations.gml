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
	
	// Fall
	anim_fall = animation_create(spr_sonic_fall, 1, 0, 5);
	anim_fall_loop = animation_create(spr_sonic_fall, 1, 5, -1);
	anim_fall_fast = animation_create(spr_sonic_somersault);
	anim_fall_fast_loop = animation_create(spr_sonic_fall_fast);
	anim_fall_slow = animation_create(spr_sonic_somersault);
	anim_fall_slow_loop = animation_create(spr_sonic_fall_slow);
	
	// Idle
	anim_idle = animation_create(spr_sonic_idle);
	
	// Land
	anim_land = animation_create(spr_sonic_land);
	
	// Push
	anim_push = animation_create(spr_sonic_push, 1, 3, -1);
	anim_push_start = animation_create(spr_sonic_push, 1.5, 0, 2);
	
	// Rise
	anim_rise = animation_create(spr_sonic_rise, 1, 0, 0);
	anim_rise_loop = animation_create(spr_sonic_rise, 1, 1, -1);
	
	// Run
	anim_stroll = animation_create(spr_sonic_stroll);
	anim_walk = animation_create(spr_sonic_walk);
	anim_jog = animation_create(spr_sonic_jog);
	anim_run = animation_create(spr_sonic_run);
	anim_sprint = animation_create(spr_sonic_sprint);
	
	// Roll
	anim_roll = animation_create(spr_sonic_roll);
	anim_roll_fast = animation_create(spr_sonic_roll_fast);
	anim_roll_slow = animation_create(spr_sonic_roll_slow);
	
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
	
	// Spindash
	anim_spindash = animation_create(spr_sonic_spindash);
	anim_spindash_charge =animation_create(spr_sonic_spindash_charge);
	
	// Turn
	anim_turn = animation_create(spr_sonic_turn);
	
	// Additional parameters
	animation_set_callback(anim_skid_turn, player_set_state, player_state_idle);
	animation_set_callback(anim_turn, player_set_state, player_state_idle);
	animation_set_successor(anim_fall_fast, anim_fall_fast_loop);
	animation_set_successor(anim_fall_slow, anim_fall_slow_loop);
	animation_set_successor(anim_fall, anim_fall_loop);
	animation_set_successor(anim_rise, anim_rise_loop);
	animation_set_successor(anim_skid_fast, anim_skid_fast_loop);
	animation_set_successor(anim_skid_slow, anim_skid_slow_loop);
	animation_set_successor(anim_spindash_charge, anim_spindash);
}
