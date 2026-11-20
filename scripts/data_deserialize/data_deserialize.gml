function data_deserialize(_buffer, _default_data) {
	// Read buffer
	var _table = db_buffer_read(_buffer);

	// Set defaults
	if (_table != undefined) {
		db_set_default_data(_table, _default_data);
	}

	// Return value
	return _table;
}
