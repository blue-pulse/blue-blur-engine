function file_save_savedata(_index) {
	// Early exit
	if (_index < 1 or _index > MAX_SLOTS) {
		print("[ERROR] An invalid slot was received!");
		print("[WARN] No data was loaded. Previous values will be used.");
		exit;
	}
	
	// Callback
	var _callback = function(_status) {
	    // Clean-up
		task_delete_item(SAVEDATA);
		
	    // File saved successfully
	    if (_status == SPARKLE_STATUS_SUCCESS) {
			print($"[INFO] Savedata was saved successfully!");
	    }
		
		// File failed to save
	    else {
			print($"[ERROR] Savedata save operation exited with error code: {_status}");
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
	SparkleSetGroupName("saves");
	var _operation = SparkleSave($"slot_{_index}" + FILE_EXT, _buffer, _callback);
	
	// Delete the buffer because SparkleStore copies it
	buffer_delete(_buffer);
	return _operation;
}
