function file_load_savedata(_index) {
	// Early exit
	if (!file_is_slot_valid(_index)) {
		print("[ERROR] An invalid slot was received!");
		print("[WARN] No data was loaded. Previous values will be used.");
		exit;
	}

	// Callback
	var _callback = function(_table, _result) {
		// Start clean when nothing usable was loaded
		if (_table == undefined) {
			_table = data_create(file_define_savedata(), file_define_savedata());
		}

		// Set data
		global.savedata = _table;
		game_apply_savedata();

		// Print message
		file_log_load("Savedata", _result);
	};

	// Load file
	file_load(file_get_folder(FOLDER_SAVES), file_get_slot_name(_index), file_define_savedata(), file_is_savedata_valid, _callback);
}
