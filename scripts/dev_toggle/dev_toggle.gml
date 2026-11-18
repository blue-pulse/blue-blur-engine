function dev_toggle() {
	// Close the tools
	if (instance_exists(obj_dev_overlay)) {
		instance_destroy(obj_dev_overlay);
		instance_destroy(obj_dev_commands);
		exit;
	}

	// Open the tools
	gui_create(obj_dev_overlay);
	gui_create(obj_dev_commands);
}
