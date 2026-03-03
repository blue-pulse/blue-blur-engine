function player_update_grid() {	
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Save horizontal position
	array_delete(pos_grid[0], 0, 1);
	array_push(pos_grid[0], x);

	// Save vertical position
	array_delete(pos_grid[1], 0, 1);
	array_push(pos_grid[1], y);
}
