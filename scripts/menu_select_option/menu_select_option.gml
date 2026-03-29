function menu_select_option(def_state, sel_state) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Logic
	for (var i = 0; i < options_count; ++i) {
		options[i].state = def_state;
	}
	options[option_active].state = sel_state;
}
