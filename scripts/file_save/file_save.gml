function file_save(_folder, _name, _table, _callback) {
	// Get buffer
	var _buffer = data_serialize(_table);

	// Encrypt
	if (USE_ENCRYPTION) {
		var _plain = _buffer;
		_buffer = cipher_encrypt(_plain);
		buffer_delete(_plain);
	}

	// Save file
	storage_save(_folder, _name, _buffer, _callback);

	// Delete the buffer because the storage copies it
	buffer_delete(_buffer);
}
