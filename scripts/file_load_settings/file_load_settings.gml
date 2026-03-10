function file_load_settings() {
	// Callback
	var callback = function(_status, _buffer) {
		// Variables
		var data = undefined;
		
		// Read file
		if (_status) {
			if (ENCRYPT) {
				_buffer = file_decrypt_buffer(_buffer);
			}
			data = db_buffer_read(_buffer);
		}

	    // Clean up
	    buffer_delete(_buffer);
		task_delete_item(SETTINGS);

	    // File loaded successfully
	    if (data != undefined) {
	    	global.settings = data;
			print("[INFO] Settings loaded successfully!");
	    }
		
		// File failed to load
		else {
			print($"[ERROR] Settings load operation exited with error code: {_status}");
	    }
	};
	
	// Add task to queue
	task_add_item(SETTINGS, tasks.read);
	
	// Load file
	SparkleSetGroupName("config");
	return SparkleLoad(SETTINGS, callback);
}
