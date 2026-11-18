function menu_select_option(_def_state, _sel_state) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Logic
	for (var _i = 0; _i < options_count; ++_i) {
		options[_i].state = _def_state;
	}
	options[option_active].state = _sel_state;
}
