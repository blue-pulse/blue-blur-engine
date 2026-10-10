function __easyfade_begin(_room, _duration, _color, _fade_audio) {
	// Refuse a second fade
	if (easyfade_is_active()) {
		__easyfade_trace("[ERROR] Another fade is already in progress!");
		return false;
	}

	// Create the controller
	instance_create_depth(0, 0, EASYFADE_DEPTH, __easyfade_controller, {
		__color: _color,
		__duration: _duration,
		__target_room: _room,
		__fade_audio: _fade_audio,
	});
	return true;
}
