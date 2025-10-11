function sonic_init_animations(){
	// Initialize variables
	snip_create_event();
	
	// Balance
	anim_balance_back = new Snip(spr_sonic_balance_back, 1);
	anim_balance_front = new Snip(spr_sonic_balance_front, 1);
	
	// Idle
	anim_idle = new Snip(spr_sonic_idle, 1);
	
	// Run
	anim_stroll = new Snip(spr_sonic_stroll, 1);
	anim_walk = new Snip(spr_sonic_walk, 1);
	anim_jog = new Snip(spr_sonic_jog, 1);
	anim_run = new Snip(spr_sonic_run, 1);
	anim_sprint = new Snip(spr_sonic_sprint, 1);
}
