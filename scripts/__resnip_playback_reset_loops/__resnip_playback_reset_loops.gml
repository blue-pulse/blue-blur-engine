function __resnip_playback_reset_loops(_playback) {
	static _no_loops = [];
	_playback.__loop = __RESNIP_NO_LOOP;

	// Share one empty array for a snip with no loops, before any local so the VM builds no locals for it
	if (array_length(_playback.snip.loops) == 0) {
		_playback.__passes = _no_loops;
		return;
	}

	// Reuse the counts of the playback when they fit, since a new array costs memory and time
	var _count = array_length(_playback.snip.loops);
	var _passes = _playback.__passes;
	if (_passes != undefined && _passes != _no_loops && array_length(_passes) == _count) {
		for (var _i = 0; _i < _count; _i++) {
			_passes[_i] = 0;
		}
	} else {
		_playback.__passes = array_create(_count, 0);
	}
}
