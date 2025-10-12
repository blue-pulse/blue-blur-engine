function animation_play(_animation, _speed=1, allow_transition=true) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Set value
	animation = _animation;
	snip_set_speed(_animation, _speed);
	return snip_play_request(_animation, allow_transition);
}
