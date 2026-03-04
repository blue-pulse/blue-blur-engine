// Early exit
if (!allow_gameplay) {
	exit;
}

// Create pause manager
if (!instance_exists(obj_pause_manager)) {
	gui_create(obj_pause_manager);
}
