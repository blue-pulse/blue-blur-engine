function file_save_savedata(_index) {
	// Early exit
	if (!_index or _index > MAX_SLOTS) {
		print("[ERROR] An invalid slot was received!");
		print("[WARN] No data was loaded. Previous values will be used.");
		exit;
	}
	
	// Callback
	var _callback = function(_status, _buffer) {
	    // Clean-up
	    buffer_delete(_buffer);
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
	var _buffer = db_buffer_create(global.savedata);
	
	// Encrypt
	if (ENCRYPT) {
		_buffer = file_encrypt_buffer(_buffer);
	}

	// Add task to queue
	task_add_item(SAVEDATA, tasks.write);
	
	// Save file
	SparkleSetGroupName("saves");
	return SparkleSave($"slot_{_index}" + FILE_EXT, _buffer, _callback);
}
