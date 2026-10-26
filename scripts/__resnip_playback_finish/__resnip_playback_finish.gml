function __resnip_playback_finish(_playback) {
	// Variables
	var _snip = _playback.snip;
	var _forward = _playback.direction > 0;

	// Completion
	var _completes = true;
	if (_snip.end_mode == RESNIP_END.PINGPONG) {
		if (_snip.complete_on == RESNIP_COMPLETE.HEAD) {
			_completes = !_forward;
		} else if (_snip.complete_on == RESNIP_COMPLETE.TAIL) {
			_completes = _forward;
		}
	}
	if (_completes && __resnip_playback_complete(_playback)) {
		return;
	}

	// End mode
	switch (_snip.end_mode) {
		case RESNIP_END.HOLD:
			_playback.frame = _forward ? _snip.count - 1 : 0;
			_playback.stopped = true;
		break;

		case RESNIP_END.REWIND:
			_playback.frame = 0;
			_playback.stopped = true;
		break;

		case RESNIP_END.FASTFORWARD:
			_playback.frame = _snip.count - 1;
			_playback.stopped = true;
		break;

		case RESNIP_END.REPEAT:
			_playback.frame = _forward ? 0 : _snip.count - 1;
			__resnip_playback_reset_loops(_playback);
			__resnip_playback_enter(_playback);
		break;

		case RESNIP_END.PINGPONG:
			_playback.direction = -_playback.direction;
			_playback.frame = clamp(_forward ? _snip.count - 2 : 1, 0, _snip.count - 1);
			__resnip_playback_reset_loops(_playback);
			__resnip_playback_enter(_playback);
		break;
	}
}
