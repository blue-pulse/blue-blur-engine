function file_save_settings() {
	// Callback
	var _callback = function(_status) {
	    // Clean-up
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
	var _buffer = data_serialize(global.settings);
	
	// Encrypt
	if (USE_ENCRYPTION) {
		_buffer = file_encrypt_buffer(_buffer);
	}
	
	// Add task to queue
	task_add_item(SETTINGS, tasks.write);

	// Save file
	SparkleSetGroupName("config");
	var _operation = SparkleSave(SETTINGS, _buffer, _callback);
	
	// Delete the buffer because SparkleStore copies it
	buffer_delete(_buffer);
	return _operation;
}
