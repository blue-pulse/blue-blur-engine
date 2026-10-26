function __resnip_playback_enter(_playback) {
	// Variables
	var _snip = _playback.snip;

	// Look for a loop to enter
	if (_playback.__loop == __RESNIP_NO_LOOP) {
		var _candidates = _snip.__loops_at[_playback.frame];
		for (var _j = 0; _j < array_length(_candidates); _j++) {
			var _i = _candidates[_j];
			var _loop = _snip.loops[_i];

			var _repeats = __resnip_loop_repeat(_playback, _loop);
			var _passes = _playback.__passes[_i];

			// Skip a loop with a negative count
			if (_repeats < 0 && _passes <= 0) {
				_playback.__passes[_i] += 1;
				var _target = (_playback.direction > 0) ? _loop.last + 1 : _loop.first - 1;

				// Prevent skips that never end, which happen when loops skip every frame
				if (_playback.__skips >= array_length(_snip.loops)) {
					__resnip_playback_give_up(_playback);
					return;
				}

				// Follow the skip
				_playback.__skips += 1;
				if (_target < 0 || _target >= _snip.count) {
					__resnip_playback_finish(_playback);
				} else {
					_playback.frame = _target;
					__resnip_playback_enter(_playback);
				}
				_playback.__skips = max(_playback.__skips - 1, 0);
				return;
			}

			// Enter a loop that still repeats
			if (_passes < _repeats) {
				_playback.__loop = _i;
				break;
			}
		}
	}

	// Frame script
	var _script = _snip.frame_scripts[_playback.frame];
	if (_script != undefined) {
		var _callback = _script.callback;
		_callback(_script.argument, _playback);
	}
}
