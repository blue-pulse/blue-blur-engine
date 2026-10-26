function __resnip_playback_start(_playback, _snip, _transition, _asked_backward, _frame) {
	// Transition, with the direction in a local because writing an argument costs time on YYC
	var _backward = _asked_backward;
	var _use = _snip;
	var _target = undefined;
	var _target_backward = _backward;
	if (_transition) {
		var _from = _playback.__target ?? _playback.snip;
		var _found = (_from == undefined) ? undefined : resnip_transition_find(_from, _snip);
		if (_found != undefined) {
			_use = _found.use;
			_target = _snip;
			_backward = _found.backward;
		}
	}

	// Reset the state
	if (_use != _playback.snip) {
		_playback.__frame_speeds = _use.__frame_speeds;
	}
	_playback.snip = _use;
	_playback.direction = _backward ? RESNIP_BACKWARD : RESNIP_FORWARD;
	// Start frame, with an if because ?? measured slower on YYC
	if (_frame == undefined) {
		_playback.frame = _backward ? _use.count - 1 : 0;
	} else {
		_playback.frame = _frame;
	}
	_playback.stopped = false;
	_playback.__progress = 0;
	_playback.__queue = undefined;
	_playback.__target = _target;
	_playback.__target_backward = _target_backward;
	_playback.__serial += 1;
	_playback.__skips = 0;
	__resnip_playback_reset_loops(_playback);
	__resnip_playback_enter(_playback);
}
