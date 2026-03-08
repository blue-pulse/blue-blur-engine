function _file_load(slot) {
	// Early exit
	if (!slot or (slot > MAX_SLOTS)) {
		print("[ERROR] An invalid slot was received!");
		print("[WARN] No data was loaded. Previous values will be used.");
		exit;
	}

	// Retrieve save
	var save_data = ssave_get(cls_save, slot);
	var last_played = save_data.get("datetime");
	var character_index = save_data.get("character");
	var life = save_data.get("lives");
	var position = save_data.get("position");
	
	// Set data from save
	global.last_played = last_played;
	global.character = resolve_character(character_index);
	global.lives = min(life, 99);
	game_set_checkpoint({ hub_pos: position });
	
	// Print message
	if (last_played > 0) {
		print($"[INFO] Data from slot {slot} was loaded!");
	} else {
		print($"[WARN] Slot {slot} was not found. Default values were applied.");
	}
}
