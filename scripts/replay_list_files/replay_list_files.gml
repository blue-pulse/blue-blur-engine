function replay_list_files() {
	// Variables
	var _config = file_get_folder(FOLDER_CONFIG);
	var _saves = file_get_folder(FOLDER_SAVES);
	var _paths = [];
	array_push(_paths, $"{_config}/{SETTINGS}");
	array_push(_paths, $"{_config}/{USERDATA}");

	// Add a file for each slot
	for (var _i = 1; _i <= MAX_SLOTS; _i++) {
		array_push(_paths, $"{_saves}/{file_get_slot_name(_i)}");
	}

	// Return value
	return _paths;
}
