if (usable and active) {
	// Switch flag
	usable = false;
	
	// Set checkpoint data
	game_set_checkpoint({ hub_pos: [x, y] });
}
