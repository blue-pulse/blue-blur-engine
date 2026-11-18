function dev_command_restart_room() {
	// Early exit
	if (scene_is_changing()) {
		exit;
	}
	
	// Fade to the same room
	scene_change(room);
}
