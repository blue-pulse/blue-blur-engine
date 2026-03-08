function _file_save(slot) {
	// Early exit
	if (!slot or (slot > MAX_SLOTS)) {
		print("[ERROR] An invalid slot was received!");
		print("[WARN] No data was saved.");
		exit;
	}

	// Retrieve the save
	ssave_get(cls_save, slot)
	
		// Update the save's values with what's stored
		.set("datetime", date_current_datetime())
		.set("character", get_character_index(global.character))
		.set("lives", min(global.lives, 99))
		.set("position", global.checkpoint.hub_pos)
	
		// Save to disk
		.save();
	
	// Print message
	print($"[INFO] Data from slot {slot} was saved to disk!");
}
