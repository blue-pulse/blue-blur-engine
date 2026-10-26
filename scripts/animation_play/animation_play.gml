function animation_play(_animation, _speed=ANIMATION_DEFAULT_SPEED) {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Request the animation
	animation = _animation;
	resnip_set_speed(__animation_playback, _speed);
	resnip_play(__animation_playback, _animation.__snip, _animation.__play_options);
}
