function __easyfade_begin(_room, _duration, _color, _fade_audio) {
	// Refuse a second fade
	if (easyfade_is_active()) {
		__easyfade_trace("[ERROR] Another fade is already in progress! Wait until easyfade_is_active returns false.");
		return false;
	}

	// Refuse a room that does not exist
	if (_room != noone and !room_exists(_room)) {
		__easyfade_trace("[ERROR] The room " + string(_room) + " does not exist, so no fade was started! Pass a room asset.");
		return false;
	}

	// Create the controller
	instance_create_depth(0, 0, EASYFADE_DEPTH, __easyfade_controller, {
		__color: _color,
		__duration: max(_duration, 1),
		__target_room: _room,
		__fade_audio: _fade_audio,
	});
	return true;
}
