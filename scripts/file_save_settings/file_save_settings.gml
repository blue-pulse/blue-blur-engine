function file_save_settings() {
	// Callback
	var _callback = function(_result) {
		file_log_save("Settings", _result);
	};

	// Save file
	file_save(file_get_folder(FOLDER_CONFIG), SETTINGS, global.settings, _callback);
}
