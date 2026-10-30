function selector_by_fact(facts, params) {
	// Play the animation of the first case that matches the fact
	var value = facts[$ params.fact];
	for (var i = 0; i < array_length(params.cases); i++) {
		if (params.cases[i].value == value) {
			animation_play(params.cases[i].clip);
			break;
		}
	}
}
