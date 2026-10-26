function __resnip_playback_play_next(_playback) {
	// Pick what plays next
	var _next = _playback.__queue;
	var _transition = false;
	var _backward = false;
	if (_next != undefined) {
		_transition = _next.transition;
		_backward = _next.backward;
		_next = _next.snip;
	} else {
		_next = _playback.__target;
		if (_next != undefined) {
			_backward = _playback.__target_backward;
		} else {
			_next = _playback.snip.next;
			if (_next == undefined) {
				return false;
			}
			_transition = _playback.snip.next_transition;
			_backward = _playback.snip.next_backward;
		}
	}

	// Start it
	if (_next == _playback.snip) {
		_transition = false;
	}
	__resnip_playback_start(_playback, _next, _transition, _backward, undefined);
	return true;
}
