function sonic_init_transitions(clips) {	
	// Early exit
	static registered = false;
	if (registered) {
		exit;
	}
	registered = true;

	// Crouch
	animation_add_transition(clips.crouch, clips.idle, clips.crouch_stop);
	
	// Fall
	animation_add_transition(clips.fall_fast_loop, clips.idle, clips.land);
	animation_add_transition(clips.fall_fast_loop, clips.stroll, clips.land);
	animation_add_transition(clips.fall_fast_loop, clips.turn, clips.land);
	animation_add_transition(clips.fall_loop, clips.idle, clips.land);
	animation_add_transition(clips.fall_loop, clips.stroll, clips.land);
	animation_add_transition(clips.fall_loop, clips.turn, clips.land);
	animation_add_transition(clips.fall_slow_loop, clips.idle, clips.land);
	animation_add_transition(clips.fall_slow_loop, clips.stroll, clips.land);
	animation_add_transition(clips.fall_slow_loop, clips.turn, clips.land);
	
	// Idle
	animation_add_transition(clips.idle, clips.crouch, clips.crouch_start);
	animation_add_transition(clips.idle, clips.lookup, clips.lookup_start);
	
	// Knock-out
	animation_add_transition(clips.knockout_loop, clips.idle, clips.recovery);
	
	// Push
	animation_add_transition(clips.push, clips.idle, clips.push_end);
	animation_add_transition(clips.push, clips.stroll, clips.push_end);
	
	// Roll
	animation_add_transition(clips.roll_fast, clips.idle, clips.land);
	animation_add_transition(clips.roll_fast, clips.turn, clips.land);
	animation_add_transition(clips.roll_fast, clips.stroll, clips.land);
	animation_add_transition(clips.roll_jump, clips.idle, clips.land);
	animation_add_transition(clips.roll_jump, clips.turn, clips.land);
	animation_add_transition(clips.roll_jump, clips.stroll, clips.land);
	animation_add_transition(clips.roll_slow, clips.idle, clips.land);
	animation_add_transition(clips.roll_slow, clips.turn, clips.land);
	animation_add_transition(clips.roll_slow, clips.stroll, clips.land);
	
	// Search
	animation_add_transition(clips.lookup, clips.idle, clips.lookup_stop);
	
	// Stroll
	animation_add_transition(clips.stroll, clips.push, clips.push_start);
}
