function sonic_init_transitions() {
	// Crouch
	animation_set_transition(anim_crouch, anim_idle, anim_crouch_stop);
	
	// Idle
	animation_set_transition(anim_idle, anim_crouch, anim_crouch_start);
	animation_set_transition(anim_idle, anim_search, anim_search_start);
	
	// Search
	animation_set_transition(anim_search, anim_idle, anim_search_stop);
}
