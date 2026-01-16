function sonic_init_transitions() {
	// Crouch
	animation_set_transition(anim_crouch, anim_idle, anim_crouch_stop);
	
	// Fall
	animation_set_transition(anim_fall_fast_loop, anim_idle, anim_land);
	animation_set_transition(anim_fall_fast_loop, anim_stroll, anim_land);
	animation_set_transition(anim_fall_fast_loop, anim_turn, anim_land);
	animation_set_transition(anim_fall_loop, anim_idle, anim_land);
	animation_set_transition(anim_fall_loop, anim_stroll, anim_land);
	animation_set_transition(anim_fall_loop, anim_turn, anim_land);
	animation_set_transition(anim_fall_slow_loop, anim_idle, anim_land);
	animation_set_transition(anim_fall_slow_loop, anim_stroll, anim_land);
	animation_set_transition(anim_fall_slow_loop, anim_turn, anim_land);
	
	// Idle
	animation_set_transition(anim_idle, anim_crouch, anim_crouch_start);
	animation_set_transition(anim_idle, anim_lookup, anim_lookup_start);
	
	// Knock-out
	animation_set_transition(anim_knockout_loop, anim_idle, anim_recovery);
	
	// Push
	animation_set_transition(anim_push, anim_idle, anim_push_end);
	animation_set_transition(anim_push, anim_stroll, anim_push_end);
	
	// Roll
	animation_set_transition(anim_roll_fast, anim_idle, anim_land);
	animation_set_transition(anim_roll_fast, anim_stroll, anim_land);
	animation_set_transition(anim_roll_jump, anim_idle, anim_land);
	animation_set_transition(anim_roll_jump, anim_stroll, anim_land);
	animation_set_transition(anim_roll_slow, anim_idle, anim_land);
	animation_set_transition(anim_roll_slow, anim_stroll, anim_land);
	
	// Search
	animation_set_transition(anim_lookup, anim_idle, anim_lookup_stop);
	
	// Stroll
	animation_set_transition(anim_stroll, anim_push, anim_push_start);
}
