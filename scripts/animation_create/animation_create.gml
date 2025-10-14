function animation_create(_sprite, _speed=1, _start=0, _end=-1) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Variables
	var animation;
	
	// Set last frame
	if (!_end) {
		_end = sprite_get_number(_sprite) - 1;
	}
	
	// Set animation backwards
	if (!_speed) {
		animation = new Snip(_sprite, abs(_speed), _start, _end);
		snip_set_backward(animation);
	} 
	
	// Set animation
	else {
		animation = new Snip(_sprite, _speed, _start, _end);
	}
	
	
	// Return value
	return animation;
}
