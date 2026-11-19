function selector_on_count(_facts, _params, _entering) {
	// Run the reaction when the counter grew
	var _count = _facts[$ _params.fact];
	if (!_entering and _count != presentation_marks[$ _params.fact]) {
		var _react = _params.then.run;
		_react(_facts, _params.then);
	}
	presentation_marks[$ _params.fact] = _count;
}
