function game_reset_player() {
	// Reset values
	global.character = global.default_character;
	game_set_player(noone);
	global.score = 0;
	
	// Print message
	print("[INFO] Player parameters were restarted!");
}
