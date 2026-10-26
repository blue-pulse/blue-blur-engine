function animation_add_transition(_from, _to, _via) {
	// Register the transition
	resnip_transition_add(_from.__snip, _to.__snip, _via.__snip, _via.__reversed);

	// Keep the pair to remove it when the instance is gone
	array_push(__animation_transitions, [_from.__snip, _to.__snip]);
}
