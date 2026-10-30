function selector_by_band(facts, params) {
	// Play the animation of the first case whose lower limit the fact reaches
	var value = facts[$ params.fact];
	for (var i = 0; i < array_length(params.cases); i++) {
		if (value >= params.cases[i].from) {
			animation_play(params.cases[i].clip);
			break;
		}
	}
}
