function __resnip_options_merge(_base, _overrides) {
	// Variables
	var _result = {};
	var _sources = [_base, _overrides];
	for (var _i = 0; _i < array_length(_sources); _i++) {
		var _names = variable_struct_get_names(_sources[_i]);
		for (var _j = 0; _j < array_length(_names); _j++) {
			variable_struct_set(_result, _names[_j], variable_struct_get(_sources[_i], _names[_j]));
		}
	}
	return _result;
}
