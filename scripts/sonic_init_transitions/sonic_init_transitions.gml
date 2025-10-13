function sonic_init_transitions() {
	new Transition(anim_crouch, anim_idle, anim_crouch_stop);
	new Transition(anim_idle, anim_crouch, anim_crouch_start);
	new Transition(anim_idle, anim_search, anim_search_start);
	new Transition(anim_search, anim_idle, anim_search_stop);
}
