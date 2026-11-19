function selector_on_change(_facts, _params, _entering) {
	// Run the case that matches the new value of the fact
	var _value = _facts[$ _params.fact];
	if (!_entering and _value != presentation_marks[$ _params.fact]) {
		for (var _i = 0; _i < array_length(_params.cases); _i++) {
			if (_params.cases[_i].to == _value) {
				var _react = _params.cases[_i].then.run;
				_react(_facts, _params.cases[_i].then);
				break;
			}
		}
	}
	presentation_marks[$ _params.fact] = _value;
}
