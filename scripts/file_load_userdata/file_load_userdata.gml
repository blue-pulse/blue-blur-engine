function file_load_userdata() {
	// Callback
	var _callback = function(_table, _result) {
		// Use the loaded table
		if (_table != undefined) {
			global.userdata = _table;
		}

		// Print message
		file_log_load("Userdata", _result);
	};

	// Load file
	file_load(file_get_folder(FOLDER_CONFIG), USERDATA, file_define_userdata(), file_is_userdata_valid, _callback);
}
