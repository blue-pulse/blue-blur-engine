function sonic_create_anims(){
	// Initialize variables
	snip_create_event();
	
	// Balance
	anim_balance_back = new Snip(spr_sonic_balance_back, 1);
	anim_balance_front = new Snip(spr_sonic_balance_front, 1);
	
	// Idle
	anim_idle = new Snip(spr_sonic_idle, 1);
}
