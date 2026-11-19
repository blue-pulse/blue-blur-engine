function presentation_update() {
	// Variables
	var _facts = presentation_facts;
	var _entering = _facts.state != presentation_seen;

	// Early exit
	if (!_entering and presentation_follow == undefined) {
		exit;
	}

	// Find the row of a new mode and its follow list
	if (_entering) {
		presentation_seen = _facts.state;
		presentation_row = undefined;
		presentation_follow = undefined;
		var _rows = presentation_set.rows;
		for (var _i = 0; _i < array_length(_rows); _i++) {
			if (_rows[_i].state == _facts.state) {
				presentation_row = _rows[_i];
				presentation_follow = _rows[_i][$ "follow"];
				break;
			}
		}
	}

	// Early exit
	var _row = presentation_row;
	if (_row == undefined) {
		exit;
	}

	// Run the entry list through variables to keep this instance as self
	if (_entering) {
		var _entry = _row[$ "entry"];
		for (var _i = 0; _entry != undefined and _i < array_length(_entry); _i++) {
			var _select = _entry[_i].run;
			_select(_facts, _entry[_i]);
		}
	}

	// React while the mode lasts
	var _follow = presentation_follow;
	for (var _i = 0; _follow != undefined and _i < array_length(_follow); _i++) {
		var _react = _follow[_i].run;
		_react(_facts, _follow[_i], _entering);
	}
}
