function file_save_settings() {
	// Callback
	var callback = function(_status, _buffer) {
	    // Clean-up
	    buffer_delete(_buffer);
		task_delete_item(SETTINGS);
		
	    // File saved successfully
	    if (_status == SPARKLE_STATUS_SUCCESS) {
			print($"[INFO] Settings were saved successfully!");
	    }
		
		// File failed to save
	    else {
			print($"[ERROR] Settings save operation exited with error code: {_status}");
	    }
	};
	
	// Get buffer
	var buffer = db_buffer_create(global.settings);
	
	// Encrypt
	if (ENCRYPT) {
		buffer = file_encrypt_buffer(buffer);
	}
	
	// Add task to queue
	task_add_item(SETTINGS, tasks.write);

	// Save file
	SparkleSetGroupName("config");
	return SparkleSave(SETTINGS, buffer, callback);
}
