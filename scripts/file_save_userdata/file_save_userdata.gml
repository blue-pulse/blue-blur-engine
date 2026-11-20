function file_save_userdata() {
	// Callback
	var _callback = function(_result) {
		file_log_save("Userdata", _result);
	};

	// Save file
	file_save(file_get_folder(FOLDER_CONFIG), USERDATA, global.userdata, _callback);
}
