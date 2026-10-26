/// @func resnip_step(playback, [steps])
/// @desc Advances a playback by some game steps. Call it once per step. It moves frame by frame, so a script runs for every frame the playback enters even at a high speed. It replaces the automatic advance of image_speed, which the library does not use. For delta time pass delta_time / 1000000 * game_get_speed(gamespeed_fps) as the steps.
/// @param {Struct} playback The playback to advance
/// @param {Real} [steps] How many steps to advance, a fraction for delta time (default 1)
function resnip_step(_playback, _steps) {
	// Prevent a playback that cannot move from advancing, before any local so the VM builds no locals for it
	if (_playback.snip == undefined || _playback.stopped || _playback.paused || _playback.clock.paused) {
		return;
	}

	// Variables, with the default of steps read here because a default argument costs a write on YYC
	var _snip = _playback.snip;
	var _remaining = _steps ?? 1;
	while (_remaining > __RESNIP_EPSILON) {
		// Speed of the current frame
		var _rate = _playback.__frame_speeds[_playback.frame] * _snip.__scale * _playback.speed * _playback.clock.scale;
		if (_snip.__per_second) {
			_rate /= game_get_speed(gamespeed_fps);
		}
		if (_rate <= 0) {
			return;
		}

		// Stay in the frame when the steps do not finish it
		var _room = 1 - _playback.__progress;
		if (_remaining * _rate < _room - __RESNIP_EPSILON) {
			_playback.__progress += _remaining * _rate;
			return;
		}

		// Finish the frame
		_remaining -= _room / _rate;
		_playback.__progress = 0;

		// Enter the next frame here when no loop and no edge of the snip is involved
		var _next = _playback.frame + _playback.direction;
		var _plain = false;
		if (_playback.__loop != __RESNIP_NO_LOOP) {
			var _loop = _snip.loops[_playback.__loop];
			_plain = _playback.frame != ((_playback.direction > 0) ? _loop.last : _loop.first);
		} else if (_next >= 0 && _next < _snip.count) {
			_plain = array_length(_snip.__loops_at[_next]) == 0 || !__resnip_playback_loop_waits(_playback, _snip, _next);
		}
		if (_plain) {
			_playback.frame = _next;
			var _script = _snip.frame_scripts[_next];
			if (_script == undefined) {
				continue;
			}
			var _callback = _script.callback;
			_callback(_script.argument, _playback);
		} else {
			__resnip_playback_move(_playback);
		}

		// Stop for what a callback did
		if (_playback.stopped || _playback.paused || _playback.clock.paused) {
			return;
		}
		_snip = _playback.snip;
	}
}
