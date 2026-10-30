function player_init_config() {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Variables
	color_blend = c_white;
	trail_width = 10;

	// Turn lengths in steps
	turn_steps = 4;
	skid_turn_steps = 12;
}
