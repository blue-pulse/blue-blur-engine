function file_load_savedata(_index) {
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
		task_delete_item(SAVEDATA);

	    // File loaded successfully
	    if (_data != undefined) {
			// Set data
	    	global.savedata = _data;
			
			// Set parameters
			var _params = data_read(global.savedata) ?? {};
			global.character = _params.character;
			global.lives = _params.life;
			global.checkpoint.hub_pos = _params.position;
			print("[INFO] Savedata loaded successfully!");
	    }
		
		// File failed to load
		else {
			print($"[ERROR] Savedata load operation exited with error code: {_result}");	
	    }
	};
	
	// Add task to queue
	task_add_item(SAVEDATA, tasks.read);
	
	// Load file
	storage_load(file_get_folder(FOLDER_SAVES), file_get_slot_name(_index), _callback);
}
