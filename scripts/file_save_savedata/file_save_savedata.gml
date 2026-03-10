function file_save_savedata(index) {
	// Early exit
	if (!index or index > MAX_SLOTS) {
		print("[ERROR] An invalid slot was received!");
		print("[WARN] No data was loaded. Previous values will be used.");
		exit;
	}
	
	// Callback
	var callback = function(_status, _buffer) {
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
	var buffer = db_buffer_create(global.savedata);
	
	// Encrypt
	if (ENCRYPT) {
		buffer = file_encrypt_buffer(buffer);
	}

	// Add task to queue
	task_add_item(SAVEDATA, tasks.write);
	
	// Save file
	SparkleSetGroupName("saves");
	return SparkleSave($"slot_{index}" + FILE_EXT, buffer, callback);
}
