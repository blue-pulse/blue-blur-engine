function file_load_savedata(index) {
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
	    buffer_destroy(_buffer);
		task_delete_item(SAVEDATA);

	    // File loaded successfully
	    if (data != undefined) {
			// Set data
	    	global.savedata = data;
			
			// Set parameters
			var params = db_read(global.savedata, {});
			global.character = params.character;
			global.lives = params.life;
			global.checkpoint.hub_pos = params.position;
			print("[INFO] Savedata loaded successfully!");
	    }
		
		// File failed to load
		else {
			print($"[ERROR] Savedata load operation exited with error code: {_status}");	
	    }
	};
	
	// Add task to queue
	task_add_item(SAVEDATA, tasks.read);
	
	// Load file
	SparkleSetGroupName("saves");
	return SparkleLoad($"slot_{index}" + FILE_EXT, callback);
}
