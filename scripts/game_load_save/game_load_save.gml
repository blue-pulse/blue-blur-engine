function game_load_save(slot) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Load savedata
	global.slot = slot;
	file_load_savedata(slot);

	// Print message
	print("[INFO] The loading operation for save-type data has been scheduled.");
}
