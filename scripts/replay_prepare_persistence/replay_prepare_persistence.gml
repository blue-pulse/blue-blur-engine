function replay_prepare_persistence() {
	// Early exit
	var _scenario = replay_define_scenarios()[$ REPLAY_SCENARIO];
	if (_scenario[$ "kind"] != "persistence") {
		exit;
	}

	// Delete the files of an earlier run
	var _paths = replay_list_files();
	for (var _i = 0; _i < array_length(_paths); _i++) {
		file_delete(_paths[_i]);
	}

	// Replace the files that the scenario damages
	var _damaged = _scenario[$ "damaged"] ?? [];
	for (var _i = 0; _i < array_length(_damaged); _i++) {
		var _folder = file_get_folder(_damaged[_i].folder);
		if (!directory_exists(_folder)) {
			directory_create(_folder);
		}
		var _buffer = buffer_create(4, buffer_fixed, 1);
		buffer_write(_buffer, buffer_text, "hola");
		buffer_save(_buffer, $"{_folder}/{_damaged[_i].name}");
		buffer_delete(_buffer);
	}

	// Observe the game until the scenario ends
	manager_create(obj_replay_persistence);
}
