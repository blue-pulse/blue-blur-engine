function effect_fade(_duration=60, _color=c_black) {
	with (instance_create_depth(0, 0, -4096, _fade_controller)) {
		target_room = noone;
		duration = _duration;
		color = _color;
	}
}
