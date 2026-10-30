function selector_on_count(facts, params, entering) {
	// Run the reaction when the counter grew since the last look
	var count = facts[$ params.fact];
	if (!entering and count != presentation_marks[$ params.fact]) {
		var react = params.then.run;
		react(facts, params.then);
	}
	presentation_marks[$ params.fact] = count;
}
