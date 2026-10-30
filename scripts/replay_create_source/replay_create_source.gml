function replay_create_source(segments) {
	// Variables
	var plan = { segments: segments, ends: [], steps: 0 };

	// Find the last step of each segment
	for (var i = 0; i < array_length(segments); i++) {
		plan.steps += segments[i].steps;
		array_push(plan.ends, plan.steps);
	}

	// Return value
	plan.source = method(plan, function(_step, _button) {
		var i = 0;
		while (i < array_length(ends) and _step >= ends[i]) {
			i++;
		}
		return i < array_length(ends) and array_contains(segments[i].hold, _button);
	});
	return plan;
}
