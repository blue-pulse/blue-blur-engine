function file_load_userdata() {
	// Callback
	var _callback = function(_result, _buffer) {
		// Variables
		var _data = undefined;
		
		// Read file
		if (_result == storage_results.success) {
			if (USE_ENCRYPTION) {
				_buffer = cipher_decrypt(_buffer);
			}
			_data = data_deserialize(_buffer);
		}

	    // Clean up
	    buffer_destroy(_buffer);
		task_delete_item(USERDATA);

	    // File loaded successfully
	    if (_data != undefined) {
	    	global.userdata = _data;
			print("[INFO] Userdata loaded successfully!");
	    }
		
		// File failed to load
		else {
			print($"[ERROR] Userdata load operation exited with error code: {_result}");
	    }
	};
	
	// Add task to queue
	task_add_item(USERDATA, tasks.read);
	
	// Load file
	storage_load("config", USERDATA, _callback);
}
