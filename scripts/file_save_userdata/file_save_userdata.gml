function file_save_userdata() {
	// Callback
	var _callback = function(_status) {
	    // Clean-up
		task_delete_item(USERDATA);
		
	    // File saved successfully
	    if (_status == SPARKLE_STATUS_SUCCESS) {
			print($"[INFO] Userdata was saved successfully!");
	    }
		
		// File failed to save
	    else {
			print($"[ERROR] Userdata save operation exited with error code: {_status}");
	    }
	};
	
	// Get buffer
	var _buffer = data_serialize(global.userdata);
	
	// Encrypt
	if (USE_ENCRYPTION) {
		_buffer = file_encrypt_buffer(_buffer);
	}

	// Add task to queue
	task_add_item(USERDATA, tasks.write);
	
	// Save file
	SparkleSetGroupName("config");
	var _operation = SparkleSave(USERDATA, _buffer, _callback);
	
	// Delete the buffer because SparkleStore copies it
	buffer_delete(_buffer);
	return _operation;
}
