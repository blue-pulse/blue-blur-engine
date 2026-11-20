function file_save_settings() {
	// Callback
	var _callback = function(_result) {
	    // Clean-up
		task_delete_item(SETTINGS);
		
	    // File saved successfully
	    if (_result == storage_results.success) {
			print($"[INFO] Settings were saved successfully!");
	    }
		
		// File failed to save
	    else {
			print($"[ERROR] Settings save operation exited with error code: {_result}");
	    }
	};
	
	// Get buffer
	var _buffer = data_serialize(global.settings);
	
	// Encrypt
	if (USE_ENCRYPTION) {
		_buffer = cipher_encrypt(_buffer);
	}
	
	// Add task to queue
	task_add_item(SETTINGS, tasks.write);

	// Save file
	storage_save(file_get_folder(FOLDER_CONFIG), SETTINGS, _buffer, _callback);
	
	// Delete the buffer because the storage copies it
	buffer_delete(_buffer);
}
