function __resnip_playback_loop_waits(_playback, _snip, _frame) {
	// Whether entering the frame would enter or skip one of its loops
	var _candidates = _snip.__loops_at[_frame];
	for (var _j = 0; _j < array_length(_candidates); _j++) {
		var _i = _candidates[_j];
		var _repeats = __resnip_loop_repeat(_playback, _snip.loops[_i]);
		var _passes = _playback.__passes[_i];
		if (_passes < _repeats || (_repeats < 0 && _passes <= 0)) {
			return true;
		}
	}
	return false;
}
