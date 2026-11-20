function file_load(_folder, _name, _defaults, _validator, _callback) {
	// Callback
	var _report = method({ defaults: _defaults, validator: _validator, callback: _callback }, function(_result, _buffer) {
		// Missing file
		if (_result != storage_results.success) {
			buffer_destroy(_buffer);
			callback(undefined, file_results.missing);
			exit;
		}

		// Decrypt
		var _bytes = _buffer;
		if (USE_ENCRYPTION) {
			_bytes = cipher_decrypt(_buffer);
			buffer_destroy(_buffer);
		}

		// Read table
		var _table = undefined;
		if (buffer_exists(_bytes)) {
			_table = data_deserialize(_bytes, defaults);
			buffer_delete(_bytes);
		}

		// Damaged file
		if (_table == undefined or !is_struct(data_read(_table)) or !validator(_table)) {
			callback(undefined, file_results.damaged);
			exit;
		}

		// Loaded file
		callback(_table, file_results.loaded);
	});

	// Load file
	storage_load(_folder, _name, _report);
}
