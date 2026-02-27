function player_init_animations() {
	// Initialize variables
	animation_setup_init();

	// Balance
	anim_balance_back = animation_create(sprite_index);
	anim_balance_front = animation_create(sprite_index);
	
	// Crouch
	anim_crouch = animation_create(sprite_index);
	anim_crouch_start = animation_create(sprite_index);
	anim_crouch_stop = animation_create(sprite_index);
	
	// Dashpanel
	anim_dashpanel = animation_create(sprite_index);
	
	// Fall
	anim_fall = animation_create(sprite_index);
	anim_fall_loop = animation_create(sprite_index);
	anim_fall_fast = animation_create(sprite_index);
	anim_fall_fast_loop = animation_create(sprite_index);
	anim_fall_slow = animation_create(sprite_index);
	anim_fall_slow_loop = animation_create(sprite_index);
	
	// Hurt
	anim_hurt = animation_create(sprite_index);
	anim_hurt_loop = animation_create(sprite_index);
	
	// Idle
	anim_idle = animation_create(sprite_index);
	
	// Knock-out
	anim_knockout = animation_create(sprite_index);
	anim_knockout_loop = animation_create(sprite_index);
	
	// Land
	anim_land = animation_create(sprite_index);
	
	// Launch
	anim_launch = animation_create(sprite_index);
	
	// Push
	anim_push = animation_create(sprite_index);
	anim_push_start = animation_create(sprite_index);
	anim_push_end = animation_create(sprite_index);
	
	// Recovery
	anim_recovery = animation_create(sprite_index);
	
	// Rise
	anim_rise = animation_create(sprite_index);
	anim_rise_loop = animation_create(sprite_index);
	
	// Run
	anim_stroll = animation_create(sprite_index);
	anim_walk = animation_create(sprite_index);
	anim_jog = animation_create(sprite_index);
	anim_run = animation_create(sprite_index);
	anim_sprint = animation_create(sprite_index);
	
	// Roll
	anim_roll_jump = animation_create(sprite_index);
	anim_roll_fast = animation_create(sprite_index);
	anim_roll_slow = animation_create(sprite_index);
	
	// Search
	anim_lookup = animation_create(sprite_index);
	anim_lookup_start = animation_create(sprite_index);
	anim_lookup_stop = animation_create(sprite_index);
	
	// Skid
	anim_skid_fast = animation_create(sprite_index);
	anim_skid_fast_loop = animation_create(sprite_index);
	anim_skid_slow = animation_create(sprite_index);
	anim_skid_slow_loop = animation_create(sprite_index);
	anim_skid_turn = animation_create(sprite_index);
	
	// Somersault
	anim_somersault = animation_create(sprite_index);
	
	// Spindash
	anim_spindash = animation_create(sprite_index);
	anim_spindash_charge = animation_create(sprite_index);
	
	// Turn
	anim_turn = animation_create(sprite_index);
}
