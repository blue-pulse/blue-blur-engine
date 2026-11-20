function file_load_settings() {
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

	    // File loaded successfully
	    if (_data != undefined) {
	    	global.settings = _data;
			print("[INFO] Settings loaded successfully!");
	    }
		
		// File failed to load
		else {
			print($"[ERROR] Settings load operation exited with error code: {_result}");
	    }
	};
	
	// Load file
	storage_load(file_get_folder(FOLDER_CONFIG), SETTINGS, _callback);
}
