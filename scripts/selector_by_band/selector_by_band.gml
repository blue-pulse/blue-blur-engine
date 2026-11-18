function selector_by_band(_facts, _params) {
	// Play the animation of the first case whose lower limit the fact reaches
	var _value = _facts[$ _params.fact];
	for (var _i = 0; _i < array_length(_params.cases); _i++) {
		if (_value >= _params.cases[_i].from) {
			animation_play(_params.cases[_i].clip);
			break;
		}
	}
}
