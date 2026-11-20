function file_is_savedata_valid(_table) {
	// Variables
	var _character = data_read(_table, ["character"]);
	var _life = data_read(_table, ["life"]);
	var _position = data_read(_table, ["position"]);

	// Check character
	if (!is_handle(_character) or !object_exists(_character)) {
		return false;
	}

	// Check lives
	if (!is_real(_life) or _life < 1) {
		return false;
	}

	// Return value
	return (
		is_array(_position) and
		array_length(_position) == 2 and
		is_real(_position[0]) and
		is_real(_position[1])
	);
}
