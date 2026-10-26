function __resnip_snip_build_loops(_entries, _count) {
	// Variables
	var _loops = array_create(array_length(_entries));
	for (var _i = 0; _i < array_length(_entries); _i++) {
		var _entry = _entries[_i];

		// Prevent a frame outside the snip
		__resnip_check_frame(_entry.first, _count, "resnip_snip_create loops");
		__resnip_check_frame(_entry.last, _count, "resnip_snip_create loops");

		// Prevent a loop that ends before it starts
		if (_entry.first > _entry.last) {
			__resnip_error("resnip_snip_create loops received a loop that starts at frame " + string(_entry.first) + " and ends at frame " + string(_entry.last) + ". The first frame must not come after the last frame.");
		}

		// Prevent a count that is not whole
		if (_entry.repeats != floor(_entry.repeats)) {
			__resnip_error("resnip_snip_create loops received repeats " + string(_entry.repeats) + ". Use a whole number, where 0 plays once and below 0 skips the loop.");
		}

		// Store the loop
		_loops[_i] = { first: _entry.first, last: _entry.last, repeats: _entry.repeats, __key: string(__resnip_next_id()) };
	}
	return _loops;
}
