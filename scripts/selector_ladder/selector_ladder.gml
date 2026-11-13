function selector_ladder(facts, params, entering) {
	// Early exit, the ladder follows from the step after the mode starts and gives way to a fact
	if (entering or (params[$ "unless"] != undefined and facts[$ params.unless])) {
		exit;
	}

	// Play the first band the fact reaches
	var value = facts[$ params.fact];
	var bands = params.bands;
	var count = array_length(bands);
	for (var i = 0; i < count; i++) {
		var band = bands[i];
		var lower = band[$ "from"];
		var reached = (lower != undefined) ? (value >= lower) : (value > band.above);
		if (reached) {
			// Set the pace of the band, which follows the fact
			var pace = band.pace;
			var rate = value;
			var pace_map = pace[$ "map"];
			if (pace_map != undefined) {
				rate = map(value, pace_map[0], pace_map[1], pace_map[2], pace_map[3]);
			}
			var pace_limit = pace[$ "limit"];
			if (pace_limit != undefined) {
				rate = clamp(rate, pace_limit[0], pace_limit[1]);
			}
			animation_play(band.clip, rate);
			break;
		}
	}
}
