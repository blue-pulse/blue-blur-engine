function file_load_savedata(_index) {
	// Callback
	var _callback = function(_status, _buffer) {
		// Variables
		var _data = undefined;
		
		// Read file
		if (_status) {
			if (ENCRYPT) {
				_buffer = file_decrypt_buffer(_buffer);
			}
			_data = db_buffer_read(_buffer);
		}

	    // Clean up
	    buffer_destroy(_buffer);
		task_delete_item(SAVEDATA);

	    // File loaded successfully
	    if (_data != undefined) {
			// Set data
	    	global.savedata = _data;
			
			// Set parameters
			var _params = db_read(global.savedata, {});
			global.character = _params.character;
			global.lives = _params.life;
			global.checkpoint.hub_pos = _params.position;
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
	return SparkleLoad($"slot_{_index}" + FILE_EXT, _callback);
}
