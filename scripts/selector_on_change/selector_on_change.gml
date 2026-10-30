function selector_on_change(facts, params, entering) {
	// Run the reaction of the case that matches the new value of the fact
	var value = facts[$ params.fact];
	if (!entering and value != presentation_marks[$ params.fact]) {
		for (var i = 0; i < array_length(params.cases); i++) {
			if (params.cases[i].to == value) {
				var react = params.cases[i].then.run;
				react(facts, params.cases[i].then);
				break;
			}
		}
	}
	presentation_marks[$ params.fact] = value;
}
