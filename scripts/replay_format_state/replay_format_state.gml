function replay_format_state(_paths) {
	// Variables
	var _hub = global.checkpoint.get_hub();
	var _line = $"room {room_get_name(room)} slot {global.slot} lives {global.lives}";
	_line += $" hub {_hub[0]},{_hub[1]} character {object_get_name(global.character)} files";

	// List the files that exist
	for (var _i = 0; _i < array_length(_paths); _i++) {
		if (file_exists(_paths[_i])) {
			_line += " " + _paths[_i];
		}
	}

	// Return value
	return _line;
}
