function room_fadeto(_room, _steps=60, _color=c_black, _silent=false) {
	instance_create_depth(0, 0, -4096, _fade_controller, {
		color: _color,
		duration: _steps,
		target_room: _room,
		silent_fading: _silent,
	});
}
