function player_init_config() {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Variables
	color_blend = c_white;
	trail_alpha = array_create(table_size, 0);
}
