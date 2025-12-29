function sonic_init_transitions() {
	// Crouch
	animation_set_transition(anim_crouch, anim_idle, anim_crouch_stop);
	
	// Fall
	animation_set_transition(anim_fall_fast_loop, anim_idle, anim_land);
	animation_set_transition(anim_fall_fast_loop, anim_stroll, anim_land);
	animation_set_transition(anim_fall_loop, anim_idle, anim_land);
	animation_set_transition(anim_fall_loop, anim_stroll, anim_land);
	animation_set_transition(anim_fall_slow_loop, anim_idle, anim_land);
	animation_set_transition(anim_fall_slow_loop, anim_stroll, anim_land);
	
	// Idle
	animation_set_transition(anim_idle, anim_crouch, anim_crouch_start);
	animation_set_transition(anim_idle, anim_search, anim_search_start);
	
	// Roll
	animation_set_transition(anim_roll, anim_idle, anim_land);
	animation_set_transition(anim_roll, anim_stroll, anim_land);
	animation_set_transition(anim_roll_fast, anim_idle, anim_land);
	animation_set_transition(anim_roll_fast, anim_stroll, anim_land);
	animation_set_transition(anim_roll_slow, anim_idle, anim_land);
	animation_set_transition(anim_roll_slow, anim_stroll, anim_land);
	
	// Search
	animation_set_transition(anim_search, anim_idle, anim_search_stop);
}
