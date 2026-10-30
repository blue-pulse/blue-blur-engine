function animation_add_transition(_from, _to, _via) {
	// Register the transition
	resnip_transition_add(_from.__snip, _to.__snip, _via.__snip, _via.__reversed);
}
