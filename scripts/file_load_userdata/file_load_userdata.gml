function file_load_userdata() {
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
		task_delete_item(USERDATA);

	    // File loaded successfully
	    if (data != undefined) {
	    	global.userdata = data;
			print("[INFO] Userdata loaded successfully!");
	    }
		
		// File failed to load
		else {
			print($"[ERROR] Userdata load operation exited with error code: {_status}");
	    }
	};
	
	// Add task to queue
	task_add_item(USERDATA, tasks.read);
	
	// Load file
	SparkleSetGroupName("config");
	return SparkleLoad(USERDATA, callback);
}
