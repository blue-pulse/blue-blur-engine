function __resnip_snip_build_durations(_sprite, _first_image, _count) {
	// A sprite whose frames all last 1 in the sprite editor has no frame_info
	var _info = sprite_get_info(_sprite).frame_info;
	if (_info == undefined) {
		return undefined;
	}

	// The duration of every frame of the snip, found by its sub-image
	var _durations = array_create(_count, 1);
	for (var _i = 0; _i < array_length(_info); _i++) {
		var _frame = _info[_i].image_index - _first_image;
		if (_frame < 0 || _frame >= _count) {
			continue;
		}

		// Prevent a duration that cannot be divided by, which the sprite editor was not seen to allow
		var _duration = _info[_i].duration;
		if (!is_numeric(_duration) || _duration <= 0) {
			show_debug_message("[WARNING] " + sprite_get_name(_sprite) + " gives sub-image " + string(_info[_i].image_index) + " the duration " + string(_duration) + ", so the snip plays it with a duration of 1. Give the frame a duration above 0 in the sprite editor.");
			continue;
		}
		_durations[_frame] = _duration;
	}
	return _durations;
}
