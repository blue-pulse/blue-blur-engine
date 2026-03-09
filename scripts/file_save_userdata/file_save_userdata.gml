function file_save_userdata() {
	// Callback
	var callback = function(_status, _buffer) {
	    // Clean-up
	    buffer_delete(_buffer);
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
	var buffer = db_buffer_create(global.userdata);
	
	// Encrypt
	if (ENCRYPT) {
		buffer = file_encrypt_buffer(buffer);
	}

	// Add task to queue
	task_add_item(USERDATA, tasks.write);
	
	// Save file
	SparkleSetGroupName("config");
	return SparkleSave(USERDATA, buffer, callback);
}
