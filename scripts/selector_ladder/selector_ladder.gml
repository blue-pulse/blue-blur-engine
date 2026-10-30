function selector_ladder(facts, params, entering) {
	// Early exit, the ladder follows from the step after the mode starts and gives way to a fact
	if (entering or (params[$ "unless"] != undefined and facts[$ params.unless])) {
		exit;
	}

	// Play the first band the fact reaches
	var value = facts[$ params.fact];
	for (var i = 0; i < array_length(params.bands); i++) {
		var band = params.bands[i];
		var reached = (band[$ "from"] != undefined) ? (value >= band.from) : (value > band.above);
		if (reached) {
			// Set the pace of the band, which follows the fact
			var pace = band.pace;
			var rate = value;
			if (pace[$ "map"] != undefined) {
				rate = map(value, pace.map[0], pace.map[1], pace.map[2], pace.map[3]);
			}
			if (pace[$ "limit"] != undefined) {
				rate = clamp(rate, pace.limit[0], pace.limit[1]);
			}
			animation_play(band.clip, rate);
			break;
		}
	}
}
