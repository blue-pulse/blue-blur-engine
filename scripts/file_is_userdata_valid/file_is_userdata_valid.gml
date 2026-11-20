function file_is_userdata_valid(_table) {
	// Variables
	var _slot = data_read(_table, ["slot"]);

	// Return value
	return (is_real(_slot) and file_is_slot_valid(_slot));
}
