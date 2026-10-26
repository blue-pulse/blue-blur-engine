function __resnip_snip_build_frame_speeds(_entries, _count) {
	// Variables
	var _speeds = array_create(_count, 1);
	for (var _i = 0; _i < array_length(_entries); _i++) {
		var _entry = _entries[_i];

		// Prevent a frame outside the snip
		__resnip_check_frame(_entry.frame, _count, "resnip_snip_create frame_speeds");

		// Prevent a speed that cannot move
		if (_entry.speed < 0) {
			__resnip_error("resnip_snip_create frame_speeds received speed " + string(_entry.speed) + " for frame " + string(_entry.frame) + ". Use a speed of 0 or above, and play backward with the backward option of resnip_play.");
		}

		// Store the speed
		_speeds[_entry.frame] = _entry.speed;
	}
	return _speeds;
}
