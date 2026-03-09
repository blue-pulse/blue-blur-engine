function file_load_savedata(index) {
	// Callback
	var callback = function(_status, _buffer) {
		// Variables
		if (ENCRYPT) {
			_buffer = file_decrypt_buffer(_buffer);
		}
	    var data = (_status) ? (db_buffer_read(_buffer)) : (undefined);
		
	    // Clean up
	    buffer_delete(_buffer);
		task_delete_item(SAVEDATA);

	    // File loaded successfully
	    if (data != undefined) {
	    	global.savedata = data;
			global.slot = db_read(data, -1, "slot");
			print("[INFO] Savedata loaded successfully!");
	    }
		
		// File failed to load
		else {
			global.slot = -1;
			print($"[ERROR] Savedata load operation exited with error code: {_status}");	
	    }
	};
	
	// Add task to queue
	task_add_item(SAVEDATA, tasks.read);
	
	// Load file
	SparkleSetGroupName("saves");
	return SparkleLoad($"slot_{index}" + FILE_EXT, callback);
}
