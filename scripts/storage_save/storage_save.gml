function storage_save(_folder, _name, _buffer, _callback) {
	// Report the result to the caller
	static report = function(_status, _callback) {
		_callback(storage_get_result(_status));
	};

	// Save a copy of the buffer
	SparkleSetGroupName(_folder);
	SparkleSave(_name, _buffer, report, _callback);
}
