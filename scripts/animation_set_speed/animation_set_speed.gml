function animation_set_speed(_animation, _speed=1) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Set value
	animation = _animation;
	return snip_set_speed(_animation, _speed);
}
