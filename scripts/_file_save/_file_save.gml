function _file_save(slot) {
	// Retrieve the save
	var save_data = file_get_userdata(slot);
	
	// Update the save's values with what's stored
	save_data.set("datetime", date_current_datetime());
	save_data.set("character", get_character_index(global.character));
	save_data.set("lives", min(global.lives, 99));
	save_data.set("position", global.checkpoint.hub_pos);
	
	// Save to disk
	save_data.save();
}
