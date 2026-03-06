function game_reset_checkpoint(reset_all=false) {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Checkpoint data
	game_set_checkpoint({ 
		timecount: 0,
		scoring: 0,
		room_pos: [0, 0],
	});
	print("[INFO] Checkpoint parameters were restarted!");
	
	// Reset hub data
	if (reset_all) {
		game_set_checkpoint({ hub_pos: [0, 0] });
		print("[INFO] Hub parameters were restarted!");
	}
}
