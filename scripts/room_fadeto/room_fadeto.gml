function room_fadeto(_room, _steps=60, _color=c_black) {
	with (instance_create_depth(0, 0, -4096, _fade_controller)) {
		target_room = _room;
		duration = _steps;
		color = _color;
	}
}
