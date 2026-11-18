function replay_create_source(_segments) {
	// Variables
	var _plan = { segments: _segments, ends: [], steps: 0 };

	// Find the last step of each segment
	for (var _i = 0; _i < array_length(_segments); _i++) {
		_plan.steps += _segments[_i].steps;
		array_push(_plan.ends, _plan.steps);
	}

	// Return value
	_plan.source = method(_plan, function(_step, _button) {
		var _i = 0;
		while (_i < array_length(ends) and _step >= ends[_i]) {
			_i++;
		}
		return _i < array_length(ends) and array_contains(segments[_i].hold, _button);
	});
	return _plan;
}
