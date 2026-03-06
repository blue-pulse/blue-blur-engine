function _file_load(slot) {
	// Early exit
	if (!slot or (slot > SLOTS)) {
		print("[ERROR] An invalid slot was received!");
		print("[ERROR] No data was loaded.");
		exit;
	}

	// Retrieve save
	var save_data = file_get_userdata(slot);
	var last_played = save_data.get("datetime");
	var character_index = save_data.get("character");
	var life = save_data.get("lives");
	var position = save_data.get("position");
	
	// Set data from save
	global.last_played = last_played;
	global.character = resolve_character(character_index);
	global.lives = min(life, 99);
	game_set_checkpoint({ hub_pos: position });
	
	// Update slot index
	global.last_slot = slot;
	file_set_config("last", slot);
	
	// Print message
	print($"[INFO] Data from slot {slot} was loaded!");
}
