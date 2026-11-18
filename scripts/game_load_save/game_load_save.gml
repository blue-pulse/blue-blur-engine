function game_load_save(_slot) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Load savedata
	global.slot = _slot;
	file_load_savedata(_slot);

	// Print message
	print("[INFO] The loading operation for save-type data has been scheduled.");
}
