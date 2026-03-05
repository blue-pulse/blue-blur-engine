function _file_load(slot) {
	// Early exit
	if ((slot <= 0) or (slot > SLOTS) or (slot == global.last_slot)) {
		exit;
	}

	// Save current slot before doing anything
	if (global.last_slot != -1) {
		Save();
	}

	// Update slot index
	global.last_slot = slot;

	// Retrieve save
	var save_data = file_get_userdata(slot);
	
	// Get data from save
	global.last_playtime = save_data.get("datetime");
	global.character = resolve_character(save_data.get("character"));
	global.lives = min(save_data.get("lives"), 99);
	global.checkpoint.hub_pos = save_data.get("position");
	
	// Save slot in config
	file_set_config("last", slot);
}
