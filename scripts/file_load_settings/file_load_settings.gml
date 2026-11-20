function file_load_settings() {
	// Callback
	var _callback = function(_table, _result) {
		// Use the loaded table
		if (_table != undefined) {
			global.settings = _table;
		}

		// Print message
		file_log_load("Settings", _result);
	};

	// Load file
	file_load(file_get_folder(FOLDER_CONFIG), SETTINGS, file_define_settings(), file_is_settings_valid, _callback);
}
