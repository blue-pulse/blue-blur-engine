function sonic_init_animations(){
	// Initialize variables
	snip_create_event();
	
	// Balance
	anim_balance_back = new Snip(spr_sonic_balance_back, 1);
	anim_balance_front = new Snip(spr_sonic_balance_front, 1);
	
	// Crouch
	anim_crouch = new Snip(spr_sonic_crouch, 1, 3);
	anim_crouch_start = new Snip(spr_sonic_crouch, 1, 0, 2);
	anim_crouch_stop = new Snip(spr_sonic_crouch, 1, 0, 2);
	snip_set_backward(anim_crouch_stop);
	
	// Idle
	anim_idle = new Snip(spr_sonic_idle, 1);
	
	// Push
	anim_push = new Snip(spr_sonic_push, 1, 3);
	anim_push_start = new Snip(spr_sonic_push, 1.5, 0, 2);
	
	// Run
	anim_stroll = new Snip(spr_sonic_stroll, 1);
	anim_walk = new Snip(spr_sonic_walk, 1);
	anim_jog = new Snip(spr_sonic_jog, 1);
	anim_run = new Snip(spr_sonic_run, 1);
	anim_sprint = new Snip(spr_sonic_sprint, 1);
	anim_peelout = new Snip(spr_sonic_peelout, 1);
	
	// Search
	anim_search = new Snip(spr_sonic_search, 1, 3);
	anim_search_start = new Snip(spr_sonic_search, 1, 0, 2);
	anim_search_stop = new Snip(spr_sonic_search, 1, 0, 2);
	snip_set_backward(anim_search_stop);
	
	// Skid
	anim_skid_fast = new Snip(spr_sonic_skid_fast, 1);
	anim_skid_slow = new Snip(spr_sonic_skid_slow, 1);
	anim_skid_turn = new Snip(spr_sonic_skid_turn, 1);
	animation_set_callback(anim_skid_turn, player_set_state, player_state_idle);
	
	// Turn
	anim_turn = new Snip(spr_sonic_turn, 1);
	animation_set_callback(anim_turn, player_set_state, player_state_idle);
}
