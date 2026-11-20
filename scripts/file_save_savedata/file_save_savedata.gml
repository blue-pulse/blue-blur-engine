function file_save_savedata(_index) {
	// Early exit
	if (_index < 1 or _index > MAX_SLOTS) {
		print("[ERROR] An invalid slot was received!");
		print("[WARN] No data was loaded. Previous values will be used.");
		exit;
	}
	
	// Callback
	var _callback = function(_result) {
	    // File saved successfully
	    if (_result == storage_results.success) {
			print($"[INFO] Savedata was saved successfully!");
	    }
		
		// File failed to save
	    else {
			print($"[ERROR] Savedata save operation exited with error code: {_result}");
	    }
	};
	
	// Get buffer
	var _buffer = data_serialize(global.savedata);
	
	// Encrypt
	if (USE_ENCRYPTION) {
		_buffer = cipher_encrypt(_buffer);
	}

	// Save file
	storage_save(file_get_folder(FOLDER_SAVES), file_get_slot_name(_index), _buffer, _callback);
	
	// Delete the buffer because the storage copies it
	buffer_delete(_buffer);
}
