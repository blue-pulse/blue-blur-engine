function __resnip_playback_complete(_playback) {
	// Variables
	var _snip = _playback.snip;

	// Completion script
	if (_snip.on_complete != undefined) {
		var _serial = _playback.__serial;
		var _callback = _snip.on_complete;
		_callback(_snip.on_complete_argument, _playback);

		// Prevent a second snip when the script started one
		if (_playback.__serial != _serial) {
			return true;
		}
	}

	// Next snip
	return __resnip_playback_play_next(_playback);
}
