function __resnip_playback_move(_playback) {
	// Variables
	var _snip = _playback.snip;
	var _forward = _playback.direction > 0;
	var _next = _playback.frame + _playback.direction;

	// Loop edge
	if (_playback.__loop != __RESNIP_NO_LOOP) {
		var _loop = _snip.loops[_playback.__loop];
		if (_playback.frame == (_forward ? _loop.last : _loop.first)) {
			_playback.__passes[_playback.__loop] += 1;
			_next = _forward ? _loop.first : _loop.last;
			if (_playback.__passes[_playback.__loop] >= __resnip_loop_repeat(_playback, _loop)) {
				_playback.__loop = __RESNIP_NO_LOOP;
			}
		}
	}

	// Snip edge
	if (_next < 0 || _next >= _snip.count) {
		__resnip_playback_finish(_playback);
		return;
	}

	// Enter the next frame
	_playback.frame = _next;
	__resnip_playback_enter(_playback);
}
