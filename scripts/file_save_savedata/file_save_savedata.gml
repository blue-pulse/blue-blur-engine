function file_save_savedata(_index) {
	// Early exit
	if (!file_is_slot_valid(_index)) {
		print("[ERROR] An invalid slot was received!");
		print("[WARN] No data was saved.");
		exit;
	}

	// Callback
	var _callback = function(_result) {
		file_log_save("Savedata", _result);
	};

	// Save file
	file_save(file_get_folder(FOLDER_SAVES), file_get_slot_name(_index), global.savedata, _callback);
}
