function file_log_save(_label, _result) {
	// File saved successfully
	if (_result == storage_results.success) {
		print($"[INFO] {_label} was saved successfully!");
		exit;
	}

	// Save was replaced by a newer one
	if (_result == storage_results.cancelled) {
		print($"[INFO] {_label} save was replaced by a newer one.");
		exit;
	}

	// File failed to save
	print($"[ERROR] {_label} could not be saved, so the game keeps the data in memory.");
}
