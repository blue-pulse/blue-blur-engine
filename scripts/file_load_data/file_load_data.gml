function file_load_data() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Load save values
	Load = function(slot) {
	    if ((slot <= 0) or (slot > SLOTS) or (slot == global.slot)) {
			exit;
		}
	
	    // Before we update slot index, save the data on the previous one
	    if (global.slot != -1) {
	        Save();
	    }
	
	    // Update slot index
	    global.slot = slot;

	    // Get data from save
		var save_data = file_get_userdata(slot);
	
		// Populate memory
		global.last_playtime = save_data.get("datetime");
		global.character = resolve_character(save_data.get("character"));
		global.lives = save_data.get("lives");
		global.checkpoint.hub_pos = save_data.get("position");
	
		// Save slot in config
		file_set_config("last", slot);
	}
}
