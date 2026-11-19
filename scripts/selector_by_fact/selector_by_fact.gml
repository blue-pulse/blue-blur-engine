function selector_by_fact(_facts, _params) {
	// Play the first case that matches the fact
	var _value = _facts[$ _params.fact];
	for (var _i = 0; _i < array_length(_params.cases); _i++) {
		if (_params.cases[_i].value == _value) {
			animation_play(_params.cases[_i].clip);
			break;
		}
	}
}
