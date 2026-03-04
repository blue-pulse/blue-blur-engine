function effect_fade(_duration=60, _color=c_black, _silent=false) {
	instance_create_depth(0, 0, -4096, _fade_controller, {
		color: _color,
		duration: _duration,
		target_room: noone,
		silent_fading: _silent,
	});
}
