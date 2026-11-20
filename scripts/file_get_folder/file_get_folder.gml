function file_get_folder(_folder) {
	// Keep a replay away from the real saves
	if (REPLAY_SCENARIO != "") {
		return "replay_" + _folder;
	}

	// Return value
	return _folder;
}
