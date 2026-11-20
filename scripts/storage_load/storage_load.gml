function storage_load(_folder, _name, _callback) {
	// Report the result and hand the buffer to the caller
	static report = function(_status, _buffer, _callback) {
		_callback(storage_get_result(_status), _buffer);
	};

	// Load file
	SparkleSetGroupName(_folder);
	SparkleLoad(_name, report, _callback);
}
