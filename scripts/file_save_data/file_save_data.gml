function file_save_data() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Save values into the current slot
	Save = function() {
		// Retrieve the save
		var save_data = file_get_userdata(global.slot);

		// Update the save's values with what's stored in our object, then save to disk
		save_data
			.set("datetime", date_current_datetime())
			.set("character", get_character_index(global.character))
			.set("lives", global.lives)
			.set("position", global.checkpoint.hub_pos)
			.save();
	}
}
