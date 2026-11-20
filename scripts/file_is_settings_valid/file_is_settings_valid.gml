function file_is_settings_valid(_table) {
	// Early exit
	if (!is_struct(data_read(_table, ["graphics"]))) {
		return false;
	}

	// Return value
	return (
		is_bool(data_read(_table, ["graphics", "fullscreen"])) and
		is_bool(data_read(_table, ["graphics", "upscaling"])) and
		is_real(data_read(_table, ["graphics", "antialiasing"]))
	);
}
