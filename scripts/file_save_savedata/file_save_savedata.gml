function file_save_savedata(_index) {
	// Early exit
	if (_index < 1 or _index > MAX_SLOTS) {
		print("[ERROR] An invalid slot was received!");
		print("[WARN] No data was loaded. Previous values will be used.");
		exit;
	}
	
	// Callback
	var _callback = function(_result) {
	    // Clean-up
		task_delete_item(SAVEDATA);
		
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

	// Add task to queue
	task_add_item(SAVEDATA, tasks.write);
	
	// Save file
	storage_save(file_get_folder("saves"), $"slot_{_index}" + FILE_EXT, _buffer, _callback);
	
	// Delete the buffer because the storage copies it
	buffer_delete(_buffer);
}
