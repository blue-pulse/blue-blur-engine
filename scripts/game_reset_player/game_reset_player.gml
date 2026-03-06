function game_reset_player() {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Reset values
	global.character = obj_sonic;
	global.protagonist = noone;
	global.score = 0;
	
	// Print message
	print("[INFO] Player parameters were restarted!");
}
