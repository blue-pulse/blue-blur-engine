function selector_ladder(_facts, _params, _entering) {
	// Wait one step after the mode starts and give way to a fact
	if (_entering or (_params[$ "unless"] != undefined and _facts[$ _params.unless])) {
		exit;
	}

	// Play the first band the fact reaches
	var _value = _facts[$ _params.fact];
	var _bands = _params.bands;
	var _count = array_length(_bands);
	for (var _i = 0; _i < _count; _i++) {
		var _band = _bands[_i];
		var _lower = _band[$ "from"];
		var _reached = (_lower != undefined) ? (_value >= _lower) : (_value > _band.above);
		if (_reached) {
			// Set the pace of the band
			var _pace = _band.pace;
			var _rate = _value;
			var _pace_map = _pace[$ "map"];
			if (_pace_map != undefined) {
				_rate = map(_value, _pace_map[0], _pace_map[1], _pace_map[2], _pace_map[3]);
			}
			var _pace_limit = _pace[$ "limit"];
			if (_pace_limit != undefined) {
				_rate = clamp(_rate, _pace_limit[0], _pace_limit[1]);
			}
			animation_play(_band.clip, _rate);
			break;
		}
	}
}
