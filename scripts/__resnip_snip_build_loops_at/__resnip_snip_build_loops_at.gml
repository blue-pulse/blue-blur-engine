function __resnip_snip_build_loops_at(_loops, _count) {
	// Every frame lists the loops that hold it, in the order of the loops
	var _none = [];
	var _at = array_create(_count, _none);
	for (var _i = 0; _i < array_length(_loops); _i++) {
		for (var _f = _loops[_i].first; _f <= _loops[_i].last; _f++) {
			if (_at[_f] == _none) {
				_at[_f] = [];
			}
			array_push(_at[_f], _i);
		}
	}
	return _at;
}
