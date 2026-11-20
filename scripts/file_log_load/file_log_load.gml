function file_log_load(_label, _result) {
	// File loaded successfully
	if (_result == file_results.loaded) {
		print($"[INFO] {_label} loaded successfully!");
		exit;
	}

	// File was never written
	if (_result == file_results.missing) {
		print($"[INFO] {_label} file was not found, so the defaults are used. This is normal on a first run.");
		exit;
	}

	// File could not be read
	print($"[ERROR] {_label} file could not be read, so the defaults are used. It may be damaged or written with another key.");
}
