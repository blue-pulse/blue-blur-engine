function file_save_userdata() {
	// Callback
	var _callback = function(_result) {
	    // Clean-up
		task_delete_item(USERDATA);
		
	    // File saved successfully
	    if (_result == storage_results.success) {
			print($"[INFO] Userdata was saved successfully!");
	    }
		
		// File failed to save
	    else {
			print($"[ERROR] Userdata save operation exited with error code: {_result}");
	    }
	};
	
	// Get buffer
	var _buffer = data_serialize(global.userdata);
	
	// Encrypt
	if (USE_ENCRYPTION) {
		_buffer = cipher_encrypt(_buffer);
	}

	// Add task to queue
	task_add_item(USERDATA, tasks.write);
	
	// Save file
	storage_save(file_get_folder(FOLDER_CONFIG), USERDATA, _buffer, _callback);
	
	// Delete the buffer because the storage copies it
	buffer_delete(_buffer);
}
